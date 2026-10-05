#include "gemm/kernels.hpp"
#include "gemm/matrix.hpp"

#include <algorithm>
#include <cmath>
#include <iostream>
#include <limits>
#include <stdexcept>
#include <string>
#include <vector>

namespace {
void require(bool condition, const std::string& message) {
    if (!condition) throw std::runtime_error(message);
}

void compare(const float* actual, const float* expected, std::size_t count,
             const std::string& label) {
    for (std::size_t i = 0; i < count; ++i) {
        const float tolerance = 1e-4f + 1e-4f * std::abs(expected[i]);
        require(std::isfinite(actual[i]) && std::isfinite(expected[i]) &&
                    std::abs(actual[i] - expected[i]) <= tolerance,
                label + ": mismatch at element " + std::to_string(i));
    }
}

void known(std::size_t M, std::size_t N, std::size_t K,
           const std::vector<float>& A, const std::vector<float>& B,
           const std::vector<float>& expected) {
    for (auto kernel : {gemm::reference, gemm::naive_ijk, gemm::ikj, gemm::jik,
                        gemm::jki, gemm::kij, gemm::kji}) {
        // Guards detect writes just outside C. NaNs check overwrite semantics.
        std::vector<float> storage(M * N + 2, 12345.0f);
        float* C = storage.data() + 1;
        std::fill_n(C, M * N, std::numeric_limits<float>::quiet_NaN());
        kernel(A.data(), B.data(), C, M, N, K);
        compare(C, expected.data(), M * N, "known answer");
        require(storage.front() == 12345.0f && storage.back() == 12345.0f,
                "output bounds");
        kernel(A.data(), B.data(), C, M, N, K);
        compare(C, expected.data(), M * N, "repeated overwrite");
    }
}

void random_case(std::size_t M, std::size_t N, std::size_t K) {
    gemm::Matrix A(M, K), B(K, N), C(M, N), expected(M, N);
    gemm::fill_random(A, 42);
    gemm::fill_random(B, 43);
    const auto saved_A = A;
    const auto saved_B = B;
    gemm::reference(A.data(), B.data(), expected.data(), M, N, K);
    for (const auto& kernel : gemm::kernels) {
        std::fill_n(C.data(), M * N, std::numeric_limits<float>::quiet_NaN());
        kernel.function(A.data(), B.data(), C.data(), M, N, K);
        compare(C.data(), expected.data(), M * N, std::string(kernel.name) +
                " random " + std::to_string(M) + "x" + std::to_string(N) +
                "x" + std::to_string(K));
        require(std::equal(A.data(), A.data() + M * K, saved_A.data()), "A modified");
        require(std::equal(B.data(), B.data() + K * N, saved_B.data()), "B modified");
    }
}
} // namespace

int main() {
    try {
        gemm::Matrix matrix(2, 3);
        require(matrix.rows() == 2 && matrix.cols() == 3, "matrix dimensions");
        require(matrix(1, 2) == 0.0f, "zero initialization");
        matrix(1, 2) = 7.0f;
        const auto& const_matrix = matrix;
        require(&const_matrix(1, 2) == const_matrix.data() + 5 &&
                    const_matrix.data()[5] == 7.0f, "row-major indexing");
        gemm::Matrix empty(0, 3);
        require(empty.rows() == 0 && empty.cols() == 3, "empty dimensions");
        bool overflow_rejected = false;
        try { gemm::Matrix too_big(std::numeric_limits<std::size_t>::max(), 2); }
        catch (const std::length_error&) { overflow_rejected = true; }
        require(overflow_rejected, "dimension overflow must be rejected");

        gemm::Matrix random1(7, 9), random2(7, 9);
        gemm::fill_random(random1, 123);
        gemm::fill_random(random2, 123);
        for (std::size_t i = 0; i < 63; ++i) {
            require(random1.data()[i] == random2.data()[i], "deterministic input");
            require(random1.data()[i] >= -1 && random1.data()[i] < 1, "input range");
        }

        known(1, 1, 1, {-3}, {2}, {-6});
        known(2, 2, 2, {1, 2, 3, 4}, {5, 6, 7, 8}, {19, 22, 43, 50});
        known(2, 2, 3, {1, -2, 3, 4, 5, -6}, {7, 8, 9, 10, 11, 12},
              {22, 24, 7, 10});
        known(2, 3, 3, {1, 2, 3, -4, 5, -6}, {1, 0, 0, 0, 1, 0, 0, 0, 1},
              {1, 2, 3, -4, 5, -6});
        known(3, 2, 3, {1, 0, 0, 0, 1, 0, 0, 0, 1}, {1, 2, 3, -4, 5, -6},
              {1, 2, 3, -4, 5, -6});
        known(2, 2, 3, std::vector<float>(6, 0), {1, 2, -3, 4, 5, 6}, {0, 0, 0, 0});
        known(2, 2, 3, {1, 2, -3, 4, 5, 6}, std::vector<float>(6, 0), {0, 0, 0, 0});
        known(2, 3, 0, {}, {}, {0, 0, 0, 0, 0, 0});
        for (auto kernel : {gemm::reference, gemm::naive_ijk, gemm::ikj, gemm::jik,
                        gemm::jki, gemm::kij, gemm::kji}) {
            kernel(nullptr, nullptr, nullptr, 0, 4, 3);
            kernel(nullptr, nullptr, nullptr, 4, 0, 3);
            float C = 9;
            kernel(nullptr, nullptr, &C, 1, 1, 0);
            require(C == 0, "K=0");
        }
        random_case(1, 17, 9);
        random_case(13, 1, 7);
        random_case(3, 3, 3);
        random_case(2, 4, 3);
        random_case(7, 11, 13);
        random_case(31, 33, 29);
        random_case(64, 65, 127);
        random_case(9, 7, 1024);
        std::cout << "All GEMM and Matrix correctness tests passed\n";
    } catch (const std::exception& error) {
        std::cerr << "FAIL: " << error.what() << '\n';
        return 1;
    }
}
