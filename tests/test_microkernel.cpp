#include "gemm/gemm.hpp"
#include "gemm/matrix.hpp"

#include <algorithm>
#include <cmath>
#include <iostream>
#include <limits>
#include <stdexcept>
#include <vector>

namespace {
std::size_t active_mr = 4, active_nr = 4;
void run(const float* A, const float* B, float* C, std::size_t M, std::size_t N,
         std::size_t K, gemm::BlockSize tile) {
    gemm::microkernel(A, B, C, M, N, K, tile, active_mr, active_nr);
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
