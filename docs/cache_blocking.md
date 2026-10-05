# Milestone 3 — configurable cache blocking

## Hypothesis and implementation choice

Unblocked `ikj` revisits the full B matrix for each output row. The hypothesis is
that limiting each region of work lets several rows reuse a smaller B tile before
it is evicted, reducing traffic and improving throughput. Expect a speedup on
some larger problems. Repeated same-build timings at or below unblocked `ikj`
throughput falsify that expectation for the tested configuration and workload.

The chosen order is **ii → kk → jj → i → k → j**. Inner j remains contiguous for
B and C and reuses one A scalar. Outer ii/kk/jj lets a B tile serve several i rows
before moving along N. An alternative ii/jj/kk would instead prioritize holding
one C tile across the reduction. That alternative is not silently mixed into
this experiment; only one block-loop order is studied here.

BM, BN, and BK are independent runtime arguments. There is no packing, register
microkernel, manual unrolling, explicit SIMD, parallelism, or automatic tuning.
The fixed Python sweep is an experiment, not a runtime configuration selector.
The CLI convenience default is 64/64/64, not a claim of optimality.

## Correctness details to study

`src/gemm_blocked.cpp` zeros C once, before the block loops. Zeroing inside each
kk iteration would erase earlier partial sums. The zeroing and positive-block
validation are part of every timed call. Zero block sizes throw before touching
output, including for empty matrices; M=0 or N=0 otherwise accesses no buffers.
K=0 writes zero output without accessing A or B.

Tile ends are `start + min(block, dimension - start)`, so tails never extend
past valid memory and enormous block arguments cannot overflow the calculation.
Advancing to the clamped end also avoids overflow on the last increment.
Each output retains increasing k accumulation order across K tiles.

Tests compare against the double-accumulating reference and exercise separate
tails, exact tile boundaries, unit/oversized tiles, SIZE_MAX block values,
repeated overwrite, NaN-filled output, guards, input preservation, negative
known answers, identity, zeros, and empty dimensions.

## Cache model and its limits

This Apple M2 Pro reports the following through `sysctl`:

| Core class | L1 data | L2 | Cores sharing L2 |
| --- | ---: | ---: | ---: |
| Performance (`perflevel0`) | 128 KiB | 16 MiB | 4 |
| Efficiency (`perflevel1`) | 64 KiB | 4 MiB | 4 |

Reported cache-line size: 128 bytes. Measurements are not pinned, so the core
class used during each sample is not established. No L3 capacity was queried.

The approximate logical tile footprint for float is
`4 * (BM*BK + BK*BN + BM*BN)` bytes. Square tiles of 8, 16, 32, 64, 128, and 256
give 0.75, 3, 12, 48, 192, and 768 KiB respectively. For example, 64/256/64
uses 144 KiB, exceeding the reported performance-core L1 data capacity, while
64/128/32 uses 56 KiB.

This footprint is a rough guide, not a fit guarantee: rows are strided rather
than packed, cache lines can contain unused elements, associativity constrains
placement, and other data compete for capacity. BN also changes the contiguous
inner-loop length and compiler opportunities; smaller blocks introduce more
loop/boundary overhead. Tile size alone cannot predict the winning case.

## Reproduce

```sh
./build/release/gemm_benchmark --implementation blocked --bm 64 --bn 128 --bk 32 512
./build/release/gemm_benchmark --implementation blocked --bm 32 --bn 128 --bk 32 --shape 255 513 257
python3 scripts/benchmark_blocks.py --output results/raw/blocks-primary.csv
python3 scripts/benchmark_blocks.py --reverse --output results/raw/blocks-reverse.csv
python3 scripts/plot_blocks.py results/raw/blocks-primary.csv
```

The sweep uses square tiles 8–256 plus 32/128/32, 64/128/32, 64/256/64,
and 128/64/32. Shapes M/N/K are 256/256/256, 512/512/512, 1024/1024/1024,
and 255/513/257. Each shape also measures unblocked `ikj` in the same binary.
Each configuration runs in its own process, sequentially, with seeds 42/43,
one validated warmup and five measured calls. Medians are retained, not individual
samples. The reverse sweep reverses configuration order within each shape.

The harness is shared with earlier kernels. CSV appends BM, BN, BK (zero for
unblocked kernels); `all` retains its six-loop-order meaning. `--shape M N K`
cannot be mixed with positional square sizes. Both benchmark paths invoke the
external kernel inside timing: old kernels through a function pointer, blocked
through a captured-tile adapter. This small call-dispatch difference is not
isolated, and tiny-problem timings should not be used for performance claims.

