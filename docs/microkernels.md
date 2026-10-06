# Milestone 4 — scalar register-blocked microkernels

## Hypothesis and visible design choices

Milestone 3 updates C inside its inner k/j loops. Holding MR×NR outputs locally
across a K block should reduce repeated C accesses and expose independent
accumulation chains. Expected effect: higher throughput than the same blocked
driver. A same-build regression, or generated stack traffic that defeats the
intended register residency, challenges that hypothesis for a particular shape.

Keep macro order ii/kk/jj and compare microtiles **2×4, 4×4, 4×8, 8×4, 8×8**.
The additional **16×16** is deliberately a pressure experiment, not an assumed
good design. The main sweep fixes BM/BN/BK at **32/128/32**, a candidate measured
in Milestone 3. Thus MR/NR changes without retuning macro dimensions. Compare
against both `blocked` at that same macro shape and contemporaneous `ikj`.

The tile bodies are scalar C++ with fixed template extents. They load partial C
once, reuse a local B row across MR rows, reuse each A scalar across NR columns,
and store C once after the K block. K advances one element per source iteration:
no manual K unrolling or explicit SIMD was added. The compiler remains free to
unroll fixed row/column loops and generate scalar or vector FMA instructions.

`src/microkernel_tiles.cpp` is a separate translation unit so the real timed tile
bodies remain inspectable with ordinary Release optimization. No forced inlining
or noinline attributes are used. Without LTO, the driver makes an indirect call
for each full microtile. That overhead, plus loads/stores at every K-block
boundary, is part of this implementation's measured cost; the experiment does
not isolate register arithmetic from dispatch cost.

The public API accepts independent macro dimensions and the supported MR/NR
choices. Unsupported microtiles and zero macro dimensions throw before touching
output. The CLI convenience defaults are macro 64/64/64 and micro 4/4; these
are not a tuned policy. `all` continues to mean the original six loop orders.

## Correctness and regions to study

- Zero C once before the macro loops. Each microkernel loads the existing partial
  sums so later K blocks preserve earlier work.
- Call a full tile only when both MR rows and NR columns fit **within the current
  macro tile**, not merely within the entire matrix.
- Partial microtiles use scalar dot-product cleanup for the current K range.
  Clamped row/column increments prevent overlap and out-of-bounds updates.
- Tests exercise all six shapes with independent macro/micro/matrix tails,
  macro tiles smaller than the microtile, unit/oversized/SIZE_MAX macro tiles,
  zero dimensions, NaN-filled and repeated output, known answers, identity,
  zeros, input preservation, and output guards.

## Actual optimized assembly

Generated with the same Apple Clang Release kernel flags (native tuning OFF):

```sh
clang++ -O3 -DNDEBUG -std=c++17 -S src/microkernel_tiles.cpp -o results/assembly/microkernel-apple-clang-arm64.s
```

The saved file is architecture/compiler-specific evidence, not portable source.

| Tile | Observed reduction behavior on this compiler |
| --- | --- |
| 2×4 | Eight scalar accumulators in registers; scalar `fmadd`; no stack frame |
| 4×4 | Sixteen scalar accumulators in registers; scalar `fmadd`; no stack frame |
| 4×8 | Scalar `fmadd`, with floating-point spills/reloads inside K |
| 8×4 | Scalar `fmadd`, with floating-point spills/reloads inside K |
| 8×8 | Many scalar accumulator spills/reloads inside K |
| 16×16 | Stack-resident accumulator array; row loop loads/updates/stores it on every K; compiler-generated vector `fmla` |

Inspect `LBB0_2` and `LBB1_2` for the small register-only bodies. The C loads and
stores sit outside those reduction loops. For 4×8, look inside `LBB2_2`: an
updated accumulator is stored at `[sp,#28]` and reloaded within the loop.
8×4 (`LBB3_2`) and 8×8 (`LBB4_2`) show the same issue at larger scale.
Do not count prologue/epilogue saves of callee-saved registers as hot-loop spills.

For 16×16, `x17` points to the stack accumulator array; `LBB5_3` forms an address
from that base, loads accumulator vectors, executes `fmla`, then stores them back
for each row and K step. This is a memory-resident array, not simply a few isolated
register-allocation spills. Its vector instructions also mean that performance
need not worsen monotonically with tile area.

No universal register limit is inferred: compiler strategy, live inputs,
address registers, instruction selection, and ABI rules all affect allocation.
This milestone inspects the actual output rather than assuming a C++ local is
held in a hardware register. Hardware counters have not been collected.

The blocked comparator was also compiled to assembly with the same flags (plus
`-Iinclude`). Its vector inner-loop path uses `fmla.4s` (saved assembly lines
290–293). Thus the 4×4 comparison is scalar FMA versus a baseline with a vector
path, not a controlled comparison of register traffic alone. The scalar source
forms do not imply identical instruction selection.

## Reproduce the timings

