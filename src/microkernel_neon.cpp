#include "gemm/gemm.hpp"
#include "microkernel_tiles.hpp"
#include <stdexcept>
#if GEMM_HAS_NEON
#include <arm_neon.h>
#endif

namespace gemm {
bool neon_available() noexcept { return GEMM_HAS_NEON != 0; }

namespace detail {
void tile_4x4_neon(const float* A, const float* B, float* C,
                   std::size_t K, std::size_t N, std::size_t depth) {
#if GEMM_HAS_NEON
    // PERF-SEMANTICS: Each vector is four adjacent columns of one output row.
    // Load existing partial sums: later K blocks must accumulate, not reset C.
    float32x4_t c0 = vld1q_f32(C);
    float32x4_t c1 = vld1q_f32(C + N);
    float32x4_t c2 = vld1q_f32(C + 2 * N);
    float32x4_t c3 = vld1q_f32(C + 3 * N);
    // PERF-CRITICAL: Reuse one contiguous B vector across four A rows. Keep
    // four independent vector accumulators live through K; no horizontal sum.
    // COMPILER-IMPORTANT: Explicit fused vector multiply-add should lower to
    // four fmla.4s per k (32 FLOPs). Verify accumulator residency in assembly.
    for (std::size_t k = 0; k < depth; ++k) {
        const float32x4_t b = vld1q_f32(B + k * N);
        c0 = vfmaq_n_f32(c0, b, A[k]);
        c1 = vfmaq_n_f32(c1, b, A[K + k]);
        c2 = vfmaq_n_f32(c2, b, A[2 * K + k]);
        c3 = vfmaq_n_f32(c3, b, A[3 * K + k]);
    }
    // PERF-CRITICAL: Store each output row once per K block. Full-tile dispatch
    // guarantees all four lanes exist; scalar driver cleanup handles edges.
    vst1q_f32(C, c0);
    vst1q_f32(C + N, c1);
    vst1q_f32(C + 2 * N, c2);
    vst1q_f32(C + 3 * N, c3);
#else
    throw std::runtime_error("NEON 4x4 unavailable in this build");
#endif
}
} // namespace detail
} // namespace gemm
