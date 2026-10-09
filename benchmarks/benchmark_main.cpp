#include "gemm/kernels.hpp"
#include "accelerate_adapter.hpp"
#include "gemm/matrix.hpp"

#include <algorithm>
#include <charconv>
#include <chrono>
#include <cmath>
#include <iomanip>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>

namespace {
std::size_t positive_integer(const std::string& value) {
    std::size_t result = 0;
    const auto parsed = std::from_chars(value.data(), value.data() + value.size(), result);
    if (parsed.ec != std::errc{} || parsed.ptr != value.data() + value.size() || result == 0)
        throw std::invalid_argument("Expected a positive integer: " + value);
    return result;
}

double checksum(const gemm::Matrix& C) {
    double sum = 0;
    for (std::size_t i = 0; i < C.rows() * C.cols(); ++i) sum += C.data()[i];
    return sum;
}

template <typename Function>
void benchmark(const char* name, Function function, std::size_t M, std::size_t N,
               std::size_t K, std::size_t repetitions, gemm::BlockSize tile,
               std::size_t MR = 0, std::size_t NR = 0, std::size_t unroll = 0,
               std::size_t threads = 1, const char* schedule = "none",
               std::size_t requested_threads = 1,
               std::size_t profile_seconds = 0, bool profile_wait = false) {
    // BENCHMARK-IMPORTANT: Allocate, initialize with fixed seeds, and compute
    // the reference outside timing so only the kernel contributes to latency.
    gemm::Matrix A(M, K), B(K, N), C(M, N), expected(M, N);
    gemm::fill_random(A, 42);
    gemm::fill_random(B, 43);
    gemm::reference(A.data(), B.data(), expected.data(), M, N, K);

    // BENCHMARK-IMPORTANT: Validate an untimed warmup before reporting speed.
    // Reusing these buffers measures warmed execution, not cold-cache latency.
    function(A.data(), B.data(), C.data(), M, N, K);
    for (std::size_t i = 0; i < M * N; ++i) {
        if (!std::isfinite(C.data()[i]) || !std::isfinite(expected.data()[i]) ||
            std::abs(C.data()[i] - expected.data()[i]) >
                1e-4f + 1e-4f * std::abs(expected.data()[i]))
            throw std::runtime_error(std::string(name) + " correctness check failed");
    }

    if (profile_seconds) {
        // BENCHMARK-IMPORTANT: Signal readiness only after allocation, reference,
        // and warmup validation. A collector may gate execution through stdin.
        std::cerr << "PROFILE_READY\n" << std::flush;
        if (profile_wait) {
            std::string command;
            if (!std::getline(std::cin, command) || command != "GO")
                throw std::runtime_error("Profiling requires GO on stdin");
        }
        const auto start = std::chrono::steady_clock::now();
        auto end = start;
        std::size_t calls = 0;
        // BENCHMARK-IMPORTANT: Sustain the unchanged whole GEMM call. Check
        // elapsed time once per call; omit per-call checksums from the sampled
        // loop. Separate translation units and no LTO preserve repeated calls.
        do {
            function(A.data(), B.data(), C.data(), M, N, K);
            ++calls;
            end = std::chrono::steady_clock::now();
        } while (std::chrono::duration<double>(end - start).count() < profile_seconds);
        std::cerr << "PROFILE_DONE\n" << std::flush;
        const double seconds = std::chrono::duration<double>(end - start).count();
        // BENCHMARK-IMPORTANT: Validate/consume final output after the interval.
        // Sustained average throughput is not the ordinary benchmark's median.
        for (std::size_t i = 0; i < M * N; ++i) {
            if (!std::isfinite(C.data()[i]) || std::abs(C.data()[i] - expected.data()[i]) >
                1e-4f + 1e-4f * std::abs(expected.data()[i]))
                throw std::runtime_error("Post-profile correctness check failed");
        }
        const double flops = 2.0 * static_cast<double>(M) * N * K * calls;
        std::cout << name << ',' << M << ',' << N << ',' << K << ',' << calls << ','
                  << seconds << ',' << flops / seconds / 1e9 << ',' << checksum(C) << ','
                  << threads << ',' << requested_threads << ',' << schedule << ','
                  << tile.m << ',' << tile.n << ',' << tile.k << ',' << MR << ',' << NR
                  << ',' << unroll << '\n';
        return;
    }

    // BENCHMARK-IMPORTANT: Reserve samples before timing; repeated calls use
    // the same buffers and avoid relying on a single noisy measurement.
    std::vector<double> timings;
    timings.reserve(repetitions);
    double consumed = 0;
    for (std::size_t run = 0; run < repetitions; ++run) {
        // BENCHMARK-IMPORTANT: Time the complete C=AB call, including any
        // required zeroing. Dispatch is outside the hot multiplication loops.
        const auto start = std::chrono::steady_clock::now();
        function(A.data(), B.data(), C.data(), M, N, K);
        const auto end = std::chrono::steady_clock::now();
        timings.push_back(std::chrono::duration<double>(end - start).count());
        // BENCHMARK-IMPORTANT: Consume every output in the printed checksum
        // outside timing. These reads also affect cache state for the next run.
        consumed += checksum(C);
    }
    // BENCHMARK-IMPORTANT: Report the median; for even counts average the
    // middle pair. This reduces sensitivity to isolated slow samples.
    std::sort(timings.begin(), timings.end());
    const auto middle = timings.size() / 2;
    const double seconds = timings.size() % 2 ? timings[middle] :
        (timings[middle - 1] + timings[middle]) / 2;
    if (seconds <= 0) throw std::runtime_error("Timer resolution too low for this size");
    // BENCHMARK-IMPORTANT: Conventional GEMM work is 2*M*N*K FLOPs. Cast before
    // multiplication to avoid integer overflow; divide by seconds and 1e9 below.
    const double operations = 2.0 * static_cast<double>(M) *
        static_cast<double>(N) * static_cast<double>(K);
    std::cout << name << ',' << M << ',' << N << ',' << K << ','
              << seconds * 1000.0 << ',' << operations / seconds / 1e9 << ','
              << repetitions << ",1," << threads << ",42,43," << consumed << ','
              << tile.m << ',' << tile.n << ',' << tile.k << ',' << MR << ',' << NR << ',' << unroll << ',' << schedule << ',' << requested_threads << '\n';
}
} // namespace

