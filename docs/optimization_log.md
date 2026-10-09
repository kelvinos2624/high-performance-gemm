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

## Milestone 6 — compiler optimization and auto-vectorization (2026-10-06)

**Hypothesis:** contiguous `ikj`/blocked loops benefit from auto-vectorization;
scalar 4×4 and the naive general-N reduction should show smaller sensitivity.
Native tuning is tested rather than assumed helpful.

**Change:** add opt-in Clang/GCC vectorization reports and a fixed Clang
experiment covering O0, O2, O3, O3-native, and O3 with both vectorizers disabled.
Numerical kernels are unchanged. Build/test all variants, inspect reports and
actual assembly, then run matched primary/reverse sweeps on four shapes.

**Evidence:** at 512³, O3 `ikj` is 27.21/27.50 GFLOP/s versus 6.28/6.23 without
vectorizers. Blocked is 30.58/30.99 versus 5.49/5.48. The scalar 4×4 stays near
24 GFLOP/s. Naive's report says vectorized, but the vector path is guarded by
N=1; tested general-N shapes use scalar FMA. `ikj` has runtime alias checks and
a vector FMA fast path. Selected O3 and native instruction bodies are identical.

**Decision:** retain current defaults; diagnostics are optional. No explicit SIMD,
restrict, or fast-math introduced. The compiler already vectorizes contiguous
loops, while the scalar 4×4 is a possible target for a separate SIMD experiment.
All five builds passed all three correctness suites, all 160 sweep guards passed,
and an N=1 specialization check passed. See [full analysis](compiler_analysis.md).


## Milestone 7 — multicore row strips (2026-10-08)

**Hypothesis:** independent BM-row strips can exploit multiple cores while
preserving the auto-vectorized blocked arithmetic. Larger shapes should amortize
thread startup; flat or worse throughput would falsify benefit for a configuration.

**Change:** add a C++17 threads wrapper with static contiguous ranges and a dynamic
atomic task queue. Each worker owns whole output rows and all K contributions.
The caller participates; worker counts are capped by row strips. Thread allocation,
creation, zeroing, and joining remain inside whole-call timing. No earlier
numerical kernels change. Macrotiles stay fixed at 32/128/32 in the experiment.

**Evidence:** two 60-case sweeps cover five shapes and requests 1/2/4/8/12.
At 1024³, dynamic twelve-worker throughput is 162.67/167.45 GFLOP/s, or
7.16×/7.33× serial blocked and 5.91×/6.06× serial ikj. It beats static twelve
workers by 13.5%/17.1%; the advantage is not universal across worker counts and
shapes. A 16-row case caps at one worker and does not scale. Initial timing data
are retained separately after a metadata-only runner failure and rerun.

**Decision:** keep both schedules as explicit experiments, static/one worker as
default. No automatic tuning, persistent pool, K reduction or hardware-counter
claim. Release, Debug, ASan/UBSan suites and parallel TSan pass; 120 documented
benchmark guards pass, plus 60 from the initial sweep. See [full report](parallel.md).


## Milestone 8 — hardware profiling preparation (2026-10-08; incomplete)

**Question:** can counters substantiate the locality, instruction-throughput and
multicore explanations suggested by earlier timing and assembly evidence?

**Change:** add an explicitly selected sustained profiling mode to the existing
benchmark. Setup/reference/warmup precede a READY/GO boundary; final correctness
validation follows the interval. Add a macOS powermetrics collector with PID,
phase timestamps, raw output, build/source hashes and explicit failure status.
Numerical kernels are unchanged. No NEON work or new optimization is included.

**Validation:** all four Release suites pass. Profiling protocol checks cover
waiting for GO, rejecting invalid input/options and preserving ordinary CSV
behavior. Eight workload-only cases pass before/after correctness guards. Saved
smoke timings are not counter measurements or new performance conclusions.

**Blocker/evidence:** xctrace requires full Xcode; only Command Line Tools are
installed. powermetrics advertises per-process IPC but the privileged probe
requires a sudo password. Actual event availability and schema remain unverified.
No cache misses, IPC, instruction counts or bandwidth values have been measured.

**Next required step:** authenticated primary/reverse captures, field and interval
validation, then counter-backed analysis. Marking the milestone complete before
that would be misleading. See [methodology, hypotheses and commands](profiling.md).


### Milestone 8 capture review (2026-10-08)

The user completed both authenticated captures. Sixteen workloads passed their
before/after checks; source and binary hashes match across both sweeps and the
reviewed build. Added schema-aware, PID-specific analysis with conservative
whole-second timestamp bounds and seven synthetic selection/error-path tests.
Of 224 raw intervals, 108 interior intervals are retained; IPC uses summed
instructions divided by summed cycles, not an average of per-sample ratios.

