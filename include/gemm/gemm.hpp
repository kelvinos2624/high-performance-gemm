#pragma once

#include <cstddef>

namespace gemm {

// PERF-SEMANTICS: C = A * B. Contiguous row-major A[M,K], B[K,N], C[M,N].
// Caller supplies valid buffer extents whose index products fit size_t.
// C must not overlap A or B. No allocation or validation in the kernels.
// M==0 or N==0: no accesses. K==0: write zeros to C; A/B may be null.
// Reference accumulates in double and rounds to float once per output.
void reference(const float* A, const float* B, float* C,
               std::size_t M, std::size_t N, std::size_t K);
void naive_ijk(const float* A, const float* B, float* C,
               std::size_t M, std::size_t N, std::size_t K);

void ikj(const float* A, const float* B, float* C,
         std::size_t M, std::size_t N, std::size_t K);

void jik(const float* A, const float* B, float* C,
         std::size_t M, std::size_t N, std::size_t K);

void jki(const float* A, const float* B, float* C,
         std::size_t M, std::size_t N, std::size_t K);

void kij(const float* A, const float* B, float* C,
         std::size_t M, std::size_t N, std::size_t K);

void kji(const float* A, const float* B, float* C,
         std::size_t M, std::size_t N, std::size_t K);

struct BlockSize {
    std::size_t m;
    std::size_t n;
    std::size_t k;
};

// Same buffer contract as above. All block dimensions must be positive;
// otherwise throws std::invalid_argument before accessing any buffers.
void blocked(const float* A, const float* B, float* C,
             std::size_t M, std::size_t N, std::size_t K, BlockSize tile);

} // namespace gemm
