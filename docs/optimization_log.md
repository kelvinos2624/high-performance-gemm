# Optimization log

## Milestone 1 — naive baseline (2026-10-05)

**Purpose:** establish correctness and a reproducible measurement path before
changing the algorithm. No optimization hypothesis is tested yet.

**Implementation:** row-major float `ijk`, with one float accumulator per output.
The independent reference uses double multiplication/accumulation and one final
conversion to float. Both implement C = AB, including empty dimensions.

**Environment:** Apple M2 Pro, arm64, 12 physical/logical cores, 16 GiB RAM;
macOS 14.8.3 (23J220); Apple Clang 14.0.3 (clang-1403.0.22.14.1);
CMake 4.4.4, Unix Makefiles. Single calling thread, no affinity controls.
Release kernel flags: `-O3 -DNDEBUG -std=c++17`, native tuning OFF, no explicit
fast-math or LTO. Compiler-default contraction and automatic transformations apply.

**Command:** `./build/release/gemm_benchmark > results/raw/baseline-2026-10-05-apple-m2-pro.csv`

**Method:** one validated warmup and five timed calls per size, median reported.
Reference evaluation, allocation, deterministic initialization, and per-run
checksum consumption are outside timing. Buffers are reused; caches are not flushed.
Builds and correctness tests completed before this run. Background system activity,
CPU frequency, and thermal state were not controlled. This is one baseline run,
not a statistically established performance range.

| M=N=K | Median ms | GFLOP/s |
| ---: | ---: | ---: |
| 64 | 0.150583 | 3.481721 |
| 128 | 1.706791 | 2.457421 |
| 256 | 15.256791 | 2.199311 |
| 512 | 141.017416 | 1.903562 |
| 1024 | 1219.808042 | 1.760510 |

Full precision and checksums: [raw CSV](../results/raw/baseline-2026-10-05-apple-m2-pro.csv).

**Interpretation:** throughput fell with increasing square size in this run.
The source traverses A contiguously but B with stride N in the inner loop.
That access pattern motivates the next experiment; timing alone does not establish
a cache bottleneck. No hardware-counter or assembly analysis has been performed.

**Validation:** Debug and Release CMake builds and CTest passed. A separate
Clang build with `-std=c++17 -Wall -Wextra -Wpedantic -g
-fsanitize=address,undefined` passed the same correctness suite. All five benchmark
sizes passed the element-wise reference guard. The optional native-tuned Release
build also passed CTest (`-mcpu=native` accepted on this host); its performance was
not measured. CLI rejection checks, even-repetition handling, and CSV GFLOP/s
arithmetic checks passed.

**Decision:** retain this implementation as the initial baseline. Next milestone:
implement and compare all six loop orders, with identical correctness and timing
conditions. No blocked, SIMD, unrolled, or parallel kernels have been added.

## Milestone 2 — loop-order experiment (2026-10-05)

**Hypothesis:** changing the inner traversal from strided B reads to contiguous
B/C updates can improve throughput through locality and compiler opportunities.
No gain or a regression in repeated same-build measurements would falsify the
expected benefit on the measured workload.

**Change:** retain `naive_ijk` and add explicit `ikj`, `jik`, `jki`, `kij`, and
`kji`. The accumulating orders zero C inside each timed call. Tests cover all
orders, and the benchmark can select any one or all six. Study markers identify
the loop nests, scalar reuse, initialization, and measurement boundaries.

**Result:** two Release sweeps on the same M2 Pro, one with reversed implementation
order, show `kij` leading at 64/128 and `ikj` leading at 256/512/1024. At 1024,
`ikj` measured 27.86 GFLOP/s versus 1.78 for the contemporaneous naive baseline
(primary sweep), a 15.67× speedup; the repeat speedup was 15.63×. All timed
configurations passed the reference guard. Debug, Release, and sanitizer
correctness checks passed.

**Interpretation:** the gain supports trying contiguous inner-j traversal for the
next milestone. It does not isolate cache behavior from compiler transformations,
and the best order depends on size. No claim of purely scalar generated code or
hardware-counter evidence is made. Some absolute timings varied between sweeps.

**Decision:** retain all six orders and use `ikj` as the larger-size candidate for
future cache blocking. No automatic dispatch or later-stage optimization added.
See [access patterns, full results, limitations, and graph](loop_orders.md).