Reported IPC at 512³ repeats closely: naive 1.70–1.72, ikj 3.27, blocked 4.40,
scalar 4×4 6.42–6.44, unroll-4 5.79. Scalar micro4's higher IPC accompanies lower
throughput than blocked, illustrating why IPC alone cannot rank GEMM efficiency.
Twelve-worker runs account for 8.3–8.7 CPU-equivalents and mix core types.
These are process-wide measurements, not isolated arithmetic-loop counts.

**Qualification:** every collector emitted `Second underflow occured.` without
PID/time attribution. The observed target records are finite and internally
consistent, but the warning's effect cannot be ruled out. All analysis records
are therefore explicitly provisional. No cache or bandwidth counters were
collected; no memory-bandwidth bottleneck or misses/FLOP claim is made. Raw
captures remain unchanged. Profiling/analysis work is delivered; warning-free
counter validation remains unresolved. See [reviewed report](profiling.md).


## Explicit NEON 4×4 — final requested SIMD experiment (2026-10-08)

**Hypothesis:** combine the scalar 4×4 tile's accumulator reuse with four-wide
FP32 arithmetic to close/exceed its gap to compiler-vectorized blocked GEMM.
Regression or hot-loop spills would argue against the intended benefit.

**Change:** four row-vector accumulators, one B vector per K step reused by four
A scalars, four explicit fused vector FMAs. Preserve macro order, scalar tails,
K sequence, single-thread execution and all older kernels. AArch64 compile check
and explicit unsupported-build error preserve portability without mislabeled fallback.

**Control:** initial assembly revealed Clang caller-specific driver specialization.
Move the shared driver to its own TU so both versions call the same generic body
without LTO. Preserve initial specialized-driver data separately and rerun matched
sweeps; use final data for reported conclusions.

**Evidence:** K loop has four vector FMAs versus sixteen scalar FMAs, 13 versus
26 static instructions, accumulators v0–v3, and no hot-loop stack accesses/calls.
At 512³ NEON reaches 40.58/41.57 GFLOP/s versus scalar 23.80/24.06 and blocked
30.39/29.80: 1.70–1.73× scalar and 1.34–1.39× blocked. Gains persist on odd shapes.
At 1024³, NEON beats blocked but is only 1.4%/2.3% above ikj. All-tail 3×5×257
executes no vector tile and provides no SIMD speedup evidence.

**Validation/decision:** Release, Debug, ASan/UBSan and NEON-disabled builds pass
all four suites, including new vector-tail/alignment/FMA tests. Both matched
sweeps pass 48 reference guards. Retain the explicit implementation, without a
universal dispatch policy or changes to threading. See [full report](neon.md).


## Final evaluation and closure (2026-10-09)

**Scope:** evaluate existing paths together, compare optional Apple Accelerate,
produce final progression/shape figures, and close the CPU study without adding
another optimization. Numerical kernels and their defaults are unchanged.

**Change:** add a benchmark-only optional Accelerate SGEMM adapter with row-major
alpha=1/beta=0 semantics, integer-range/empty handling and contract tests. Add a
matched ten-configuration/five-shape runner with seven repetitions, reversed-order
repeat, hashes/flags/environment metadata, coverage checks, ratios and plots.
Accelerate default and VECLIB_MAXIMUM_THREADS=1-requested policies are distinct;
actual library thread counts are unknown and are not presented as measured.

**Results:** at 512³, naive reaches 1.87/1.88 GFLOP/s, NEON 40.75/39.56, dynamic
blocked 187.90/184.28, and default-policy Accelerate 2105.38/2335.91. NEON is
21.05–21.80× naive; dynamic blocked is 98.03–100.52× naive and 7.89–8.92% of
Accelerate. At 1024³ dynamic is 93.26–94.41× naive and 6.36–6.97% of Accelerate.
Scalar/unrolled regressions remain visible. Multicore and NEON are separate
branches. Short/wide shapes expose row-strip parallelism limits.

**Validation:** enabled/disabled Release builds pass all five suites. All 100
full-sweep guards pass. A short/wide unroll outlier is retained; twelve targeted
follow-up cases pass and do not reproduce its low value. No cause is asserted.

**Conclusion:** substantial speedup over naive is established, as is a large
remaining vendor-library gap. Cache-miss, bandwidth, peak-efficiency and vendor
instruction-path explanations are not proven. Prior counter findings retain
their underflow-warning qualification. The evaluation phase is closed with these
limits documented in [the final report](final_evaluation.md); no further tuning,
packing, SIMD/thread combination or takeaways edits were made.
