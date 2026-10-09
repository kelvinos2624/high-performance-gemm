#include "gemm/gemm.hpp"
#include "microkernel_tiles.hpp"
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

    detail::microkernel_impl(A, B, C, M, N, K, tile, MR, NR, compute);
}

void neon_4x4(const float* A, const float* B, float* C,
              std::size_t M, std::size_t N, std::size_t K, BlockSize tile) {
    if (!neon_available())
        throw std::runtime_error("NEON 4x4 requires an enabled AArch64 NEON build");
    detail::microkernel_impl(A, B, C, M, N, K, tile, 4, 4, detail::tile_4x4_neon);
}
} // namespace gemm
