# Milestone 1 Findings

This milestone establishes the baseline for this project. 


# Summary of Changes

CMake project: 
    C++17 builds for Debug and Release, plus optional native CPU tuning.
Matrix representation: 
    contiguous row-major float storage, raw-pointer access, and dimension-overflow checks.
Two GEMM implementations: 
    both compute C = AB. The naive kernel uses the canonical ijk loop with float accumulation; the reference accumulates in double before converting to float.
Correctness tests: 
    known answers, identity and zero matrices, negative values, rectangular and odd dimensions, deterministic random inputs, empty dimensions, and repeated-call overwrite behavior.
Benchmark harness: 
    configurable square sizes and repetitions, warmup, correctness verification, median timing, GFLOP/s, and CSV output.
Documentation: 
    build instructions, your project charter, and a baseline experiment log with actual measurements.


# How It Was Done

The implementation keeps the computational loops directly inspectable. There are no allocations or abstractions inside the kernels.
Testing compares results against known answers and the higher-precision reference using floating-point tolerances. Checks remain active in Release builds.

For each benchmark size, the harness:
1. Allocates and initializes matrices using fixed random seeds.
2. Computes the reference result.
3. Runs and validates an untimed warmup.
4. Times five kernel calls using steady_clock.
5. Consumes each output through a checksum outside timing.
6. Reports median latency and throughput using 2MNK / elapsed_seconds


# Performance-Related Observations

Baseline Metrics:

| Square dimension  | Median time   | GFLOP/s   |
|-------------------|---------------|-----------|
| 64                | 0.151 ms      | 3.48      |
| 128               | 1.707 ms      | 2.46      |
| 256               | 15.257 ms     | 2.20      |
| 512               | 141.017 ms    | 1.90      |
| 1024              | 1219.808 ms   | 1.76      |

In this run:
- Throughput decreases as matrix size increases
- Runtime seems to scale cubically with matrix dimensions, as expected

Conventional GEMM is FLOPS = 2MNK -> GFLOPS/s = (2MNK)/(T*10^9) approximated, T = runtime
Exact equation is 2MN(K-1)/(T*10^9) but for large matrices, the approximation is fine

# Lesson in a Phrase

Baseline naive-implementation of GEMM shows an expected cubic relationship for median time as the matrix grows.
