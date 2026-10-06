#include "microkernel_tiles.hpp"

namespace gemm::detail {
namespace {
// COMPILER-IMPORTANT: Compile-time MR/NR give fixed local accumulator extents.
// The compiler may scalarize/vectorize these arrays into registers; this is an
// expectation to verify in assembly, not a register-allocation guarantee.
template <std::size_t MR, std::size_t NR>
void tile(const float* A, const float* B, float* C,
          std::size_t K, std::size_t N, std::size_t depth) {
    // PERF-SEMANTICS: Load the partial C sums from earlier K blocks.
    float acc[MR][NR];
    for (std::size_t r = 0; r < MR; ++r)
        for (std::size_t c = 0; c < NR; ++c)
            acc[r][c] = C[r * N + c];

    // PERF-CRITICAL: Keep MR*NR independent sums across this K block.
    // Load each B value once per k for reuse across MR rows; reuse each A scalar
    // across NR columns. K advances one element at a time (no manual unrolling).
    for (std::size_t k = 0; k < depth; ++k) {
        float b[NR];
        for (std::size_t c = 0; c < NR; ++c) b[c] = B[k * N + c];
        for (std::size_t r = 0; r < MR; ++r) {
            const float a = A[r * K + k];
            for (std::size_t c = 0; c < NR; ++c) acc[r][c] += a * b[c];
        }
    }
    // PERF-CRITICAL: Store each C element once per K block, not on every k.
    for (std::size_t r = 0; r < MR; ++r)
        for (std::size_t c = 0; c < NR; ++c)
            C[r * N + c] = acc[r][c];
}
}
// Separate translation unit keeps these actual timed tile bodies inspectable
// without forcing noinline or changing optimizer flags for the experiment.
void tile_2x4(const float* A, const float* B, float* C,
                std::size_t K, std::size_t N, std::size_t depth) {
    tile<2, 4>(A, B, C, K, N, depth);
}
void tile_4x4(const float* A, const float* B, float* C,
                std::size_t K, std::size_t N, std::size_t depth) {
    tile<4, 4>(A, B, C, K, N, depth);
}
void tile_4x8(const float* A, const float* B, float* C,
                std::size_t K, std::size_t N, std::size_t depth) {
    tile<4, 8>(A, B, C, K, N, depth);
}
void tile_8x4(const float* A, const float* B, float* C,
                std::size_t K, std::size_t N, std::size_t depth) {
    tile<8, 4>(A, B, C, K, N, depth);
}
void tile_8x8(const float* A, const float* B, float* C,
                std::size_t K, std::size_t N, std::size_t depth) {
    tile<8, 8>(A, B, C, K, N, depth);
}
void tile_16x16(const float* A, const float* B, float* C,
                std::size_t K, std::size_t N, std::size_t depth) {
    tile<16, 16>(A, B, C, K, N, depth);
}
} // namespace gemm::detail
