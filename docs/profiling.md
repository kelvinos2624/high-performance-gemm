# Milestone 8: hardware-counter profiling

Status: **both captures collected and analyzed; counter observations are provisional
because the collector emitted unlocalized underflow warnings.**
No numerical kernel was changed. Explicit NEON SIMD remains an unimplemented
Milestone 6 extension; the numbered Milestone 8 is hardware profiling.

## What this experiment asks

The earlier results establish throughput differences and compiler instruction
choices. They do not by themselves establish cache-miss rates, achieved IPC,
DRAM bandwidth, or the cause of sublinear multicore scaling.

| Comparison | Existing evidence | Counter hypothesis | Evidence against the hypothesis |
|---|---|---|---|
| naive vs ikj | Contiguous inner-j traversal is faster; vector FMA appears in ikj | Fewer cache misses per FLOP and/or fewer instructions per FLOP | No corresponding reduction in measured events; investigate other contributors |
| ikj vs blocked | Benefits depend on shape and block size | Reuse reduces cache misses per FLOP where blocking wins | Equal/higher misses despite higher throughput |
| blocked vs scalar 4×4 | 4×4 retains accumulators but uses scalar FMA | Accumulator reuse reduces load/store work, while scalar arithmetic limits throughput | Measured instruction mix/traffic fails to support the proposed tradeoff |
| micro4 vs unroll4 | More code, same scalar accumulators; mixed timing results | Less loop overhead or higher IPC may offset expansion | No IPC or normalized-instruction benefit, or an offsetting cost |
| static4/static12/dynamic12 | Dynamic helps some large cases; speedup is sublinear | Load balance, core placement or shared-resource limits constrain scaling | Worker traces or bandwidth measurements contradict the proposed cause |

These are hypotheses, not counter findings. Loop ordering also changes
vectorization, so miss counts alone cannot isolate its entire speedup.
IPC is instructions/cycles, not FLOPs/cycle. A vector instruction can do more work
than a scalar instruction; higher IPC alone does not imply a faster GEMM.

## Local tool availability

The current Mac has Apple M2 Pro / arm64 and Command Line Tools. `xctrace` is a
launcher here and reports that full Xcode is required. No full Xcode installation
was found under `/Applications`. `perf` is not installed.

The first privileged probe required a password; the user subsequently ran both
captures successfully on 2026-10-08. The historical capability probe is preserved
under `results/profiling/capabilities/`. Actual captures contain `cpu_instructions`,
`cpu_cycles`, `pcpu_instructions`, `pcpu_cycles`, `cputime_ns`, and `ptime_ns` for
the target PID. Local `man powermetrics` describes instructions/cycles on ARM and
cluster statistics with `--show-process-amp`; the text probe labels the latter
P-Instr/s, P-Cycles/s and PCPU. Per-sample plist records explicitly say `is_delta`.
These are interval counts, not cumulative totals; IPC is computed from their sums.

No private PMU APIs, security configuration changes, or guessed event IDs are
used. powermetrics is not assumed to provide cache-miss or DRAM-bandwidth events.
If those remain unavailable, the cache/bandwidth questions remain open; they need
a supported Instruments counter configuration or profiling on another platform.
Cross-machine results must not be merged with M2 timings as one experiment.

## Profiling boundary

The existing benchmark now supports `--profile-seconds SECONDS` for one explicit
kernel and shape. It allocates matrices, creates the double reference, runs a
warmup and validates the warmup before writing `PROFILE_READY` to stderr.
With `--profile-wait`, it then blocks for `GO` on stdin. EOF or any other command
fails. The collector starts while the workload waits; the harness then sustains
whole GEMM calls for the requested duration, writes `PROFILE_DONE`, validates the
final matrix and emits a separate profiling CSV.

The CSV records call count, elapsed seconds and **sustained average GFLOP/s**,
not a median. It must not be appended to ordinary benchmark CSVs. A clock check
per call is inside this interval. Checksums/reference/setup are outside it.
There is no per-call checksum scan, unlike the ordinary benchmark; this changes
cache state, so use ordinary unprofiled benchmarks for performance comparisons.
The default Release build has separate kernel translation units and no LTO.

Parallel calls still include thread creation/joining and worker allocation.
That lifecycle is part of the existing algorithm under study. The profiler's
process-wide counts also include the harness clock checks and dispatch; they
are not exact hot-loop instruction counts.

