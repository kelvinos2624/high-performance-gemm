#include "gemm/matrix.hpp"

#include <limits>
#include <random>
#include <stdexcept>

namespace gemm {
namespace {
std::size_t checked_size(std::size_t rows, std::size_t cols) {
    if (cols != 0 && rows > std::numeric_limits<std::size_t>::max() / cols) {
        throw std::length_error("Matrix dimensions overflow size_t");
    }
    return rows * cols;
}
} // namespace

Matrix::Matrix(std::size_t rows, std::size_t cols)
    : rows_(rows), cols_(cols), data_(checked_size(rows, cols), 0.0f) {}

void fill_random(Matrix& matrix, std::uint32_t seed) {
    // BENCHMARK-IMPORTANT: Fixed seeds and an explicit mapping to binary
    // fractions reproduce inputs without stdlib-specific real distributions.
    std::mt19937 rng(seed);
    for (std::size_t i = 0; i < matrix.rows() * matrix.cols(); ++i) {
        matrix.data()[i] = static_cast<float>(rng() >> 8) * (1.0f / 8388608.0f) - 1.0f;
    }
}
} // namespace gemm
