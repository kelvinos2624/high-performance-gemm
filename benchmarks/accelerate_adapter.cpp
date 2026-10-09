#include "accelerate_adapter.hpp"
#include <limits>
#include <stdexcept>
#if GEMM_BENCH_HAS_ACCELERATE
#include <Accelerate/Accelerate.h>
#endif

namespace benchmark_support {
bool accelerate_available() noexcept { return GEMM_BENCH_HAS_ACCELERATE != 0; }
void accelerate(const float* A, const float* B, float* C,
                std::size_t M, std::size_t N, std::size_t K) {
#if GEMM_BENCH_HAS_ACCELERATE
    // PERF-SEMANTICS: Reject narrowing before access. Match empty/K=0 behavior
    // without passing invalid leading dimensions or null data into BLAS.
    const auto limit = static_cast<std::size_t>(std::numeric_limits<int>::max());
    if (M > limit || N > limit || K > limit)
        throw std::invalid_argument("Accelerate benchmark dimensions exceed INT_MAX");
    if (!M || !N) return;
    if (!K) {
        for (std::size_t i = 0; i < M * N; ++i) C[i] = 0;
        return;
    }
    // BENCHMARK-IMPORTANT: Same row-major C=AB operation, no external packing
    // or transpose. beta=0 overwrites C, so do not add a separate zeroing pass.
    // All internal BLAS setup/packing is included in the timed library call.
    cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans,
                static_cast<int>(M), static_cast<int>(N), static_cast<int>(K),
                1.0f, A, static_cast<int>(K), B, static_cast<int>(N),
                0.0f, C, static_cast<int>(N));
#else
    throw std::runtime_error("Accelerate benchmark unavailable; configure GEMM_BENCHMARK_ACCELERATE=ON on macOS");
#endif
}
}
