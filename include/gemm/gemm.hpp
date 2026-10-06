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

// Supported microtiles: 2x4, 4x4, 4x8, 8x4, 8x8, 16x16 (pressure experiment).
// Unroll 1 preserves the original bodies; factors 2/4/8 are supported for 4x4 only.
// Invalid configuration throws before touching buffers.
void microkernel(const float* A, const float* B, float* C,
                 std::size_t M, std::size_t N, std::size_t K,
                 BlockSize tile, std::size_t MR, std::size_t NR,
                 std::size_t unroll = 1);

} // namespace gemm