The capture script records workload PID, GO/DONE wall-clock and monotonic receipt
timestamps, binary/source hashes, exact compiler commands and raw NUL-separated
plist samples. Phase timestamps bracket the loop conservatively; they are not
hardware markers. Exclude samples overlapping phase boundaries. If timestamps or
sample interval semantics cannot establish full containment, do not analyze those
samples. Exclude at least the first and last overlapping intervals; readiness
alone is not sufficient to claim kernel-only counters.

## Run the capture

Build and validate first:

```sh
cmake -S . -B build/m8-release -DCMAKE_BUILD_TYPE=Release
cmake --build build/m8-release --parallel
ctest --test-dir build/m8-release --output-on-failure
python3 tests/test_profile_protocol.py build/m8-release/gemm_benchmark
```

Then in your own terminal, from the repository directory:

```sh
sudo -v
python3 scripts/profile_counters.py --output results/profiling/counters-primary
python3 scripts/profile_counters.py --reverse --output results/profiling/counters-reverse
```

Only the powermetrics collector runs through `sudo -n`; the script and GEMM stay
under the normal user. The script does not request, read or save passwords.
Run the two sweeps sequentially. Each uses eight configurations at 512³,
32/128/32 macrotiles, and ten-second workloads. Outputs must be new directories
so earlier evidence cannot be overwritten. `--size 1024` enables a separate
larger-shape follow-up, with a different output directory.

Capture files are marked **captured-unreviewed**, even when the collector exits
successfully. Collector success alone does not establish usable event data.
Review the actual schema and target PID before writing an analyzer; do not guess
field names, counter units, or aggregate semantics. Privilege/probe failures are
recorded as failed captures and never converted to zero-valued counters.

For an unprivileged protocol test:

```sh
python3 scripts/profile_counters.py --workload-only --seconds 1 --size 64 --output results/profiling/my-smoke
```

`workload-only` explicitly collects **no counters**. Saved smoke outputs verify
execution and correctness, not performance claims. Both schedules, scalar,
blocked, microkernel and unrolled dispatch paths passed local smoke checks.
All four Release correctness suites passed, along with integration checks for
GO gating, invalid commands/options, final validation and ordinary CSV behavior.

## How to analyze a successful capture

1. Verify binary/source hashes and matched build flags, dimensions, tiling,
   unroll factors and actual worker counts. Use target PID, not process name alone.
2. Inspect available fields, units, missing/invalid markers, and sample timestamps.
   Report absent counters as unavailable. Do not substitute whole-system values
   for per-process data. Investigate whether short-lived worker activity is covered
   before interpreting parallel process IPC.
3. Select only complete steady workload intervals. Preserve raw samples and show
   sample count/spread across both sweeps; do not silently drop inconvenient values.
4. If instruction and cycle counts are exposed for matching intervals, aggregate
   IPC as total instructions / total cycles. Do not take an unweighted mean of
   per-core IPC ratios. Keep heterogeneous cluster results separate when needed.
5. Instructions/FLOP and misses/FLOP require a matching work denominator. The CSV
   call count spans the full profiling loop, not just selected interior samples;
   do not divide an interior counter sum by all calls. Add interval-matched work
   accounting or a counter region before making those quantitative claims.
6. Compare the observations with the hypotheses above. A memory-bandwidth limit
   requires bandwidth evidence; sublinear speedup alone is insufficient.

## Reviewed captures: 512³ on M2 Pro

Run the deterministic analysis with:

```sh
python3 scripts/analyze_counters.py results/profiling/counters-primary results/profiling/counters-reverse --output results/profiling/analysis.json
PYTHONDONTWRITEBYTECODE=1 python3 tests/test_counter_analysis.py
```

Both sweeps use the same binary and source hashes, verified against the current
captured sources and binary during review. All sixteen workloads completed their
before/after correctness checks. Each capture contains fourteen delta samples.
The analyzer matches PID, requires positive finite counters, rejects invalid or
cumulative records, and checks wall-clock elapsed time against monotonic time.
It retains six or seven interior samples per case, 108 total out of 224 samples.

The plist timestamps have whole-second precision. For timestamp t and interval d,
we conservatively bound the interval by [t - 1 - d, t + 1], using the larger of
the sample and task intervals. That entire bound must fit inside GO+0.1s to
DONE-0.1s. This covers rounding/truncation and adds a receipt guard; it is not a
hardware marker or proof against arbitrarily delayed userspace event delivery.
Raw metadata is retained unchanged; analysis.json records sample indices,
exclusions, sums, ranges, raw hashes, and quality flags separately.