int main(int argc, char** argv) {
    try {
        std::size_t repetitions = 5;
        std::string implementation = "all";
        std::vector<std::size_t> sizes;
        gemm::BlockSize tile{64, 64, 64};
        gemm::BlockSize shape{0, 0, 0};
        bool tile_given = false, micro_given = false;
        std::size_t MR = 4, NR = 4, unroll = 1;
        bool unroll_given = false, parallel_given = false;
        std::size_t threads = 1, profile_seconds = 0;
        bool profile_wait = false;
        std::string schedule = "static";
        for (int i = 1; i < argc; ++i) {
            const std::string arg = argv[i];
            if (arg == "--help") {
                std::cout << "Usage: gemm_benchmark [--repetitions COUNT] [--implementation NAME] [SIZE ...]\n"
                             "Defaults: all implementations; 5 repetitions; sizes 64 128 256 512 1024.\n"
                             "Names: all (six loop orders), naive_ijk ikj jik jki kij kji blocked microkernel neon_4x4 parallel accelerate (optional)\n"
                             "Blocked options: --bm M --bn N --bk K (defaults 64 each)\n"
                             "Microkernel options: --mr M --nr N (default 4x4; 2x4,4x4,4x8,8x4,8x8,16x16)\n"
                             "Unrolling: --unroll 1|2|4|8 (microkernel only; >1 requires 4x4)\n"
                             "Parallel options: --threads COUNT --schedule static|dynamic (defaults 1/static)\n"
                             "Profiling: --profile-seconds SECONDS [--profile-wait] (one kernel/shape only)\n"
                             "Rectangular input: --shape M N K (instead of SIZE arguments)\n";
                return 0;
            }
            if (arg == "--profile-seconds") {
                if (++i == argc) throw std::invalid_argument("Missing profile duration");
                profile_seconds = positive_integer(argv[i]);
                if (profile_seconds > 3600) throw std::invalid_argument("Profile duration exceeds 3600 seconds");
            } else if (arg == "--profile-wait") {
                profile_wait = true;
            } else if (arg == "--repetitions") {
                if (++i == argc) throw std::invalid_argument("Missing repetition count");
                repetitions = positive_integer(argv[i]);
            } else if (arg == "--implementation") {
                if (++i == argc) throw std::invalid_argument("Missing implementation name");
                implementation = argv[i];
            } else if (arg == "--bm" || arg == "--bn" || arg == "--bk") {
                if (++i == argc) throw std::invalid_argument("Missing block dimension");
                const auto value = positive_integer(argv[i]);
                if (arg == "--bm") tile.m = value;
                if (arg == "--bn") tile.n = value;
                if (arg == "--bk") tile.k = value;
                tile_given = true;
            } else if (arg == "--mr" || arg == "--nr") {
                if (++i == argc) throw std::invalid_argument("Missing microtile dimension");
                const auto value = positive_integer(argv[i]);
                if (arg == "--mr") MR = value;
                else NR = value;
                micro_given = true;
            } else if (arg == "--unroll") {
                if (++i == argc) throw std::invalid_argument("Missing unroll factor");
                unroll = positive_integer(argv[i]);
                unroll_given = true;
            } else if (arg == "--threads" || arg == "--schedule") {
                if (++i == argc) throw std::invalid_argument("Missing parallel option value");
                if (arg == "--threads") threads = positive_integer(argv[i]);
                else schedule = argv[i];
                parallel_given = true;
            } else if (arg == "--shape") {
                if (shape.m != 0 || argc - i <= 3)
                    throw std::invalid_argument("Specify one --shape M N K");
                shape.m = positive_integer(argv[++i]);
                shape.n = positive_integer(argv[++i]);
                shape.k = positive_integer(argv[++i]);
            } else {
                sizes.push_back(positive_integer(arg));
            }
        }
        if (parallel_given && implementation != "parallel")
            throw std::invalid_argument("Thread/schedule options require parallel");
        if (schedule != "static" && schedule != "dynamic")
            throw std::invalid_argument("Schedule must be static or dynamic");
        std::vector<gemm::Kernel> selected;
        for (const auto& kernel : gemm::kernels) {
            if (implementation == "all" || implementation == kernel.name)
                selected.push_back(kernel);
        }
        if (unroll_given && implementation != "microkernel")
            throw std::invalid_argument("Unroll requires microkernel");
        if (implementation == "microkernel" &&
            ((unroll != 1 && unroll != 2 && unroll != 4 && unroll != 8) ||
             (unroll != 1 && (MR != 4 || NR != 4))))
            throw std::invalid_argument("Unroll 2/4/8 requires a 4x4 microtile");
        if (micro_given && implementation != "microkernel")
            throw std::invalid_argument("Microtile options require --implementation microkernel");
        if (tile_given && implementation != "blocked" && implementation != "microkernel" && implementation != "parallel" && implementation != "neon_4x4")
            throw std::invalid_argument("Block options require blocked, microkernel, neon_4x4, or parallel");
        if (shape.m != 0 && !sizes.empty())
            throw std::invalid_argument("Do not mix --shape and square sizes");
        if (selected.empty() && implementation != "blocked" && implementation != "microkernel" && implementation != "parallel" && implementation != "neon_4x4" && implementation != "accelerate") throw std::invalid_argument("Unknown implementation: " + implementation);
        if (profile_wait && !profile_seconds)
            throw std::invalid_argument("--profile-wait requires --profile-seconds");
        if (profile_seconds && (implementation == "all" ||
            (shape.m == 0 && sizes.size() != 1)))
            throw std::invalid_argument("Profiling requires one explicit kernel and shape");
        if (sizes.empty()) sizes = {64, 128, 256, 512, 1024};
        std::cout << std::setprecision(12);
        if (profile_seconds)
            std::cout << "implementation,M,N,K,calls,seconds,average_gflops,checksum,threads,requested_threads,schedule,BM,BN,BK,MR,NR,unroll\n";
        else std::cout << "implementation,M,N,K,time_ms,gflops,repetitions,warmups,threads,seed_A,seed_B,checksum,BM,BN,BK,MR,NR,unroll,schedule,requested_threads\n";
        const auto run = [&](std::size_t M, std::size_t N, std::size_t K) {
            if (implementation == "accelerate") {
                // BENCHMARK-IMPORTANT: Zero means unknown library worker count,
                // not single-thread. The evaluation runner records environment policy.
                benchmark("accelerate", benchmark_support::accelerate, M, N, K,
                          repetitions, {0, 0, 0}, 0, 0, 0, 0, "library-managed", 0,
                          profile_seconds, profile_wait);
            } else if (implementation == "neon_4x4") {
                const auto function = [tile](const float* A, const float* B, float* C,
                                             std::size_t m, std::size_t n, std::size_t k) {
                    gemm::neon_4x4(A, B, C, m, n, k, tile);
                };
                benchmark("neon_4x4", function, M, N, K, repetitions, tile, 4, 4, 1,
                          1, "none", 1, profile_seconds, profile_wait);
            } else if (implementation == "parallel") {
                const auto policy = schedule == "static" ? gemm::Schedule::Static : gemm::Schedule::Dynamic;
                const auto function = [tile, threads, policy](const float* A, const float* B, float* C,
                                                             std::size_t m, std::size_t n, std::size_t k) {
                    gemm::parallel(A, B, C, m, n, k, tile, threads, policy);
                };
                // BENCHMARK-IMPORTANT: Record both requested and capped worker
                // counts; the caller is one worker. No persistent pool is used.
                benchmark("parallel", function, M, N, K, repetitions, tile, 0, 0, 0,
                          std::min(threads, 1 + (M - 1) / tile.m), schedule.c_str(), threads, profile_seconds, profile_wait);
            } else if (implementation == "microkernel") {
                const auto function = [tile, MR, NR, unroll](const float* A, const float* B, float* C,
                                                    std::size_t m, std::size_t n, std::size_t k) {
                    gemm::microkernel(A, B, C, m, n, k, tile, MR, NR, unroll);
                };
                benchmark("microkernel", function, M, N, K, repetitions, tile, MR, NR, unroll, 1, "none", 1, profile_seconds, profile_wait);
            } else if (implementation == "blocked") {
                const auto function = [tile](const float* A, const float* B, float* C,
                                             std::size_t m, std::size_t n, std::size_t k) {
                    gemm::blocked(A, B, C, m, n, k, tile);
                };
                benchmark("blocked", function, M, N, K, repetitions, tile, 0, 0, 0, 1, "none", 1, profile_seconds, profile_wait);
            } else {
                for (const auto& kernel : selected)
                    benchmark(kernel.name, kernel.function, M, N, K, repetitions, {0, 0, 0}, 0, 0, 0, 1, "none", 1, profile_seconds, profile_wait);
            }
        };
        if (shape.m != 0) run(shape.m, shape.n, shape.k);
        else for (auto size : sizes) run(size, size, size);
    } catch (const std::exception& error) {
        std::cerr << "Error: " << error.what() << '\n';
        return 1;
    }
}
