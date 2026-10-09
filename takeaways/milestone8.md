# Milestone 8 Findings

Milestone 8 added hardware-counter profiling and a reproducible analysis workflow. It studied the existing kernels; it did not introduce a new GEMM optimization.


# Summary of Changes

Added a sustained profiling mode to the benchmark.
Added a macOS powermetrics collector that records the workload PID, execution boundaries, raw samples, and build/source hashes.
Added an analyzer that selects relevant samples and computes IPC and CPU utilization.


# How it was Done

Each workload first allocated its matrices, computed the reference, and validated a warmup. It then waited for the collector before repeatedly executing GEMM for ten seconds. Final correctness validation happened afterward.
Two sweeps tested eight configurations at 512³, reversing their order on the second sweep. These covered naive, ikj, blocked, scalar 4×4, unroll-4, and three parallel configurations.

The analyzer:
- Matched samples to the exact workload PID.
- Excluded setup, shutdown, and uncertain boundary intervals.
- Retained 108 interior samples from 224 recorded intervals.
- Calculated IPC as total instructions ÷ total cycles, rather than averaging ratios.
- Verified matching source and binary hashes.


# Performance-Related Observations

| Implementation | Reported IPC across both sweeps |
|---|---:|
| Naive | 1.70–1.72 |
| `ikj` | 3.27 |
| Blocked | 4.40 |
| Scalar 4×4 | 6.42–6.44 |
| Scalar 4×4, unroll-4 | 5.79 |

The most useful observation was that higher IPC did not imply faster GEMM. Scalar 4×4 reported the highest IPC but remained slower than compiler-vectorized blocked GEMM. This fits the earlier assembly evidence: scalar instructions can retire rapidly while accomplishing less arithmetic per instruction.
Unroll-4 reported lower IPC and slightly lower throughput than factor 1. For this configuration, the measurements did not support the hypothesis that manual unrolling improves IPC.
Twelve-worker configurations reported 8.3–8.7 CPU-equivalents, with activity spread across different core types. That makes worker utilization and core placement relevant to interpreting scaling; twelve requested workers do not imply twelve cores continuously executing useful arithmetic.

The milestone established a working, tested profiling pipeline and produced repeatable counter observations. All sixteen workloads passed their correctness checks, and seven analyzer tests passed.
However, the counter conclusions remain provisional. Every capture emitted Second underflow occured. without identifying the affected process or sample. The selected records were consistent, but that does not prove the warning harmless.
Also collected no cache-miss or DRAM-bandwidth counters. Consequently, this milestone did not prove that blocking reduced cache misses or that memory bandwidth limits multicore scaling.


# Lesson as a Phrase

IPC measures instruction throughput, not computational efficiency.
