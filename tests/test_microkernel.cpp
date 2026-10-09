#include "gemm/gemm.hpp"
#include "gemm/matrix.hpp"

#include <algorithm>
#include <cmath>
#include <iostream>
#include <limits>
#include <stdexcept>
#include <vector>

namespace {
bool active_neon = false;
std::size_t active_mr = 4, active_nr = 4, active_unroll = 1;
void run(const float* A, const float* B, float* C, std::size_t M, std::size_t N,
         std::size_t K, gemm::BlockSize tile) {
    if (active_neon) gemm::neon_4x4(A, B, C, M, N, K, tile);
    else gemm::microkernel(A, B, C, M, N, K, tile, active_mr, active_nr, active_unroll);
}

void require(bool ok, const char* message) {
    if (!ok) throw std::runtime_error(message);
}
void check(std::size_t M, std::size_t N, std::size_t K, gemm::BlockSize tile) {
    gemm::Matrix A(M, K), B(K, N), expected(M, N);
    gemm::fill_random(A, 42);
    gemm::fill_random(B, 43);
    const auto saved_A = A;
    const auto saved_B = B;
    gemm::reference(A.data(), B.data(), expected.data(), M, N, K);
    std::vector<float> storage(M * N + 2, 12345);
    auto* C = storage.data() + 1;
    std::fill_n(C, M * N, std::numeric_limits<float>::quiet_NaN());
    for (int call = 0; call < 2; ++call) {
        run(A.data(), B.data(), C, M, N, K, tile);
        for (std::size_t i = 0; i < M * N; ++i)
            require(std::isfinite(C[i]) && std::abs(C[i] - expected.data()[i]) <=
                        1e-4f + 1e-4f * std::abs(expected.data()[i]), "blocked value mismatch");
        require(storage.front() == 12345 && storage.back() == 12345, "output bounds");
    }
    for (std::size_t i = 0; i < M * K; ++i) require(A.data()[i] == saved_A.data()[i], "A modified");
    for (std::size_t i = 0; i < K * N; ++i) require(B.data()[i] == saved_B.data()[i], "B modified");
}
}

void suite() {
    try {
        const auto huge = std::numeric_limits<std::size_t>::max();
        // PERF-SEMANTICS: Exercise independent tile tails, exact boundaries,
        // oversized tiles, and K split across tiles (partial sums must survive).
        for (auto tile : {gemm::BlockSize{1, 1, 1}, {2, 3, 4}, {8, 8, 8},
                          {16, 32, 8}, {64, 64, 64}, {256, 128, 64}, {huge, huge, huge}}) {
            for (auto shape : {gemm::BlockSize{1, 1, 1}, {2, 2, 3}, {7, 9, 11},
                               {16, 32, 8}, {17, 33, 9}, {65, 63, 67}, {1, 17, 7},
                               {13, 1, 9}, {3, 5, 0}, {0, 5, 3}, {3, 0, 5}})
                check(shape.m, shape.n, shape.k, tile);
            run(nullptr, nullptr, nullptr, 0, 3, 4, tile);
            run(nullptr, nullptr, nullptr, 3, 0, 4, tile);
            float C = 9;
            run(nullptr, nullptr, &C, 1, 1, 0, tile);
            require(C == 0, "K=0 must write zero");
        }
        for (auto tile : {gemm::BlockSize{0, 1, 1}, {1, 0, 1}, {1, 1, 0}}) {
            float C = 9;
            bool rejected = false;
            try { run(nullptr, nullptr, &C, 1, 1, 0, tile); }
            catch (const std::invalid_argument&) { rejected = true; }
            require(rejected && C == 9, "Invalid tiles must fail before writing");
        }
        const float A[] = {1, -2, 3, 4, 5, -6};
        const float B[] = {7, 8, 9, 10, 11, 12};
        float C[4];
        run(A, B, C, 2, 2, 3, {1, 1, 2});
        require(C[0] == 22 && C[1] == 24 && C[2] == 7 && C[3] == 10, "known answer");
        const float identity[] = {1, 0, 0, 0, 1, 0, 0, 0, 1};
        const float zero[9] = {};
        float rectangular[6];
        run(A, identity, rectangular, 2, 3, 3, {1, 2, 2});
        for (int i = 0; i < 6; ++i) require(rectangular[i] == A[i], "identity");
        run(A, zero, rectangular, 2, 3, 3, {1, 2, 2});
        for (float value : rectangular) require(value == 0, "zero matrix");
        std::cout << "Microkernel shape tests passed\n";
    } catch (const std::exception& error) {
        std::cerr << "FAIL: " << error.what() << '\n';
        throw;
    }
}

