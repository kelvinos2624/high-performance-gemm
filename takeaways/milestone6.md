# Milestone 6 Findings

Milestone 6 established what the compiler already does for the existing GEMM kernels and how much their performance depends on it. Unlike earlier milestones, it changed the build and analysis tools rather than the numerical algorithms.


# Summary of Changes

- Added optional compiler optimization reports through GEMM_VECTORIZATION_REPORTS.
- Added reproducible scripts to build, test, benchmark, and inspect five compiler configurations.
- Saved compiler remarks, generated assembly, exact build commands, test logs, source hashes, and benchmark results.
- Added a comparison graph and an analysis connecting source loops to the machine code they execute.
The existing kernels and default build settings remain unchanged.


# How it was Done

Compared five builds of the same source:
    Build	Purpose
    -O0	    Unoptimized reference point
    -O2	    Optimized baseline
    -O3	    Current optimization level
    -O3     with native tuning	Test whether host-specific tuning helps
    -O3     with both Clang vectorizers disabled	Measure sensitivity to auto-vectorization

Each build ran the full correctness suite. Benchmarks then compared naive_ijk, ikj, blocked GEMM, and the original 4×4 microkernel on three square sizes and one odd rectangular shape.
Macro dimensions stayed at 32×128×32, and microkernel unrolling stayed at factor 1. We used validated warmups, five measured calls, median timings, and a reverse-order repeat.
Assembly was generated using the actual kernel compile flags—not a separate set of experimental settings.


# Performance-Related Observations

Measurements at 512^2:
| Kernel | O3 | O3 without vectorization |
|---|---:|---:|
| Naive `ijk` | 1.87 GFLOP/s | 1.88 GFLOP/s |
| `ikj` | 27.21 GFLOP/s | 6.28 GFLOP/s |
| Blocked | 30.58 GFLOP/s | 5.49 GFLOP/s |
| 4×4 microkernel | 24.18 GFLOP/s | 24.30 GFLOP/s |

The reverse sweep showed the same pattern. This provides strong evidence that compiler vectorization contributes substantially to ikj and blocked throughput, while the selected 4×4 body already uses scalar arithmetic.
Disabling vectorizers also changes surrounding generated code, so these ratios are not measurements of SIMD instruction speed alone.

Comparing the non-vectorized builds also shows that the 4×4 microkernel’s register blocking was valuable in scalar execution: at 512² it sustained 24.30 GFLOP/s versus 6.28 for ikj and 5.49 for blocked GEMM.

Additional findings:
- Contiguous loops already receive SIMD. ikj and blocked GEMM contain vector FMA fast paths and scalar cleanup.
- Aliasing uncertainty does not always prevent vectorization. ikj checks whether the relevant B and C address ranges overlap, then chooses a vector or scalar path.
- A “vectorized” remark can describe a special case. Naive GEMM has a vector path guarded by N == 1. The general-matrix shapes in the sweep execute its scalar loop.

The milestone demonstrated that source structure strongly affects compiler output, and that reports must be interpreted alongside assembly and workload dimensions.

It did not establish a universal advantage for O3 over O2, a native-tuning win, or the precise hardware causes of every timing difference. No hardware counters were collected.


# Lesson as a Phrase

Register blocking significantly improved scalar execution, but compiler-generated SIMD on simpler loop structures was even more valuable.
