#pragma once
#include <cstddef>
namespace benchmark_support {
bool accelerate_available() noexcept;
// Same row-major C=AB contract. Dimensions must fit the 32-bit BLAS interface.
// Disabled builds throw before access; supported K=0 writes zeros.
void accelerate(const float*, const float*, float*, std::size_t, std::size_t, std::size_t);
}
