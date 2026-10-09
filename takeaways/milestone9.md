# Milestone 9 Findings

This milestone implemented explicit NEON SIMD for the 4×4 microkernel and demonstrated that combining vector arithmetic with register reuse improves performance on the tested M2 Pro.


# Summary of Changes

The scalar microkernel maintained 16 individual output accumulators. The NEON version represents them as four vectors, each holding four adjacent columns of one output row.
For every K step, it:
1. Loads four contiguous B values into one vector.
2. Loads one A value from each of four rows.
3. Performs four vector fused multiply-adds, updating all 16 outputs.
4. Keeps those accumulators in registers until the K block finishes.
The implementation retains the existing macroblocking order and scalar cleanup for incomplete tiles. Earlier kernels remain available. Unsupported builds reject explicit NEON requests rather than silently substitute scalar code.


# How it was Done

Scalar and NEON use the same compiled driver, with BM/BN/BK = 32/128/32, a 4×4 microtile, and no manual K unrolling.
Assembly inspection initially revealed that Clang specialized the driver differently for NEON. We moved the shared driver into a separate translation unit and repeated the measurements, preserving the initial results separately.
The final experiment used two sweeps across six shapes, reversing implementation order. Each result was the median of five correctness-checked benchmark repetitions, with output initialization and tile dispatch included in timing.


# Performance-Related Observations

At 512³:
| Implementation | GFLOP/s across both sweeps |
|---|---:|
| Scalar 4×4 | 23.80–24.06 |
| Compiler-vectorized blocked | 29.80–30.39 |
| NEON 4×4 | **40.58–41.57** |

NEON delivered 1.70–1.73× scalar throughput and 1.34–1.39× blocked throughput. It therefore closed—and exceeded—the performance gap that motivated this experiment.
Assembly verified the intended mechanism:
- Four vector FMAs replaced sixteen scalar FMAs per K step.
- The hot loop contained 13 instructions instead of 26.
- Accumulators remained in v0–v3.
- There were no hot-loop stack accesses or helper calls.
These are static assembly findings, not hardware-counter measurements.

The measurements support the hypothesis that register reuse and explicit SIMD work effectively together for these configurations.
They do not establish a universal winner or a fourfold speedup. At 1024³, NEON was only about 1.4–2.3% ahead of ikj. The 3×5 control contained no complete 4×4 tile and executed only scalar cleanup, so it provided no SIMD speedup evidence.


# Lesson as a Phrase

SIMD pays off when vector arithmetic and register reuse are designed together