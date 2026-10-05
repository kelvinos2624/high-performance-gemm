#include "gemm/gemm.hpp"

#include <algorithm>
#include <stdexcept>

namespace gemm {
void blocked(const float* A, const float* B, float* C,
             std::size_t M, std::size_t N, std::size_t K, BlockSize tile) {
    // PERF-SEMANTICS: Zero block dimensions cannot advance a tile loop.
    // Reject them before writing C, even for an empty output.
    if (tile.m == 0 || tile.n == 0 || tile.k == 0)
        throw std::invalid_argument("Block dimensions must be positive");
    if (M == 0 || N == 0) return;

    // PERF-SEMANTICS: Initialize once, not per K tile: later K tiles must
    // retain earlier partial sums. K=0 leaves a zero output.
    // BENCHMARK-IMPORTANT: This initialization is part of the timed C=AB call.
    for (std::size_t index = 0; index < M * N; ++index) C[index] = 0.0f;

    // PERF-CRITICAL: ii/kk/jj bounds the region revisited by the inner ikj
    // loops. A B tile is reused across rows of A/C before advancing jj.
    for (std::size_t ii = 0; ii < M;) {
        // PERF-SEMANTICS: Clamp tails using remaining extents before adding,
        // so even a SIZE_MAX tile cannot overflow the end calculation.
        const auto i_end = ii + std::min(tile.m, M - ii);
        for (std::size_t kk = 0; kk < K;) {
            const auto k_end = kk + std::min(tile.k, K - kk);
            for (std::size_t jj = 0; jj < N;) {
                const auto j_end = jj + std::min(tile.n, N - jj);
                for (std::size_t i = ii; i < i_end; ++i) {
                    for (std::size_t k = kk; k < k_end; ++k) {
                        // PERF-CRITICAL: Reuse A[i,k] while walking the B/C
                        // tile rows contiguously, preserving the ikj inner loop.
                        const float a = A[i * K + k];
                        for (std::size_t j = jj; j < j_end; ++j) {
                            C[i * N + j] += a * B[k * N + j];
                        }
                    }
                }
                jj = j_end;
            }
            kk = k_end;
        }
        ii = i_end;
    }
}
} // namespace gemm
