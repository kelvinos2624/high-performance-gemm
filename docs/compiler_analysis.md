# Milestone 6 — compiler optimization and auto-vectorization

## Question and controlled choices

How much of the current GEMM throughput comes from compiler optimization, and
which loops actually execute vector instructions? The hypothesis is that the
contiguous inner-j loops in `ikj` and blocked GEMM benefit strongly from
auto-vectorization, while the dependent naive dot product and scalar 4×4 tile
show smaller sensitivity. If disabling vectorizers preserves their throughput,
that would challenge the expected vectorization benefit for these workloads.
Native CPU tuning is a separate hypothesis, not an assumed improvement.

No numerical kernel source was changed. No intrinsics, `restrict`, fast-math,
new packing scheme, or parallelism is added. The milestone establishes what the
compiler already does before choosing any explicit-SIMD follow-up. Such a
follow-up remains optional and would need its own design and measurements.

## Builds and reproducibility

All configurations use the same Apple Clang compiler and C++17 source. They are
separate CMake **Release** build trees with explicit optimization flags; O0 here
is a controlled Release configuration with optimization disabled, not a Debug
versus Release-library comparison. `-DNDEBUG` is constant across the builds.

| Label | Flags | Purpose |
| --- | --- | --- |
| O0 | `-O0 -DNDEBUG` | Unoptimized reference point |
| O2 | `-O2 -DNDEBUG` | Optimizing compiler baseline |
| O3 | `-O3 -DNDEBUG` | Current optimization level |
| O3-native | O3 plus kernel-library `-mcpu=native` on this ARM host | Native tuning experiment |
| O3-no-vector | O3 plus `-fno-vectorize -fno-slp-vectorize` | Disable both Clang vectorizers |

Native architecture selection still uses the project's checked CMake option;
it uses `-march=native` on applicable non-ARM targets. Whole-build optimization
flags also apply to the harness and reference, whose work is outside the kernel
timed region. Native tuning applies to the kernel library. No LTO is enabled.
The no-vector control does not prohibit every possible SIMD instruction in the
program or external libraries; it disables the two named compiler passes.

`GEMM_VECTORIZATION_REPORTS=ON` adds Clang loop/SLP/unroll remarks (or GCC vector
reports) only to the library. It defaults OFF and does not change optimization
levels. GCC support in that option is not tested here; the fixed experiment
script intentionally requires Clang for its no-vector flags.

```sh
python3 scripts/compiler_experiment.py prepare --cmake cmake --compiler /usr/bin/clang++
python3 scripts/compiler_experiment.py benchmark --output results/raw/compiler-primary.csv
python3 scripts/compiler_experiment.py benchmark --reverse --output results/raw/compiler-reverse.csv
python3 scripts/summarize_compiler_assembly.py
python3 scripts/plot_compiler.py results/raw/compiler-primary.csv
```

Preparation builds and runs all correctness suites for each variant, saves
diagnostics and actual compile commands, then generates assembly by reusing those
commands and replacing object emission with `-S`. No build runs during timing.
Source hashes reject edits after preparation. Re-run preparation if sources or
compiler settings change; do not replace prepared binaries between sweeps.

The sweep covers `naive_ijk`, `ikj`, blocked, and 4×4 microkernel (unroll 1).
Macro dimensions are fixed at 32/128/32. Matrix M/N/K shapes are 128³, 256³,
512³, and 127/193/129, chosen to keep the O0 sweep practical and include odd tails.
Each configuration gets a fresh process, fixed seeds, a reference-validated
warmup, and five measured calls. Median kernel latency includes required output
zeroing and dispatch. Inputs, reference, and checksums remain outside timing.
The repeat reverses build/kernel order within each shape.

No core affinity, frequency, thermal or background-load controls are applied.
Medians only are retained, not individual timings or confidence intervals.
Do not extrapolate from these sizes to larger matrices or other compilers/CPUs.

## Read the reports together with the assembly

### A vectorization remark does not identify the path your matrix executes

The O3 report marks `naive_ijk`'s K loop as vectorized with width 4 and interleave
count 4. However, the generated function guards that path with **N == 1** and a
large-enough K. That special case makes both inputs contiguous. It executes
vector `fmul.4s` followed by ordered scalar additions, not a vector FMA reduction.
For the N>1 shapes in this sweep, the function instead takes a scalar `fmadd`
loop with strided B access. Presence of vector instructions in a function is
not proof they run for every shape.

### Contiguous j loops already use SIMD

The O3 `ikj` and blocked reports identify width-4, interleave-4 inner-j loops.
Their fast paths load vectors, execute four `fmla.4s` instructions per group,
and write sixteen float outputs before the loop backedge. Scalar cleanup handles
the remainder. This is compiler-generated SIMD and automatic interleaving in
existing scalar C++ source; explicit intrinsics are not necessary to obtain it.

In `ikj`, comparisons of the current C-row and B-row address ranges guard the
vector fast path, with an overlapping-range fallback to scalar code. The public
contract forbids C/input overlap, but that fact is not expressed as a compiler
non-aliasing declaration. Thus alias uncertainty leads to runtime versioning,
not a complete failure to vectorize. No `restrict` speedup is claimed or tested.
Adding one would be a separate contract-preserving experiment.

