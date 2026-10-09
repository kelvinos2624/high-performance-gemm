#pragma once

#include <cstddef>

namespace gemm {

// PERF-SEMANTICS: C = A * B. Contiguous row-major A[M,K], B[K,N], C[M,N].
// Caller supplies valid buffer extents whose index products fit size_t.
// C must not overlap A or B. Configuration validation is documented below.
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

// Fixed 4x4 AArch64 NEON/FMA body, same macrotiles and scalar tails as microkernel.
// No 16-byte alignment requirement; normal valid float storage is sufficient.
// Explicit fused arithmetic may round differently from non-fused scalar builds.
// Availability is a build capability; disabled/unsupported builds throw
// std::runtime_error before accessing buffers, including empty outputs.
bool neon_available() noexcept;
void neon_4x4(const float* A, const float* B, float* C,
              std::size_t M, std::size_t N, std::size_t K, BlockSize tile);

enum class Schedule { Static, Dynamic };

// Same matrix contract. Positive block dimensions and thread count required.
// At most ceil(M/BM) workers, including the calling thread. Creates/joins threads
// per call; invalid configuration throws before buffer access. Launch failure
// joins started workers and throws; C may then be partially updated.
void parallel(const float* A, const float* B, float* C,
              std::size_t M, std::size_t N, std::size_t K, BlockSize tile,
              std::size_t threads, Schedule schedule = Schedule::Static);

} // namespace gemm
