# Milestone 2 Findings

This milestone evaluates all six permutations of the three GEMM loops to measure how iteration order affects performance while preserving the same C=AB computation.


# Summary of Changes

- Added ikj, jik, jki, kij, and kji, preserving the original naive_ijk.
- Extended correctness tests to cover all six implementations.
- Added benchmark selection through --implementation.
- Added scripts for repeatable sweeps and plotting.
- Saved two measured sweeps, build metadata, source hashes, a comparison graph, and an analysis of memory-access patterns.


# How It Was Done

The five new implementations use explicit, inspectable loop nests. Two important choices preserve equivalent behavior:
- ijk and jik: accumulate one dot product locally, then write C once.
- The other four orders: zero C before accumulating into it. That initialization is necessary for C = AB and is included in the measured time.
Each implementation was checked against the double-accumulating reference. Tests covered known answers, rectangular and odd shapes, empty dimensions, input preservation, and overwriting existing output.
Performance measurements used the same Release binary, deterministic inputs, an untimed validated warmup, and five timed repetitions per configuration. We tested square dimensions from 64 to 1024, then repeated the sweep in reverse implementation order.


# Performance-Related Observations

Loop ordering affects throughput:
    At 1024^2, ikj reaches 27.86 GFLOP/s vs 1.78 for ijk
The large improvement persists across sweeps
    Speedup was 15.67x then 15.63x in the reverse-order repeat
No single order won at every tested size
    kij won at 64^2 and 128^2, ikj won at 256^2 to 1024^2 in both sweeps

These results support the idea that contiguous inner-loop traversal is beneficial here.
They do not necessarily prove that cache locality alone explains the speedup.

The inner-i orders (jki, kji) degraded sharply at larger dimensions, consistent with their simultaneous stride-\(N\) traversal of A/C. Hardware-counter analysis would be needed to identify the specific cause.

# Lesson in a Phrase

Loop ordering has observable benefits, supporting the desire for computing contiguously aligned data. Further information cannot necessarily be extracted from this milestone alone.
