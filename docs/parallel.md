# Milestone 7: multicore row-strip experiment

## Hypothesis and design

The Milestone 6 blocked inner loop already uses compiler-generated vector FMA.
Independent rows offer more parallel work than one core can execute. Distributing
BM-row strips should raise throughput on large matrices, until startup,
scheduling, shared memory/cache resources, or available cores limit scaling.
Flat or worse throughput versus the same serial blocked kernel falsifies the
benefit for that shape/configuration. Hardware-counter attribution is deferred.

`src/gemm_parallel.cpp` implements ownership and scheduling; the numerical body
remains `src/gemm_blocked.cpp`. Each task is BM rows by all N columns, internally
subdivided by BN and BK. Each output has one owner for its entire K reduction,
so there are no shared output accumulators, locks around arithmetic, atomics on
C, or cross-thread floating-point reductions. Inputs are read-only. Per-element
K order remains unchanged. Workers initialize their own rows through `blocked`.

Static scheduling divides the row-strip count into contiguous ranges differing
by at most one strip. Dynamic scheduling uses a relaxed atomic compare/exchange
counter to claim one strip at a time. Relaxed ordering is sufficient for unique
IDs; `join` supplies completion synchronization. Saturating claims avoid counter
overflow. Dynamic scheduling can rebalance unequal task times, including tail
strips and OS core assignment, but adds queue traffic and can scatter ownership.

The calling thread participates. Requested threads are capped at ceil(M/BM),
with no platform-dependent automatic core count. `threads` in CSV is this cap;
`requested_threads` preserves the requested setting. This is a worker count,
not a claim that every worker ran simultaneously or on a particular core.
The default is one worker with static scheduling. Each invocation creates and
joins threads. Launch failure joins all successfully launched workers before
throwing; output may have been partially written. Invalid settings are rejected
before any buffer access, including empty shapes.

Why this design: row strips reuse the existing ii/kk/jj blocked body and avoid
splitting adjacent columns among workers. Cache lines can still straddle row
boundaries, especially with odd N; no alignment or complete absence of false
sharing is promised. Two-dimensional output tasks would expose more concurrency
for short/wide matrices, but alter traversal/reuse and increase ownership
boundaries. Splitting K would require reductions and a different rounding path.
A persistent pool could amortize startup, but would measure a different lifecycle.
These alternatives are deliberately left for separate experiments.

## Reproduction and measurement

```sh
cmake -S . -B build/m7-release -DCMAKE_BUILD_TYPE=Release
cmake --build build/m7-release --parallel
ctest --test-dir build/m7-release --output-on-failure
build/m7-release/gemm_benchmark --implementation parallel --threads 8 --schedule static --bm 32 --bn 128 --bk 32 1024
python3 scripts/benchmark_parallel.py --output results/raw/parallel-primary.csv
python3 scripts/benchmark_parallel.py --reverse --output results/raw/parallel-reverse.csv
python3 scripts/plot_parallel.py
```

Recorded machine: Apple M2 Pro, 12 cores, arm64, 16 GiB; Apple Clang 14.0.3,
macOS 14.8.3. Release kernel flags: `-O3 -DNDEBUG -std=c++17`, native tuning off,
no fast-math. Metadata beside each CSV records exact compilation commands,
source/binary hashes, timestamp, and all benchmark commands. No affinity or QoS
control was used, so scheduling across core types is uncontrolled.

The matched primary/reverse sweeps each cover five shapes, serial blocked and
ikj, and static/dynamic parallel at 1/2/4/8/12 requested workers: 60 cases per
sweep. Macrotiles are fixed at 32/128/32 to isolate threading. Each case runs in
its own process, validates one warmup against the double reference, then reports
the median of five timed calls. Input allocation/randomization/reference and
checksums are outside timing; worker-vector allocation, thread creation, output
zeroing, computation and joins are inside. Benchmarks run sequentially.

An initial 60-case sweep is preserved as `parallel-initial.csv`. Its timing and
correctness guards completed, but metadata writing failed due to a relative-path
bug in the runner. After fixing path resolution, both documented sweeps were
run again. The initial sweep is not used in the plotted comparisons.

## Validation

