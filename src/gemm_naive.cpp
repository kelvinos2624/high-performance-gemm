#include "gemm/gemm.hpp"

namespace gemm {
void naive_ijk(const float* A, const float* B, float* C,
               std::size_t M, std::size_t N, std::size_t K) {
    // PERF-CRITICAL: ijk computes one dot product at a time. The inner k loop
    // walks A with unit stride but B with stride N in row-major storage.
    for (std::size_t i = 0; i < M; ++i) {
        for (std::size_t j = 0; j < N; ++j) {
            // PERF-SEMANTICS: Start each output at zero so this computes C=AB,
            // independent of old C; when K=0, the stored result is zero.
            float sum = 0.0f;
            for (std::size_t k = 0; k < K; ++k) {
                sum += A[i * K + k] * B[k * N + j];
            }
            // PERF-CRITICAL: Accumulate locally across K, then store C once.
            // Successive additions depend on the same float accumulator.
            C[i * N + j] = sum;
        }
    }
}
} // namespace gemm
