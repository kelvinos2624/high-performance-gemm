# GEMM from first principles

A C++17 performance-engineering project that starts with a correct, deliberately
naive matrix multiplication and advances through measured experiments. This is
**Milestone 3**: contiguous row-major `float` matrices, a scalar reference with
double accumulation, all six loop orders, configurable cache blocking,
correctness tests, and a CSV benchmark.
The original `naive_ijk` remains the unchanged Milestone 1 kernel.

All kernels compute **C = A × B** for A[M,K], B[K,N], and C[M,N]. C is overwritten.
The hot loops operate on raw pointers without allocation. Buffers must have valid
extents, index products must fit `size_t`, and C must not overlap either input.
Zero M or N performs no accesses; zero K writes zeros to C. Matrix indexing is
unchecked; construction checks dimension multiplication for overflow.

## Build and test

Requires CMake 3.20+ and a C++17 compiler. No external numerical library is needed.

```sh
cmake -S . -B build/debug -DCMAKE_BUILD_TYPE=Debug
cmake --build build/debug --parallel
ctest --test-dir build/debug --output-on-failure

cmake -S . -B build/release -DCMAKE_BUILD_TYPE=Release
cmake --build build/release --parallel
ctest --test-dir build/release --output-on-failure
```

These commands use a single-configuration generator. For multi-configuration
generators, select `--config Release` when building and `-C Release` with CTest.
Release uses the compiler's CMake optimization defaults. Optional
`-DGEMM_NATIVE_ARCH=ON` enables checked host tuning (`-mcpu=native` on ARM or
`-march=native` elsewhere); it is off by default for portability. Do not distribute
host-tuned binaries assuming they work on other CPUs. No fast-math flags are added.

Tests use explicit checks even in Release, including known answers, both identity
directions, zeros, negative values, odd/rectangular random shapes, and K=0.
Random comparisons use `abs(actual - expected) <= 1e-4 + 1e-4 * abs(expected)`
and reject non-finite results. This tolerance targets the bounded inputs tested
here, not an arbitrary numerical error guarantee.

## Benchmark

```sh
./build/release/gemm_benchmark > results/raw/loop-orders.csv
./build/release/gemm_benchmark --repetitions 7 64 128 256 512
./build/release/gemm_benchmark --implementation naive_ijk 64 128 256 512
./build/release/gemm_benchmark --implementation ikj --repetitions 7 512
./build/release/gemm_benchmark --implementation blocked --bm 64 --bn 128 --bk 32 512
./build/release/gemm_benchmark --implementation blocked --bm 32 --bn 128 --bk 32 --shape 255 513 257
```

Defaults: all six orders; square sizes 64, 128, 256, 512, 1024; one warmup;
five measured runs per implementation/size. Select one with `--implementation`
(`naive_ijk`, `ikj`, `jik`, `jki`, `kij`, `kji`), or use `all`.
Select `blocked` explicitly for cache blocking; `all` keeps its original six-order
meaning. Block dimensions are positive independent runtime parameters, defaulting
to 64 each for convenience. Block options require `--implementation blocked`.
`--shape M N K` supports one rectangular problem instead of positional sizes.
Positive sizes and repetition counts are configurable. Very small sizes are useful
for smoke checks, but timer overhead makes them unsuitable performance evidence.
Large sizes can take substantial time and memory (four N×N float matrices).

The harness allocates and initializes outside timing, validates the warmup against
the reference, and times the selected kernel using `std::chrono::steady_clock`.
Required C zeroing is inside the four accumulating kernels and included in timing.
Blocked GEMM includes its initialization too. The shared harness calls unblocked
kernels through a function pointer and blocked GEMM through a tile-argument adapter.
Implementations run
in the listed order for each size; repetitions are consecutive, not interleaved.
It reports median milliseconds (averaging the middle pair for even counts) and
`2*M*N*K / (seconds*1e9)` GFLOP/s. Each timed result contributes to the printed
double checksum outside timing. Input seeds are fixed at 42 and 43; the generator
maps mt19937 output directly to binary fractions in [-1,1).

CSV columns are `implementation,M,N,K,time_ms,gflops,repetitions,warmups,threads,seed_A,seed_B,checksum,BM,BN,BK`.
The final three columns are zero for unblocked kernels; older saved CSVs predate them.
Diagnostics go to stderr. A failed run returns nonzero and may leave a partial CSV;
do not treat that file as a complete result. Checksums sum all measured outputs, so
they scale with repetition count. They are an output-consumption guard, not a
replacement for element-wise correctness tests.

This measures repeated use of the same buffers, with no cache flush or affinity
control. Checksum reads affect cache state between runs. Compiler optimizations
(including automatic vectorization, unrolling, or FMA) remain enabled in Release;
“naive” describes the source algorithm. Record the compiler, flags, machine,
OS, and command alongside any retained CSV; `compile_commands.json` records compile
commands for supported generators. Do not compare Debug timings to Release.

## Progression

See [the project charter](docs/project_charter.md),
[experiment log](docs/optimization_log.md), and
[loop-order analysis](docs/loop_orders.md) and [cache-blocking experiment](docs/cache_blocking.md)
for access patterns, design choices, cache capacities, and measured results.
Register tiling, vectorization studies, explicit SIMD, and multicore execution come later.

Regenerate the comparison plot with Python 3 and matplotlib (plotting is optional
and is not a C++ build dependency):

```sh
python3 scripts/plot_results.py results/raw/loop-orders-2026-10-05-apple-m2-pro.csv
```

Repeat in reverse implementation order with the standard-library-only runner:

```sh
python3 scripts/run_benchmarks.py --reverse --output results/raw/loop-orders-reverse.csv
```

This runner starts a fresh process per implementation/size and executes them
sequentially. The warmup and timed region stay inside the C++ executable.

![Measured loop-order comparison](results/plots/loop-orders.png)

The fixed Milestone 3 sweep compares ten tiles against contemporaneous `ikj`
on three square sizes and one odd rectangular shape:

```sh
python3 scripts/benchmark_blocks.py --output results/raw/blocks-primary.csv
python3 scripts/benchmark_blocks.py --reverse --output results/raw/blocks-reverse.csv
python3 scripts/plot_blocks.py results/raw/blocks-primary.csv
```

The blocking experiment is retained even where it regresses; no universal winning
tile or automatic dispatch policy is inferred from these few shapes.

![Cache-blocking comparison](results/plots/blocks.png)
