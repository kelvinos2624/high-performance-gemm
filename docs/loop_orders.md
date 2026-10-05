# Milestone 2: six loop orders

## Experiment and choices

**Hypothesis:** the naive inner k loop's strided B reads limit throughput.
Moving j innermost gives sequential B/C access and independent output updates,
which may improve locality and make compiler vectorization easier. Expect higher
GFLOP/s for `ikj`/`kij`, especially at larger sizes. Equal or lower throughput in
repeated same-build comparisons would falsify that expected benefit for this host
and workload; timing alone cannot establish the underlying hardware cause.

The actual change is the five explicit loop nests in `src/gemm_loop_order.cpp`.
No blocking, intrinsics, manual unrolling, packing, or multithreading is introduced.
The existing `naive_ijk` is the sixth permutation and is preserved unchanged.

Design choices are intentionally visible:

- `ijk` and `jik` use a local float sum and write each output once, since k is
  innermost. This retains the original baseline's useful accumulator structure.
- The other four orders first zero C, then use `+=`. Zeroing is required for
  `C=AB`, handles K=0, and is included in timed calls. Omitting it would silently
  change the operation to `C+=AB` or depend on old output contents.
- Inner-j loops reuse an explicit `a = A[i*K+k]`; inner-i loops reuse
  `b = B[k*N+j]`. Each scalar is invariant across that inner loop. Thus this is a
  comparison of idiomatic implementations of each order, including their necessary
  accumulator structure, not a mechanical interchange of identical statements.
- All implementations still accumulate each output in increasing k order.
  Compiler transformations and rounding mean tolerance comparisons remain needed.
- A small shared function-pointer registry selects kernels for testing and
  benchmarking. It adds no dispatch inside the multiplication loops.

## Read the memory accesses

Strides below are in float elements (multiply by four for bytes on this host).

| Order | Inner loop | A access | B access | C access and reuse |
| --- | --- | --- | --- | --- |
| `ijk` | k | stride 1 | stride N | local sum, store once; outputs visited by row |
| `ikj` | j | fixed scalar | stride 1 | stride 1; one C row revisited across k |
| `jik` | k | stride 1 | stride N | local sum, store once; outputs visited by column |
| `jki` | i | stride K | fixed scalar | stride N; one C column revisited across k |
| `kij` | j | fixed scalar | stride 1 | stride 1; all of C revisited for each k |
| `kji` | i | stride K | fixed scalar | stride N; all of C revisited for each k |

Unit stride allows adjacent elements fetched in a cache line to be used together.
Large strides can waste that spatial locality. Outer-loop order also changes when
data is revisited, so equal inner loops need not give equal performance.
The local sum in `ijk`/`jik` has a dependent chain of additions; the other orders
expose independent C elements in their inner loops. These are source-level
observations, not measured cache-miss or instruction-throughput evidence.

## Measurement boundaries

Use one Release binary with identical flags and deterministic input seeds across
implementations. Allocate and calculate the double-accumulating reference before
each implementation/size measurement. Validate the warmup, then report the median
of five timed calls. Every timed call includes the complete `C=AB` operation and
uses the same function-pointer dispatch. Consume each output outside timing.

The comparison includes compiler-generated optimizations. There is no claim that
these are scalar machine-code kernels or that changes in cache behavior alone
explain speedups. No vectorization report, assembly inspection, or hardware-counter
analysis has been performed in this milestone.

Buffers are reused without cache flushing; execution is single-threaded with no
affinity, frequency, thermal, or background-load controls. Implementations execute
consecutively in a fixed order within the primary sweep. Conclusions apply to the
measured square shapes, host, and compiler; rectangular shapes are correctness
tested but not performance characterized here.

## Primary sweep results

Apple M2 Pro (arm64, 12 cores, 16 GiB), macOS 14.8.3 (23J220); Apple Clang
14.0.3, CMake 4.4.4, Release `-O3 -DNDEBUG -std=c++17`, native tuning OFF.
No explicit fast-math or LTO. One calling thread. All 30 implementation/size
combinations passed the reference guard.

