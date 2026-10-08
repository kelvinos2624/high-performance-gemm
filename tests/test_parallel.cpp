#include "gemm/gemm.hpp"
#include "gemm/matrix.hpp"

#include <algorithm>
#include <cmath>
#include <iostream>
#include <limits>
#include <stdexcept>
#include <vector>

void require(bool condition) {
    if (!condition) throw std::runtime_error("Parallel correctness failure");
}

void check(std::size_t M, std::size_t N, std::size_t K,
           gemm::BlockSize tile, std::size_t threads, gemm::Schedule policy) {
    gemm::Matrix A(M, K), B(K, N), expected(M, N), serial(M, N);
    gemm::fill_random(A, 42);
    gemm::fill_random(B, 43);
    std::vector<float> saved_a(M * K), saved_b(K * N);
    if (M * K) std::copy_n(A.data(), M * K, saved_a.data());
    if (K * N) std::copy_n(B.data(), K * N, saved_b.data());
    gemm::reference(A.data(), B.data(), expected.data(), M, N, K);
    gemm::blocked(A.data(), B.data(), serial.data(), M, N, K, tile);
    std::vector<float> output(M * N + 2, 12345.0f);
    for (int repeat = 0; repeat < 3; ++repeat) {
        std::fill(output.begin() + 1, output.end() - 1,
                  std::numeric_limits<float>::quiet_NaN());
        gemm::parallel(K ? A.data() : nullptr, K ? B.data() : nullptr,
                       output.data() + 1, M, N, K, tile, threads, policy);
        require(output.front() == 12345.0f && output.back() == 12345.0f);
        for (std::size_t i = 0; i < M * N; ++i) {
            require(std::isfinite(output[i + 1]));
            require(std::abs(output[i + 1] - expected.data()[i]) <=
                    1e-4f + 1e-4f * std::abs(expected.data()[i]));
            require(output[i + 1] == serial.data()[i]);
        }
    }
    for (std::size_t i = 0; i < saved_a.size(); ++i) require(saved_a[i] == A.data()[i]);
    for (std::size_t i = 0; i < saved_b.size(); ++i) require(saved_b[i] == B.data()[i]);
}

int main() {
    try {
        const auto max = std::numeric_limits<std::size_t>::max();
        for (auto policy : {gemm::Schedule::Static, gemm::Schedule::Dynamic}) {
            for (auto threads : {1u, 2u, 4u, 12u}) {
                for (auto shape : {gemm::BlockSize{1,1,1}, {0,7,3}, {7,0,3},
                                   {9,7,0}, {3,11,5}, {65,33,17}, {129,7,65}, {4,193,31}}) {
                    for (auto tile : {gemm::BlockSize{1,3,2}, {8,16,7}, {32,128,32}, {max,max,max}})
                        check(shape.m, shape.n, shape.k, tile, threads, policy);
                }
            }
            gemm::parallel(nullptr, nullptr, nullptr, 0, 7, 9, {1,1,1}, max, policy);
            check(3, 5, 7, {2,4,3}, max, policy);
        }
        for (auto tile : {gemm::BlockSize{0,1,1}, {1,0,1}, {1,1,0}, {1,1,1}}) {
            bool threw = false;
            try { gemm::parallel(nullptr, nullptr, nullptr, 0, 0, 0, tile, 0); }
            catch (const std::invalid_argument&) { threw = true; }
            require(threw);
        }
        for (auto tile : {gemm::BlockSize{0,1,1}, {1,0,1}, {1,1,0}}) {
            bool threw = false;
            try { gemm::parallel(nullptr, nullptr, nullptr, 1, 1, 1, tile, 2); }
            catch (const std::invalid_argument&) { threw = true; }
            require(threw);
        }
        bool threw = false;
        try { gemm::parallel(nullptr, nullptr, nullptr, 0, 0, 0, {1,1,1}, 1,
                             static_cast<gemm::Schedule>(99)); }
        catch (const std::invalid_argument&) { threw = true; }
        require(threw);
        std::cout << "Parallel correctness passed\n";
    } catch (const std::exception& error) {
        std::cerr << error.what() << '\n';
        return 1;
    }
}