### Collector qualification

Every case's stderr contains one or more **`Second underflow occured.`** warnings.
The warning has no PID or sample timestamp. Inspection of the installed
`/usr/bin/powermetrics` disassembly places the message immediately after a
`pm_task_subtract_version` call and an underflow flag test; this is evidence of
a task-accounting subtraction path, not proof that GEMM was unaffected. No target
record is marked invalid and selected counter values are positive and stable,
but these checks cannot resolve the warning's effect. All reported counter
observations therefore carry `provisional-collector-warning`, not clean validation.
Unknown diagnostics still stop the analyzer. Neither repeated agreement nor
finite numbers justify silently discarding this warning.

### Observations (primary / reverse)

IPC and CPU-equivalents use selected interior intervals. GFLOP/s is the full
sustained profiling loop's average, shown as context; it is not an unprofiled
median and is not used as an interval-matched FLOP denominator.

| Kernel | Reported IPC | CPU-equivalents | Sustained GFLOP/s |
|---|---:|---:|---:|
| naive | 1.703 / 1.716 | 1.00 / 1.00 | 1.93 / 1.94 |
| ikj | 3.269 / 3.268 | 1.00 / 1.00 | 28.11 / 28.07 |
| blocked | 4.405 / 4.403 | 1.00 / 1.00 | 31.75 / 31.71 |
| scalar 4×4 | 6.424 / 6.443 | 1.00 / 1.00 | 25.67 / 25.03 |
| scalar 4×4, unroll 4 | 5.795 / 5.794 | 1.00 / 1.00 | 25.39 / 24.68 |
| static, 4 workers | 4.327 / 4.327 | 3.95 / 3.95 | 113.85 / 113.31 |
| static, 12 workers | 3.864 / 3.920 | 8.31 / 8.29 | 204.37 / 200.05 |
| dynamic, 12 workers | 3.831 / 3.839 | 8.67 / 8.59 | 208.96 / 202.88 |

CPU-equivalents = sum(task CPU time) / sum(task interval time). It measures
aggregate scheduled CPU time, not distinct physical cores or simultaneous worker
count. Four-worker accounting approaches four CPU-equivalents, which supports
that process accounting includes worker activity; no per-thread trace proves
complete short-lived-thread counter coverage. Twelve-worker arithmetic includes
creation/join, serial portions and imbalanced task completion.

### Architectural interpretation

- The scalar microkernel reports the highest IPC yet lower throughput than
  vectorized blocked GEMM. This fits the earlier assembly finding: many scalar
  instructions can retire while doing less arithmetic per instruction. IPC alone
  cannot rank numerical efficiency. These captures do not measure exact
  instructions/FLOP because interior counts and full-loop work differ in scope.
- Unroll-4 IPC is about 5.79 versus 6.42–6.44 for factor 1, with slightly lower
  sustained throughput in both runs. This does not support the hypothesis that
  manual unrolling improves IPC for this configuration. It does not prove which
  dependency, scheduling, or code-size effect accounts for the difference.
- ikj and blocked report higher IPC than naive, consistent with the earlier
  locality/vectorization story. No cache-miss events were captured, so these
  measurements cannot establish a reduction in L1/LLC misses or isolate its cause.
- Twelve-worker runs report roughly 8.3–8.7 CPU-equivalents, with about 79.5–81.1%
  of task CPU time on performance cores. Single-thread and four-worker cases are
  approximately 100% performance-core time. Aggregate twelve-worker IPC combines
  core types: its lower value cannot be assigned solely to contention. The
  performance-core-only IPC is about 4.19–4.29, closer to static4's 4.33.
- Dynamic twelve-worker runs report somewhat more CPU time and higher sustained
  throughput than static in both sweeps. That is consistent with improved worker
  utilization, but does not prove load balancing is the cause. There are only
  sixteen BM-row strips at M=512, so ownership granularity also matters.

No cache misses, branch misses, DRAM bandwidth, power, or thermal counters were
collected by this tasks-only sampler. A bandwidth bottleneck remains unproven.
Other processes were active during sampling; their data are excluded from target
ratios, but their contention and profiling overhead are not eliminated.

Milestone 8 now has an implemented profiling workflow, real captures and a
reproducible architectural analysis within the available event set. The remaining
qualification is collector reliability: final counter validation needs a clean
independent capture or a verified explanation of the warning. This report does
not certify these observations as warning-free hardware measurements.