Command:

```sh
./build/release/gemm_benchmark --repetitions 5 64 128 256 512 1024 > results/raw/loop-orders-2026-10-05-apple-m2-pro.csv
```

GFLOP/s from median latency (higher is better):

| Order | 64 | 128 | 256 | 512 | 1024 |
| --- | ---: | ---: | ---: | ---: | ---: |
| naive_ijk | 3.531 | 2.719 | 2.207 | 1.930 | 1.777 |
| ikj | 24.012 | 31.011 | 26.797 | 27.868 | 27.858 |
| jik | 3.514 | 2.731 | 2.167 | 1.940 | 1.741 |
| jki | 3.086 | 3.255 | 0.567 | 0.509 | 0.419 |
| kij | 28.086 | 33.244 | 21.154 | 22.360 | 21.770 |
| kji | 5.109 | 4.736 | 0.595 | 0.507 | 0.413 |

![Primary sweep](../results/plots/loop-orders.png)

[Primary CSV](../results/raw/loop-orders-2026-10-05-apple-m2-pro.csv) preserves
median times, throughput, repetition counts, seeds, and checksums.
The earlier Milestone 1 CSV is unchanged; speedups here use the newly measured
`naive_ijk` in this sweep, not timings from the previous session.

At 1024, `ikj` takes 77.088 ms versus 1208.167 ms for
`naive_ijk`, a 15.67× speedup. `kij` leads at 64 and 128, while `ikj` leads at
256–1024 in this sweep. Inner-i orders (`jki`, `kji`) fall sharply between 128
and 256. Their strided accesses are consistent with poor locality, but we have
not measured cache behavior and cannot attribute that discontinuity to a
specific cache level or miss mechanism.

## Reverse-order repeat and decision

A second sweep ran `kji, kij, jki, jik, ikj, naive_ijk` for each size, using five
measured repetitions and a validated warmup in a new process per combination:

```sh
python3 scripts/run_benchmarks.py --reverse --output results/raw/loop-orders-reverse-2026-10-05-apple-m2-pro.csv
```

[Reverse CSV](../results/raw/loop-orders-reverse-2026-10-05-apple-m2-pro.csv).
Both sweeps retain the same winners: `kij` at 64/128, `ikj` at 256/512/1024.
At 1024, the repeat measured:

| Order | Median ms | GFLOP/s |
| --- | ---: | ---: |
| naive_ijk | 1216.149 | 1.766 |
| ikj | 77.818 | 27.596 |
| jik | 1236.891 | 1.736 |
| jki | 5228.292 | 0.411 |
| kij | 116.837 | 18.380 |
| kji | 5226.974 | 0.411 |

The repeated 1024 `ikj` speedup is 15.63× (primary: 15.67×). The 1024 `kij`
throughput changed from 21.77 to 18.38 GFLOP/s, so these observations should not
be treated as precise universal performance constants. Reversed order reduces
one potential source of bias but does not control thermal state, allocation,
frequency, or background load. Only per-configuration medians are retained;
two sweeps are not a confidence interval.

**Decision:** keep all six kernels. Use `ikj` as the measured starting candidate
for the next cache-blocking experiment at larger square sizes, while retaining
`kij` as a small-size comparator. Do not add size-based dispatch on the strength
of this limited sweep. No blocking is implemented in this milestone.

**Validation:** all six orders passed known-answer, identity, zero, negative,
odd/rectangular random, input-preservation, repeated-overwrite, guarded-output,
and zero-dimension checks in Debug and Release. AddressSanitizer and
UndefinedBehaviorSanitizer passed the suite. Both sweeps passed their 30 reference
checks. CLI selection/rejection, even repetition counts, CSV completeness, and
GFLOP/s arithmetic were checked. The plot was generated from the primary CSV
and visually inspected.

[Build metadata and source hashes](../results/raw/loop-orders-2026-10-05-metadata.json)
record the environment and compile commands used for these measurements.
