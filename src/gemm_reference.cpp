#include "gemm/gemm.hpp"

namespace gemm {
void reference(const float* A, const float* B, float* C,
               std::size_t M, std::size_t N, std::size_t K) {
    for (std::size_t i = 0; i < M; ++i) {
        for (std::size_t j = 0; j < N; ++j) {
            // PERF-SEMANTICS: Multiply and accumulate in double, then round
            // once to float. This checks float kernels with less rounding error;
            // it is a numerical reference, not an exact-arithmetic oracle.
            double sum = 0.0;
            for (std::size_t k = 0; k < K; ++k) {
                sum += static_cast<double>(A[i * K + k]) * B[k * N + j];
            }
            C[i * N + j] = static_cast<float>(sum);
        }
    }
}
} // namespace gemm
