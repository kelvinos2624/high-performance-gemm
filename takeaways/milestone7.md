# Milestone 7 Findings

Milestone 7 established that the existing blocked GEMM can gain substantial throughput through multicore execution, while preserving its arithmetic and correctness.


# Summary of Changes

- Added a parallel implementation that divides C into BM-row strips. Each worker computes all columns and the complete K reduction for its assigned rows.
- Added two scheduling policies:
  - Static: assign contiguous groups of strips to workers upfront.
  - Dynamic: workers claim individual strips from an atomic task queue.
- Added thread-count and scheduling controls, scaling benchmarks, correctness tests, plots, and reproducibility metadata.
- Preserved all earlier kernels for comparison.
The caller participates as a worker. Worker count is capped by the available strips, and each GEMM call creates and joins its threads.


# How it was Done

The experiment reused the existing blocked kernel with BM/BN/BK = 32/128/32, isolating threading from changes to the numerical algorithm.
We tested 1, 2, 4, 8, and 12 requested workers across five matrix shapes. Two sweeps reversed configuration order to check repeatability. Each result used a correctness-checked warmup followed by the median of five timed calls.
Timing included thread allocation, creation, output initialization, computation, and joining. Input preparation, reference computation, and checksums stayed outside timing.


# Performance-Related Observations

At 1024³:

| Configuration | Throughput across two sweeps |
|---|---:|
| Serial blocked | 22.71–22.85 GFLOP/s |
| Static, 12 workers | 142.94–143.34 GFLOP/s |
| Dynamic, 12 workers | 162.67–167.45 GFLOP/s |

Dynamic scheduling delivered 7.16–7.33× the matched serial blocked throughput. Compared with the faster serial ikj baseline, it delivered 5.91–6.06×.

This demonstrated that:
- Disjoint output ownership supports effective parallelism. Each output has one writer, so arithmetic needs neither locks nor a cross-thread reduction.
- Large workloads amortize thread startup costs. Strong gains remained even with the complete thread lifecycle included.
- Scheduling policy can matter. Dynamic beat static by approximately 13.5–17.1% at 1024³ with twelve workers.
- Task decomposition limits scaling. The 16-row case exposed only one strip with BM=32, so requesting more workers provided no additional parallelism.

Overall, dynamic scheduling is not universally better: static won at four workers on 512³, and other comparisons varied between sweeps.
The results also do not identify the cause of sublinear scaling. Load imbalance, core assignment, startup costs, and shared hardware resources remain possible contributors; hardware counters and per-worker traces were not collected.


# Lesson as a Phrase

Parallelism scales when work can be partitioned without sharing the critical path.
More workers only help when the decomposition exposes enough independent work.
