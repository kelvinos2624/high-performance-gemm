#pragma once
#include <cstddef>
#include "gemm/gemm.hpp"
namespace gemm::detail {
using TileFunction = void (*)(const float*, const float*, float*,
                             std::size_t, std::size_t, std::size_t);
// Separate driver TU prevents caller-specific tile specialization without LTO.
void microkernel_impl(const float*, const float*, float*, std::size_t, std::size_t,
                      std::size_t, BlockSize, std::size_t, std::size_t, TileFunction);
void tile_4x4_neon(const float*, const float*, float*, std::size_t, std::size_t, std::size_t);
void tile_2x4(const float*, const float*, float*, std::size_t, std::size_t, std::size_t);
void tile_4x4(const float*, const float*, float*, std::size_t, std::size_t, std::size_t);
void tile_4x8(const float*, const float*, float*, std::size_t, std::size_t, std::size_t);
void tile_8x4(const float*, const float*, float*, std::size_t, std::size_t, std::size_t);
void tile_8x8(const float*, const float*, float*, std::size_t, std::size_t, std::size_t);
void tile_16x16(const float*, const float*, float*, std::size_t, std::size_t, std::size_t);
void tile_4x4_u2(const float*, const float*, float*, std::size_t, std::size_t, std::size_t);
void tile_4x4_u4(const float*, const float*, float*, std::size_t, std::size_t, std::size_t);
void tile_4x4_u8(const float*, const float*, float*, std::size_t, std::size_t, std::size_t);
}