```sh
./build/release/gemm_benchmark --implementation microkernel --bm 32 --bn 128 --bk 32 --mr 4 --nr 4 512
./build/release/gemm_benchmark --implementation microkernel --mr 8 --nr 8 --shape 255 513 257
python3 scripts/benchmark_microkernels.py --output results/raw/microkernels-primary.csv
python3 scripts/benchmark_microkernels.py --reverse --output results/raw/microkernels-reverse.csv
python3 scripts/plot_microkernels.py results/raw/microkernels-primary.csv
```

The shared benchmark appends MR/NR to CSV (zero for older implementations).
Each configuration gets one validated warmup and five timed calls; median time
is reported. Seeds are fixed, allocation/reference/checksum work stays outside
timing, and initialization, cleanup and tile calls stay inside. The reverse
sweep reverses configuration order. Each configuration runs sequentially in a
fresh process. No affinity, thermal, frequency, or background-load controls;
only medians are retained, not individual timings or confidence intervals.

## Results and decision

Apple M2 Pro, Apple Clang 14.0.3, macOS 14.8.3; same Release flags as the
assembly above, native tuning OFF. All 64 configurations across two sweeps
passed the reference guard. The table lists primary / reverse GFLOP/s.

| Implementation | 256³ | 512³ | 1024³ | M/N/K=255/513/257 |
| --- | ---: | ---: | ---: | ---: |
| ikj | 27.48 / 27.22 | 26.85 / 27.31 | 27.97 / 27.65 | 21.22 / 21.32 |
| blocked | 31.64 / 31.62 | 30.41 / 30.35 | 22.69 / 22.75 | 22.55 / 21.91 |
| 2×4 | 17.16 / 16.88 | 17.08 / 16.99 | 15.00 / 14.90 | 16.87 / 16.98 |
| 4×4 | 24.68 / 24.12 | 24.46 / 24.02 | 20.03 / 19.84 | 22.93 / 23.23 |
| 4×8 | 10.99 / 11.02 | 10.95 / 10.87 | 10.75 / 10.77 | 10.58 / 10.49 |
| 8×4 | 10.37 / 10.14 | 10.18 / 10.11 | 10.08 / 10.02 | 9.81 / 9.87 |
| 8×8 | 14.33 / 14.06 | 14.40 / 14.22 | 13.65 / 13.68 | 13.38 / 13.34 |
| 16×16 | 27.86 / 28.20 | 28.32 / 28.18 | 27.74 / 28.20 | 21.48 / 21.31 |

![Microkernel throughput relative to blocked](../results/plots/microkernels.png)

The 4×4 tile successfully stays in registers, but loses to the blocked baseline
on all three square shapes in both sweeps. At 512 its 24.46/24.02 GFLOP/s compares
with 30.41/30.35 for blocked. That rejects the expected throughput gain for this
implementation on these shapes despite successful register allocation.

The 4×8 and 8×4 variants spill inside K and fall to around 10–11 GFLOP/s at 512.
This is consistent with pressure hurting throughput, but tile shape also changes
instruction scheduling, call count, and operand reuse; timings do not isolate
spill cost. 8×8 is faster than those despite more spills, reinforcing that a
single metric cannot explain all performance.

The 16×16 case benefits from a different compiler strategy: vector arithmetic
on a stack-resident array. It beats blocked at 1024 by about 22–24%, but is near
`ikj` there (slightly below in the primary run, slightly above in the repeat).
It is not evidence of a successful 256-accumulator register tile. At 256/512 it
still loses to blocked. The 4×4 variant shows small gains over blocked on the
odd rectangular case (~2–6%), insufficient for a general dispatch policy.

**Decision:** preserve all variants as experiments and use 4×4 as the simple,
verified register-resident candidate for later controlled work. Do not replace
blocked or `ikj` globally. No runtime autotuning, manual K unrolling, explicit
intrinsics, packing, or threading has been introduced. Future experiments can
separately test call amortization or unrolling; this milestone does not attribute
all regressions to a single cause or retune macro dimensions to chase a win.

**Validation:** Debug and Release CTest passed all three suites. The microkernel
suite passed AddressSanitizer/UndefinedBehaviorSanitizer with warning-enabled
compilation for all six shapes. CLI invalid-option rejection and shape reporting,
even repetition counts, both 32-row CSV sweeps, uniqueness and GFLOP/s arithmetic
were checked. The heatmap was generated from the primary CSV and visually checked.
Assembly findings refer to the exact compiler and flags recorded here; other
compilers/architectures can allocate and vectorize differently.

Artifacts: [primary CSV](../results/raw/microkernels-primary.csv),
[reverse CSV](../results/raw/microkernels-reverse.csv),
[metadata and source hashes](../results/raw/microkernels-metadata.json),
[tile assembly](../results/assembly/microkernel-apple-clang-arm64.s),
[blocked comparator assembly](../results/assembly/blocked-apple-clang-arm64.s).