All four correctness suites pass in Release, Debug, and AddressSanitizer plus
UndefinedBehaviorSanitizer builds. The parallel suite also passes ThreadSanitizer.
Tests exercise both schedules, 1/2/4/12 workers, capped enormous requests, tiny,
odd, rectangular and empty matrices, K=0 with null inputs, several block shapes,
SIZE_MAX tile extents, NaN output overwrite, repeated calls, input preservation,
output sentinels, and invalid settings. Parallel results are compared with both
the double reference (tolerance) and serial blocked (exact on these tested inputs).
No claim of exhaustive race detection or portability validation follows from
one platform's sanitizer run.


## Results and interpretation

Numbers below are primary / reverse medians, in GFLOP/s. Speedup denominators
are the same sweep's serial blocked result, not an older baseline.

| Shape M×N×K | Serial blocked | Static, 12 requested | Dynamic, 12 requested | Dynamic speedup |
|---|---:|---:|---:|---:|
| 128×128×128 | 31.86 / 32.22 | 49.64 / 54.24 | 52.51 / 51.20 | 1.65× / 1.59× |
| 512×512×512 | 31.06 / 31.18 | 171.64 / 185.27 | 183.76 / 189.46 | 5.92× / 6.08× |
| 1024×1024×1024 | 22.71 / 22.85 | 143.34 / 142.94 | 162.67 / 167.45 | 7.16× / 7.33× |
| 255×513×257 | 21.06 / 22.68 | 94.96 / 100.59 | 97.56 / 101.70 | 4.63× / 4.48× |
| 16×1024×512 | 22.99 / 22.55 | 23.01 / 22.95 | 22.99 / 23.15 | 1.00× / 1.03× |

Only 512 and 1024 actually use twelve workers. The other shapes cap at four,
eight, and one respectively. Different timings at requests above the cap are
repeat measurements of the same worker configuration, not additional scaling.
This matters particularly for the noisy 128 case. BM is a scheduling granularity
as well as a cache parameter here; changing it would require a new experiment.

At 1024, dynamic scheduling with twelve workers improves over static by
13.5% / 17.1%. It achieves about 60% / 61% parallel efficiency relative to twelve
times serial blocked throughput. That simple efficiency metric does not model
heterogeneous core speeds. The same dynamic result is 5.91× / 6.06× serial ikj,
which is faster than serial blocked at this size; both baselines are retained.
At 512, dynamic twelve-worker throughput improves over static by 7.1% / 2.3%,
but static wins at four workers (116.37/118.36 versus 113.15/112.35). At eight
workers the 512 scheduling winner reverses. There is no universal schedule winner.

One-worker parallel results broadly track serial blocked, establishing that the
wrapper does not explain the large multicore gains. Large shapes provide enough
work to amortize the measured lifecycle. The short/wide case cannot exploit
additional cores with this decomposition. Smaller cases and capped repeats vary
more; these two sweeps are observations, not confidence intervals or tuning rules.
Dynamic's advantage at 1024 is consistent with improved load balancing, but no
per-worker traces, affinity experiments or hardware counters identify its cause.
Likewise, sublinear scaling does not by itself prove a memory-bandwidth bottleneck.

Decision: retain both explicit schedules and worker control. Keep static/one
worker as the API and CLI defaults; do not introduce automatic selection from
this small sweep. Preserve all previous kernels and data. All 120 documented
benchmark guards passed, as did the 60 initial-sweep guards.

![Scaling and throughput](../results/plots/parallel.png)

Sanitizer reproduction (separate builds):

```sh
cmake -S . -B build/m7-sanitize -DCMAKE_BUILD_TYPE=Debug '-DCMAKE_CXX_FLAGS=-fsanitize=address,undefined -fno-omit-frame-pointer'
cmake --build build/m7-sanitize --parallel
ctest --test-dir build/m7-sanitize --output-on-failure
cmake -S . -B build/m7-tsan -DCMAKE_BUILD_TYPE=Debug '-DCMAKE_CXX_FLAGS=-fsanitize=thread -fno-omit-frame-pointer'
cmake --build build/m7-tsan --target gemm_parallel_tests --parallel
build/m7-tsan/gemm_parallel_tests
```
