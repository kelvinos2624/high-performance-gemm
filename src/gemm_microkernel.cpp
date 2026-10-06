#include "gemm/gemm.hpp"
#include "microkernel_tiles.hpp"
#include <algorithm>
#include <stdexcept>

namespace gemm {
void microkernel(const float* A, const float* B, float* C,
                 std::size_t M, std::size_t N, std::size_t K,
                 BlockSize tile, std::size_t MR, std::size_t NR, std::size_t unroll) {
    detail::TileFunction compute = nullptr;
    if (MR == 2 && NR == 4) compute = detail::tile_2x4;
    if (MR == 4 && NR == 4) compute = detail::tile_4x4;
    if (MR == 4 && NR == 8) compute = detail::tile_4x8;
    if (MR == 8 && NR == 4) compute = detail::tile_8x4;
    if (MR == 8 && NR == 8) compute = detail::tile_8x8;
    if (MR == 16 && NR == 16) compute = detail::tile_16x16;

    // COMPILER-IMPORTANT: Select a separately compiled unroll specialization
    // once per GEMM. Factor 1 retains the unchanged Milestone 4 tile body.
    if (unroll != 1) {
        compute = nullptr;
        if (MR == 4 && NR == 4) {
            if (unroll == 2) compute = detail::tile_4x4_u2;
            if (unroll == 4) compute = detail::tile_4x4_u4;
            if (unroll == 8) compute = detail::tile_4x4_u8;
        }
    }

    // PERF-SEMANTICS: Reject invalid choices before modifying output.
    if (!compute || tile.m == 0 || tile.n == 0 || tile.k == 0)
        throw std::invalid_argument("Unsupported microtile or zero block dimension");
    if (M == 0 || N == 0) return;
    // PERF-SEMANTICS: Zero once; tile bodies accumulate across K blocks.
    // BENCHMARK-IMPORTANT: Initialization and per-tile calls are timed.
    for (std::size_t index = 0; index < M * N; ++index) C[index] = 0;
    // PERF-CRITICAL: Same macro order as blocked; only the tile body changes.
    for (std::size_t ii = 0; ii < M;) {
        const auto ie = ii + std::min(tile.m, M - ii);
        for (std::size_t kk = 0; kk < K;) {
            const auto ke = kk + std::min(tile.k, K - kk);
            for (std::size_t jj = 0; jj < N;) {
                const auto je = jj + std::min(tile.n, N - jj);
                for (std::size_t i = ii; i < ie;) {
                    const auto rows = std::min(MR, ie - i);
                    for (std::size_t j = jj; j < je;) {
                        const auto cols = std::min(NR, je - j);
                        if (rows == MR && cols == NR) {
                            compute(A + i * K + kk, B + kk * N + j,
                                    C + i * N + j, K, N, ke - kk);
                        } else {
                            // PERF-SEMANTICS: Partial macro/matrix edges cannot
                            // use a full tile body. Clamp both dimensions; each
                            // output is updated exactly once for this K block.
                            for (std::size_t r = 0; r < rows; ++r)
                                for (std::size_t c = 0; c < cols; ++c) {
                                    float sum = C[(i + r) * N + j + c];
                                    for (std::size_t k = kk; k < ke; ++k)
                                        sum += A[(i + r) * K + k] * B[k * N + j + c];
                                    C[(i + r) * N + j + c] = sum;
                                }
                        }
                        j += cols;
                    }
                    i += rows;
                }
                jj = je;
            }
            kk = ke;
        }
        ii = ie;
    }
}
} // namespace gemm
