#include "gemm/gemm.hpp"

#include <algorithm>
#include <atomic>
#include <stdexcept>
#include <thread>
#include <vector>

namespace gemm {
void parallel(const float* A, const float* B, float* C,
              std::size_t M, std::size_t N, std::size_t K, BlockSize tile,
              std::size_t threads, Schedule schedule) {
    if (!tile.m || !tile.n || !tile.k || !threads)
        throw std::invalid_argument("Block dimensions and thread count must be positive");
    if (schedule != Schedule::Static && schedule != Schedule::Dynamic)
        throw std::invalid_argument("Unknown schedule");
    if (!M || !N) return;
    // PERF-SEMANTICS: Ceiling division without addition overflow. Each task
    // owns whole rows of C and all K contributions; B is shared read-only.
    const auto tasks = 1 + (M - 1) / tile.m;
    const auto workers = std::min(threads, tasks);
    const auto compute = [&](std::size_t first, std::size_t count) {
        const auto row = first * tile.m;
        const auto rows = count > (M - row) / tile.m ? M - row : count * tile.m;
        // PERF-SEMANTICS: K=0 allows null A; do not perform pointer arithmetic
        // on it. blocked initializes only the output rows owned by this worker.
        blocked(K ? A + row * K : A, B, C + row * N, rows, N, K, tile);
    };
    std::atomic<std::size_t> next{0};
    const auto work = [&](std::size_t id) {
        if (schedule == Schedule::Static) {
            // PERF-CRITICAL: Contiguous balanced ranges avoid a queue and
            // preserve blocked's ii/kk/jj traversal within each row strip.
            const auto base = tasks / workers;
            const auto extra = tasks % workers;
            compute(id * base + std::min(id, extra), base + (id < extra));
        } else {
            // PERF-CRITICAL: Claim one BM-row strip at a time to balance work.
            // Relaxed ordering suffices for unique task IDs; join publishes C.
            // Saturating claims also avoid counter overflow at SIZE_MAX.
            auto task = next.load(std::memory_order_relaxed);
            while (task < tasks) {
                if (next.compare_exchange_weak(task, task + 1, std::memory_order_relaxed)) {
                    compute(task, 1);
                    task = next.load(std::memory_order_relaxed);
                }
            }
        }
    };
    // BENCHMARK-IMPORTANT: Every call creates and joins workers. The caller
    // participates; threads=1 creates none. Allocation/startup are timed costs.
    std::vector<std::thread> pool;
    pool.reserve(workers - 1);
    try {
        for (std::size_t id = 1; id < workers; ++id) pool.emplace_back(work, id);
    } catch (...) {
        // PERF-SEMANTICS: Join started threads before unwinding their captures.
        for (auto& thread : pool) thread.join();
        throw;
    }
    work(0);
    for (auto& thread : pool) thread.join();
}
} // namespace gemm
