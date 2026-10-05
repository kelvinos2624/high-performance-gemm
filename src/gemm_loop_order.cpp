#include "gemm/gemm.hpp"

namespace gemm {
namespace {
// PERF-SEMANTICS: Accumulating loop orders require C=0 before any +=.
// This also handles K=0 and overwrites old C, including NaNs.
// BENCHMARK-IMPORTANT: Zeroing belongs to each kernel call and is timed.
void zero_output(float* C, std::size_t M, std::size_t N) {
    for (std::size_t index = 0; index < M * N; ++index) C[index] = 0.0f;
}
} // namespace

void ikj(const float* A, const float* B, float* C,
         std::size_t M, std::size_t N, std::size_t K) {
    // PERF-SEMANTICS: Empty outputs must not read A/B or dereference C.
    if (M == 0 || N == 0) return;
    zero_output(C, M, N);
    // PERF-CRITICAL: Inner j walks B and C contiguously, reusing A[i,k].
    // Keeping i outermost revisits one C row across all k.
    for (std::size_t i = 0; i < M; ++i) {
        for (std::size_t k = 0; k < K; ++k) {
            const float a = A[i * K + k];
            for (std::size_t j = 0; j < N; ++j) {
                C[i * N + j] += a * B[k * N + j];
            }
        }
    }
}

void jik(const float* A, const float* B, float* C,
         std::size_t M, std::size_t N, std::size_t K) {
    // PERF-SEMANTICS: Empty outputs must not read A/B or dereference C.
    if (M == 0 || N == 0) return;
    // PERF-CRITICAL: Inner k walks A contiguously and B with stride N.
    // Unlike ijk, successive dot products traverse C down a column.
    for (std::size_t j = 0; j < N; ++j) {
        for (std::size_t i = 0; i < M; ++i) {
            // PERF-SEMANTICS: A fresh sum implements overwrite semantics.
            float sum = 0.0f;
            for (std::size_t k = 0; k < K; ++k) {
                sum += A[i * K + k] * B[k * N + j];
            }
            C[i * N + j] = sum;
        }
    }
}

void jki(const float* A, const float* B, float* C,
         std::size_t M, std::size_t N, std::size_t K) {
    // PERF-SEMANTICS: Empty outputs must not read A/B or dereference C.
    if (M == 0 || N == 0) return;
    zero_output(C, M, N);
    // PERF-CRITICAL: Inner i walks A with stride K and C with stride N,
    // reusing B[k,j]. Only one output column is updated across all k.
    for (std::size_t j = 0; j < N; ++j) {
        for (std::size_t k = 0; k < K; ++k) {
            const float b = B[k * N + j];
            for (std::size_t i = 0; i < M; ++i) {
                C[i * N + j] += A[i * K + k] * b;
            }
        }
    }
}

void kij(const float* A, const float* B, float* C,
         std::size_t M, std::size_t N, std::size_t K) {
    // PERF-SEMANTICS: Empty outputs must not read A/B or dereference C.
    if (M == 0 || N == 0) return;
    zero_output(C, M, N);
    // PERF-CRITICAL: Inner j walks B and C contiguously, reusing A[i,k].
    // With k outermost, all of C is revisited for each k.
    for (std::size_t k = 0; k < K; ++k) {
        for (std::size_t i = 0; i < M; ++i) {
            const float a = A[i * K + k];
            for (std::size_t j = 0; j < N; ++j) {
                C[i * N + j] += a * B[k * N + j];
            }
        }
    }
}

void kji(const float* A, const float* B, float* C,
         std::size_t M, std::size_t N, std::size_t K) {
    // PERF-SEMANTICS: Empty outputs must not read A/B or dereference C.
    if (M == 0 || N == 0) return;
    zero_output(C, M, N);
    // PERF-CRITICAL: Inner i walks A with stride K and C with stride N,
    // reusing B[k,j]. With k outermost, all of C is revisited for each k.
    for (std::size_t k = 0; k < K; ++k) {
        for (std::size_t j = 0; j < N; ++j) {
            const float b = B[k * N + j];
            for (std::size_t i = 0; i < M; ++i) {
                C[i * N + j] += A[i * K + k] * b;
            }
        }
    }
}
} // namespace gemm
