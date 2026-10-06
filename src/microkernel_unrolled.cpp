#include "microkernel_tiles.hpp"

namespace gemm::detail {
namespace {
// PERF-CRITICAL: One K step of the same 4x4 outer-product update as factor 1.
// B is reused across four rows, and each A scalar across four columns.
void step(float (&acc)[4][4], const float* A, const float* B,
          std::size_t K, std::size_t N, std::size_t k) {
    float b[4];
    for (std::size_t c = 0; c < 4; ++c) b[c] = B[k * N + c];
    for (std::size_t r = 0; r < 4; ++r) {
        const float a = A[r * K + k];
        for (std::size_t c = 0; c < 4; ++c) acc[r][c] += a * b[c];
    }
}

template <std::size_t U>
void tile(const float* A, const float* B, float* C,
          std::size_t K, std::size_t N, std::size_t depth) {
    // PERF-SEMANTICS: Preserve partial sums from preceding macro K blocks.
    float acc[4][4];
    for (std::size_t r = 0; r < 4; ++r)
        for (std::size_t c = 0; c < 4; ++c) acc[r][c] = C[r * N + c];

    std::size_t k = 0;
    // PERF-SEMANTICS: Subtraction avoids overflow in a k+U bound check.
    // COMPILER-IMPORTANT: Explicit consecutive steps request U-fold expansion;
    // constant offsets and if constexpr expose scheduling opportunities. We
    // expect step to inline, but verify the optimized body rather than force it.
    for (; depth - k >= U; k += U) {
        step(acc, A, B, K, N, k);
        step(acc, A, B, K, N, k + 1);
        if constexpr (U >= 4) {
            step(acc, A, B, K, N, k + 2);
            step(acc, A, B, K, N, k + 3);
        }
        if constexpr (U >= 8) {
            step(acc, A, B, K, N, k + 4);
            step(acc, A, B, K, N, k + 5);
            step(acc, A, B, K, N, k + 6);
            step(acc, A, B, K, N, k + 7);
        }
    }
    // PERF-SEMANTICS: Finish 0..U-1 remaining K values in order, including
    // a final macro block shorter than U. No reassociation or split accumulators.
    for (; k < depth; ++k) step(acc, A, B, K, N, k);
    for (std::size_t r = 0; r < 4; ++r)
        for (std::size_t c = 0; c < 4; ++c) C[r * N + c] = acc[r][c];
}
}
void tile_4x4_u2(const float* A, const float* B, float* C,
                 std::size_t K, std::size_t N, std::size_t depth) {
    tile<2>(A, B, C, K, N, depth);
}
void tile_4x4_u4(const float* A, const float* B, float* C,
                 std::size_t K, std::size_t N, std::size_t depth) {
    tile<4>(A, B, C, K, N, depth);
}
void tile_4x4_u8(const float* A, const float* B, float* C,
                 std::size_t K, std::size_t N, std::size_t depth) {
    tile<8>(A, B, C, K, N, depth);
}
} // namespace gemm::detail