int main() {
    try {
        for (auto shape : {gemm::BlockSize{2,4,0}, {4,4,0}, {4,8,0}, {8,4,0}, {8,8,0}, {16,16,0}}) {
            active_mr = shape.m; active_nr = shape.n;
            suite();
        }
        active_mr = active_nr = 4;
        // PERF-SEMANTICS: Check every remainder modulo 2/4/8, macro K blocks
        // shorter than U, and simultaneous M/N tails; old C must be overwritten.
        for (auto u : {1u, 2u, 4u, 8u}) {
            active_unroll = u;
            suite();
            for (std::size_t K = 0; K <= 17; ++K)
                for (auto BK : {1u, 3u, 5u, 7u, 8u, 9u, 31u, 32u, 33u}) {
                    check(4, 4, K, {8, 8, BK});
                    check(9, 7, K, {7, 5, BK});
                }
        }
        for (auto u : {0u, 3u, 16u}) {
            float C = 9;
            bool rejected = false;
            try { gemm::microkernel(nullptr, nullptr, &C, 1, 1, 0, {32,128,32}, 4, 4, u); }
            catch (const std::invalid_argument&) { rejected = true; }
            require(rejected && C == 9, "Invalid unroll must not modify C");
        }
        if (gemm::neon_available()) {
            active_neon = true;
            suite();
            for (std::size_t M = 1; M <= 9; ++M)
                for (std::size_t N = 1; N <= 9; ++N)
                    for (auto K : {0u, 1u, 3u, 4u, 5u, 17u, 33u})
                        check(M, N, K, {7, 5, 3});
            for (std::size_t K = 0; K <= 17; ++K)
                for (auto BK : {1u, 3u, 4u, 5u, 8u, 31u, 32u, 33u})
                    check(8, 12, K, {8, 12, BK});
            // Deliberately offset all three buffers by one float. No 16-byte
            // alignment is promised by the API; ASan also checks vector bounds.
            gemm::Matrix A(9, 17), B(17, 7), expected(9, 7);
            gemm::fill_random(A, 91); gemm::fill_random(B, 92);
            gemm::reference(A.data(), B.data(), expected.data(), 9, 7, 17);
            std::vector<float> a(9*17+1), b(17*7+1), c(9*7+1);
            std::copy_n(A.data(), 9*17, a.data()+1);
            std::copy_n(B.data(), 17*7, b.data()+1);
            run(a.data()+1, b.data()+1, c.data()+1, 9, 7, 17, {8, 8, 5});
            for (std::size_t i = 0; i < 9*7; ++i)
                require(std::isfinite(c[i+1]) && std::abs(c[i+1]-expected.data()[i]) <=
                        1e-4f + 1e-4f*std::abs(expected.data()[i]), "unaligned NEON");
            // Full tile cancellation distinguishes fused FMA from rounded
            // multiply followed by add, which could incorrectly yield zero.
            const float e = std::numeric_limits<float>::epsilon();
            float fa[8], fb[8], fc[16];
            for (int r = 0; r < 4; ++r) { fa[2*r] = -1; fa[2*r+1] = 1+e; }
            for (int j = 0; j < 4; ++j) { fb[j] = 1; fb[4+j] = 1-e; }
            run(fa, fb, fc, 4, 4, 2, {4, 4, 2});
            for (float x : fc) require(x == std::fma(1+e, 1-e, -1.0f), "NEON must fuse");
            active_neon = false;
        } else {
            float C = 9;
            bool unavailable = false;
            try { gemm::neon_4x4(nullptr, nullptr, &C, 1, 1, 0, {4,4,4}); }
            catch (const std::runtime_error&) { unavailable = true; }
            require(unavailable && C == 9, "Unavailable NEON must not modify C");
        }
        bool rejected = false;
        try { gemm::microkernel(nullptr, nullptr, nullptr, 0, 0, 0, {32,128,32}, 8, 8, 2); }
        catch (const std::invalid_argument&) { rejected = true; }
        require(rejected, "Unrolling requires 4x4");
        for (auto shape : {gemm::BlockSize{0,4,0}, {4,0,0}, {3,4,0}, {4,16,0}}) {
            float C = 9;
            bool rejected = false;
            try { gemm::microkernel(nullptr, nullptr, &C, 1, 1, 0, {32,128,32}, shape.m, shape.n); }
            catch (const std::invalid_argument&) { rejected = true; }
            require(rejected && C == 9, "Invalid microtile must not modify C");
        }
    } catch (const std::exception& error) {
        std::cerr << error.what() << '\n';
        return 1;
    }
}
