#include "gemm/kernels.hpp"
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
               std::size_t MR = 0, std::size_t NR = 0, std::size_t unroll = 0) {
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
              << repetitions << ",1,1,42,43," << consumed << ','
              << tile.m << ',' << tile.n << ',' << tile.k << ',' << MR << ',' << NR << ',' << unroll << '\n';
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
        bool unroll_given = false;
        for (int i = 1; i < argc; ++i) {
            const std::string arg = argv[i];
            if (arg == "--help") {
                std::cout << "Usage: gemm_benchmark [--repetitions COUNT] [--implementation NAME] [SIZE ...]\n"
                             "Defaults: all implementations; 5 repetitions; sizes 64 128 256 512 1024.\n"
                             "Names: all (six loop orders), naive_ijk ikj jik jki kij kji blocked microkernel\n"
                             "Blocked options: --bm M --bn N --bk K (defaults 64 each)\n"
                             "Microkernel options: --mr M --nr N (default 4x4; 2x4,4x4,4x8,8x4,8x8,16x16)\n"
                             "Unrolling: --unroll 1|2|4|8 (microkernel only; >1 requires 4x4)\n"
                             "Rectangular input: --shape M N K (instead of SIZE arguments)\n";
                return 0;
            }
            if (arg == "--repetitions") {
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
        if (tile_given && implementation != "blocked" && implementation != "microkernel")
            throw std::invalid_argument("Block options require blocked or microkernel");
        if (shape.m != 0 && !sizes.empty())
            throw std::invalid_argument("Do not mix --shape and square sizes");
        if (selected.empty() && implementation != "blocked" && implementation != "microkernel") throw std::invalid_argument("Unknown implementation: " + implementation);
        if (sizes.empty()) sizes = {64, 128, 256, 512, 1024};
        std::cout << std::setprecision(12)
                  << "implementation,M,N,K,time_ms,gflops,repetitions,warmups,threads,seed_A,seed_B,checksum,BM,BN,BK,MR,NR,unroll\n";
        const auto run = [&](std::size_t M, std::size_t N, std::size_t K) {
            if (implementation == "microkernel") {
                const auto function = [tile, MR, NR, unroll](const float* A, const float* B, float* C,
                                                    std::size_t m, std::size_t n, std::size_t k) {
                    gemm::microkernel(A, B, C, m, n, k, tile, MR, NR, unroll);
                };
                benchmark("microkernel", function, M, N, K, repetitions, tile, MR, NR, unroll);
            } else if (implementation == "blocked") {
                const auto function = [tile](const float* A, const float* B, float* C,
                                             std::size_t m, std::size_t n, std::size_t k) {
                    gemm::blocked(A, B, C, m, n, k, tile);
                };
                benchmark("blocked", function, M, N, K, repetitions, tile);
            } else {
                for (const auto& kernel : selected)
                    benchmark(kernel.name, kernel.function, M, N, K, repetitions, {0, 0, 0});
            }
        };
        if (shape.m != 0) run(shape.m, shape.n, shape.k);
        else for (auto size : sizes) run(size, size, size);
    } catch (const std::exception& error) {
        std::cerr << "Error: " << error.what() << '\n';
        return 1;
    }
}