Allocation, initialization, reference evaluation, and checksums are outside
timing; required output zeroing is inside. Buffers are reused without cache
flushes. Compiler-generated optimizations are enabled. Core affinity, clock
frequency, background load, and thermal state are uncontrolled. Timings do not
measure cache misses or prove a cache-level explanation.

## Measured results and decision

Both sweeps ran on the Apple M2 Pro with Apple Clang 14.0.3, macOS 14.8.3,
CMake Release (`-O3 -DNDEBUG -std=c++17` for kernels), native tuning OFF,
no explicit fast-math or LTO, and one calling thread.

The following is the **best blocked result within each sweep**, not a runtime
selection policy. Ratios below one are regressions. Tile notation is BM/BN/BK.

| Sweep | M/N/K | ikj GFLOP/s | Best blocked tile | Blocked GFLOP/s | Throughput ratio |
| --- | --- | ---: | --- | ---: | ---: |
| Primary | 256/256/256 | 26.50 | 64/256/64 | 33.11 | 1.249× |
| Primary | 512/512/512 | 27.00 | 32/128/32 | 30.52 | 1.131× |
| Primary | 1024/1024/1024 | 26.81 | 128/128/128 | 22.88 | 0.853× |
| Primary | 255/513/257 | 21.23 | 64/128/32 | 22.55 | 1.062× |
| Reverse | 256/256/256 | 27.56 | 64/256/64 | 33.42 | 1.213× |
| Reverse | 512/512/512 | 27.28 | 64/128/32 | 30.61 | 1.122× |
| Reverse | 1024/1024/1024 | 26.96 | 32/128/32 | 22.80 | 0.846× |
| Reverse | 255/513/257 | 21.13 | 32/128/32 | 22.43 | 1.062× |

![Primary-sweep speedup heatmap](../results/plots/blocks.png)

- At 256 cubed, 64/256/64 won both sweeps: 1.25× and 1.21× baseline throughput.
- At 512 cubed, 32/128/32 consistently measured about 30.5/30.4 GFLOP/s,
  approximately 1.13×/1.11× the corresponding `ikj` baseline. The winning tile
  changed in the reverse sweep. In particular, 64/128/32 varied from 21.52 to
  30.61 GFLOP/s; no explanation for that outlier is established.
- At 1024 cubed, every blocked configuration lost to `ikj` in both sweeps.
  Even the best had only 0.853×/0.846× baseline throughput (roughly 17–18% longer
  latency). This falsifies the expected larger-problem benefit for these tested
  tiles, this loop order, and this workload. It does not rule out other blocking
  designs or larger shapes.
- The odd rectangular case showed small gains, roughly 6% for the best tile,
  but the exact winner changed. Do not generalize from one rectangular shape.

Fitting the footprint into L1 is insufficient: 8/8/8 fits easily but loses badly,
while the winning 256-square tile has a 144 KiB logical footprint, larger than
performance-core L1 data capacity. Short inner loops, loop-boundary overhead,
compiler transformations, and cache placement are plausible contributors, not
measured explanations. At 1024, all of B occupies 4 MiB, still within the reported
16 MiB performance-core L2 capacity, so unblocked B reuse can already benefit
from that cache. Actual core placement and cache misses remain unmeasured.

**Decision:** retain the configurable blocked kernel as an educational experiment,
not as an unconditional replacement for `ikj`. The 32/128/32 tile is a reasonable
candidate for future controlled comparisons at 512, and 64/256/64 at 256; neither
is promoted to a universal default. Keep `ikj` as the reference performance
candidate at 1024. The CLI default 64/64/64 remains merely a documented starting
value. Future register blocking or block-loop-order experiments require their
own hypotheses and measurements.

**Validation:** Release and Debug CTest passed both existing and blocked suites;
the blocked suite also passed AddressSanitizer/UndefinedBehaviorSanitizer with
warning-enabled compilation. All 88 measured configurations passed warmup
reference checks. CLI rejection/selection, rectangular dimensions, block columns,
even repetition counts, CSV uniqueness/completeness, and GFLOP/s arithmetic were
checked. The heatmap was generated from the primary CSV and visually inspected.

The two sweeps are not confidence intervals. Only medians were retained, no
counter measurements or compiler-report analysis was performed, and intermediate
winners were not retuned using follow-up measurements.

Artifacts: [primary CSV](../results/raw/blocks-primary.csv),
[reverse CSV](../results/raw/blocks-reverse.csv),
[metadata, build commands, and source hashes](../results/raw/blocks-metadata.json).
Earlier milestone results and kernels are preserved.
