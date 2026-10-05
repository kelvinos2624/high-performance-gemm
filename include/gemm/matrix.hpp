#pragma once

#include <cstddef>
#include <cstdint>
#include <vector>

namespace gemm {

// PERF-CRITICAL: Contiguous row-major storage makes adjacent columns adjacent
// floats; advancing one row strides by cols. Kernels use this layout directly.
// Initially zero-filled. Indexing is unchecked.
class Matrix {
public:
    Matrix(std::size_t rows, std::size_t cols);
    std::size_t rows() const noexcept { return rows_; }
    std::size_t cols() const noexcept { return cols_; }
    float* data() noexcept { return data_.data(); }
    const float* data() const noexcept { return data_.data(); }
    float& operator()(std::size_t row, std::size_t col) noexcept {
        return data_[row * cols_ + col];
    }
    const float& operator()(std::size_t row, std::size_t col) const noexcept {
        return data_[row * cols_ + col];
    }

private:
    std::size_t rows_;
    std::size_t cols_;
    std::vector<float> data_;
};

// Deterministic binary fractions in [-1, 1), independent of stdlib distributions.
void fill_random(Matrix& matrix, std::uint32_t seed);

} // namespace gemm