### Register-local source does not ensure vector arithmetic

For 4×4, the row/column loops are completely unrolled and the K loop retains
sixteen scalar accumulators and scalar `fmadd`, with no hot-loop spills in the
optimized builds. The source has no SIMD instructions. Reports for the same
template source also discuss other tile instantiations; do not attribute every
remark in that file to the selected 4×4 shape. Milestone 4 documented spills in
the larger tiles; the current performance comparison holds shape fixed.

The O0 4×4 wrapper calls a separately emitted unoptimized template body with
stack-resident locals and loops. Its wrapper's zero FMA count does not mean no
arithmetic executes. Even some O0 loops emit scalar `fmadd`: FMA presence alone
is not evidence of high optimization or vectorization.

### Native tuning and the vectorization-disabled control

For all four selected functions, the normalized O3 and O3-native instruction
texts are identical on this host. This comparison excludes comments/directives
and is not a claim that entire executables or all functions are identical.
The O2 and O3 4×4 bodies are also identical, while other selected functions have
different control-flow structure. The no-vector build removes vector FMA paths
from `ikj` and blocked, retaining scalar FMA. It also removes naive's specialized
vector multiply path; the measured general-N path was already scalar.

Reports, assembly, exact build commands and test logs are under
[`results/compiler`](../results/compiler). The [assembly inventory](../results/compiler/assembly-summary.json)
counts static instruction sites across all paths, not executed instructions.
No hardware counter measurements were taken. These findings apply to the
recorded compiler, target, and flags rather than promising behavior elsewhere.

## Measured results and decision

Apple M2 Pro, Apple Clang 14.0.3, macOS 14.8.3. At 512³, the primary / reverse
throughput in GFLOP/s was:

| Build | naive ijk | ikj | blocked | microkernel 4×4 |
| --- | ---: | ---: | ---: | ---: |
| O0 | 0.55 / 0.56 | 1.33 / 1.33 | 1.32 / 1.30 | 0.99 / 0.99 |
| O2 | 1.87 / 1.88 | 27.60 / 27.75 | 30.60 / 30.73 | 24.15 / 24.32 |
| O3 | 1.87 / 1.88 | 27.21 / 27.50 | 30.58 / 30.99 | 24.17 / 24.44 |
| O3-native | 1.87 / 1.88 | 27.63 / 27.50 | 30.79 / 30.85 | 24.56 / 24.29 |
| O3-no-vector | 1.88 / 1.89 | 6.28 / 6.23 | 5.49 / 5.48 | 24.30 / 24.79 |

![Compiler comparison at 512 cubed](../results/plots/compiler.png)

Disabling both vectorizers reduces `ikj` throughput by about 4.3–4.4× and blocked
throughput by about 5.6× at 512 in the two sweeps. Their observed vector paths
and this controlled intervention support a substantial compiler-vectorization
benefit for these kernels. This is not a measurement of isolated SIMD instruction
latency: disabling passes also changes scheduling, branching, and code layout.

The 4×4 tile is near 24 GFLOP/s in O2/O3/native/no-vector variants, consistent
with its already scalar-FMA register body. `naive_ijk` is near 1.88 GFLOP/s in
those same builds: its special N=1 vector path is irrelevant to these shapes.
An extra diagnostic invocation with `--shape 64 1 257` passed the O3 reference
guard for that specialized case; its short timing is not performance evidence.

O0 is much slower, but that gap includes many transformations beyond
vectorization: loop simplification, invariant handling, register allocation,
inlining, and stack traffic can change. The experiment does not assign a fraction
of the O0 gap to any single transformation. No portable native-tuning win or
consistent O3-over-O2 advantage is established by the small differences here.
The matching O3/native instruction bodies provide additional reason not to
interpret their small timing differences as proof of better native code.

**Decision:** retain the existing default build policy and all source kernels.
Compiler reports stay opt-in; no global fast-math, restrict declaration, or
native-tuning requirement is introduced. Contiguous loops already receive SIMD.
A future explicit-SIMD microkernel could target the still-scalar 4×4 body, but
its layout, tails, portability, and benefit require a separate experiment.

**Validation:** all three correctness suites passed under all five builds
(including no-vector and native tuning). All 160 sweep configurations and the
additional N=1 diagnostic passed their element-wise reference guards. CSV shape/
build/kernel coverage, uniqueness, finite checksums, and GFLOP/s arithmetic were
verified. Assembly inventory was generated and selected paths manually inspected;
the plot was rendered and visually reviewed. No new sanitizer run was needed
because this milestone changes build tooling, not numerical kernel source.

The paired sweeps are not confidence intervals. Source hashes, exact build
commands, remarks, test logs, and assembly are saved; current binaries must still
be rebuilt on a different host. The fixed runner is Clang-specific and the
assembly-inventory helper is specific to the recorded ARM64 symbol syntax.

Artifacts: [primary CSV](../results/raw/compiler-primary.csv),
[reverse CSV](../results/raw/compiler-reverse.csv),
[N=1 diagnostic](../results/raw/compiler-n1-check.csv),
[preparation metadata](../results/compiler/metadata.json),
[run environment](../results/compiler/environment.json).
