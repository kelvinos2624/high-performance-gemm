#pragma once

#include "gemm/gemm.hpp"
#include <array>

namespace gemm {
using KernelFunction = void (*)(const float*, const float*, float*,
                               std::size_t, std::size_t, std::size_t);
struct Kernel {
    const char* name;
    KernelFunction function;
};
// Shared enumeration keeps correctness coverage and benchmark choices in sync.
inline const std::array<Kernel, 6> kernels{{
    {"naive_ijk", naive_ijk}, {"ikj", ikj}, {"jik", jik},
    {"jki", jki}, {"kij", kij}, {"kji", kji}
}};
} // namespace gemm