## Milestone 3 — cache blocking (see metadata for run time)

**Hypothesis:** blocking can improve B-tile reuse across multiple output rows
relative to unblocked `ikj`. No improvement in repeated timings falsifies the
expected benefit for a tested configuration.

**Change:** explicit ii/kk/jj + i/k/j loops, independent runtime BM/BN/BK,
overflow-safe tail clamps, and one timed C initialization. Ten square/rectangular
tile choices were measured against contemporaneous `ikj` on four shapes, then
repeated in reverse configuration order. All previous kernels remain available.

**Result:** 64/256/64 improves throughput by 21–25% at 256 cubed; 32/128/32
improves it by 11–13% at 512 cubed. Every tested blocked configuration regresses
at 1024 cubed in both sweeps. The best blocked throughput there is only 85% of
`ikj`; the rectangular case shows smaller gains and changing winners.

**Interpretation:** tile capacity alone does not predict performance. Smaller
working sets introduce overhead and interact with compiler code generation.
This experiment measures total throughput, not the causal cache mechanism.

**Decision:** keep blocking as an experiment, retain `ikj` for the largest tested
square shape, and do not add a global winning tile or automatic dispatch.
Correctness passed Debug, Release, and sanitizer checks; all 88 benchmark
configurations passed reference validation. See [full analysis](cache_blocking.md)
for actual cache sizes, tables, reproducible commands, graph, and limitations.

## Milestone 4 — scalar register microkernels

**Hypothesis:** keep MR×NR partial C sums in registers across each K block to
reduce output traffic and expose independent arithmetic chains. Spilling or
repeated regressions against the same blocked driver challenge the benefit.

**Change:** retain macro order ii/kk/jj, add six fixed-extent scalar C++ tile
bodies (2×4 through 8×8 plus a 16×16 pressure case), and scalar edge cleanup.
Benchmark with macro shape fixed at 32/128/32, against contemporaneous blocked
and `ikj`; preserve earlier implementations. Inspect actual optimized assembly.

**Evidence:** 2×4 and 4×4 hold accumulators in registers across K. 4×8, 8×4,
and 8×8 spill inside K. 16×16 keeps its accumulator array in memory and the
compiler generates vector operations. At 512, 4×4 measured 24.46/24.02 GFLOP/s
versus blocked at 30.41/30.35 in primary/reverse sweeps. 16×16 beats blocked
at 1024 but is only near `ikj`; it is not an all-register success.

**Decision:** retain 4×4 as an inspectable register-resident candidate, not a
new universal performance default. Call overhead, compiler choices, reuse and
spills all contribute; these measurements do not isolate them. All tests and
64 benchmark reference guards passed. See [full results and assembly guide](microkernels.md).

## Milestone 5 — K-loop unrolling (2026-10-06)

**Hypothesis:** factors 2/4/8 reduce loop-control work and expose scheduling
opportunities in the 4×4 microkernel, improving throughput without spills.

**Change:** fixed consecutive K steps with the same sixteen accumulators and
increasing-K order. Keep the factor-1 body unchanged, macro dimensions fixed at
32/128/32, and scalar reduction cleanup for short/tail K blocks. No split chains,
new microtile, manual SIMD, or compiler-flag changes.

**Assembly:** requested expansion survives: 16/32/64/128 scalar FMAs per main
iteration for factors 1/2/4/8. Step helpers inline; no hot-loop stack spills.
Tile-body instruction bytes grow from 240 to 536/736/1072 (excluding metadata and
padding). Higher factors add function-entry register saves; those are not
reduction-loop spills.

**Measurements:** two four-shape sweeps plus a targeted seven-repetition follow-up
at 512. No stable general winner. At 512 and on the rectangular shape, expanded
factors lose in both sweeps. At 1024, small gains are observed but are insufficient
for a reliable tuning policy. An unusually low reverse-sweep factor-2 value did
not reproduce in the follow-up; its cause is unknown and the original is retained.

**Decision:** keep factor 1 as default and preserve the others as experiments.
Debug, Release, sanitizer, CLI/CSV checks and all 54 benchmark reference guards
passed. See [results and assembly guide](unrolling.md).
