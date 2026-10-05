# Project Context: High-Performance GEMM From First Principles

## 1. Project Overview

I want to build a serious systems/performance-engineering project around GEMM: General Matrix–Matrix Multiplication.

The project should start with an intentionally straightforward CPU implementation of matrix multiplication and progressively transform it into a high-performance implementation through measurement-driven optimization.

The fundamental operation is:

\[
C = \alpha AB + \beta C
\]

where:

- \(A\) is an \(M \times K\) matrix
- \(B\) is a \(K \times N\) matrix
- \(C\) is an \(M \times N\) matrix
- \(\alpha\) and \(\beta\) are scalar coefficients

For the first versions, it is acceptable to simplify this to:

\[
C = AB
\]

or:

\[
C += AB
\]

until the performance architecture is established.

Each element is:

\[
C_{ij} = \sum_{k=0}^{K-1} A_{ik}B_{kj}
\]

The standard operation count for GEMM is approximately:

\[
2MNK
\]

floating-point operations.

For square matrices:

\[
2N^3
\]

FLOPs.

The purpose of this project is NOT merely to implement matrix multiplication.

The project should demonstrate:

- low-level C++ performance engineering
- CPU architecture awareness
- cache locality
- memory hierarchy behavior
- SIMD/vectorization
- register utilization
- instruction-level parallelism
- loop transformations
- multithreading
- hardware profiling
- benchmarking methodology
- compiler behavior
- performance modeling
- potentially GPU programming later
- potentially autotuning/kernel generation later

The core narrative should be:

> Start with a correct but naive GEMM implementation and progressively approach high-performance library behavior through hardware-aware optimization.

Each optimization should be justified using measurements.

---

# 2. Personal / Career Context

This project is being built primarily as a systems/HPC portfolio project.

My strongest low-level language is C++, and I want the project to help develop knowledge relevant to:

- HPC software engineering
- GPU software engineering
- accelerator software
- performance engineering
- compiler/runtime engineering
- systems software

My existing project background already covers operating systems and embedded systems reasonably well, including:

- a RISC-V bare-metal kernel
- scheduling
- interrupts
- synchronization
- timed blocking
- virtual memory
- user/kernel isolation
- device interaction
- an ARM RTOS
- FPGA accelerator work

Therefore this project should emphasize a somewhat different part of systems work:

- CPU microarchitecture
- caches
- vectorization
- memory hierarchy
- numerical kernels
- multicore scaling
- hardware performance measurement

The goal is for this project to complement the OS/kernel work rather than duplicate it.

A future resume story should eventually look approximately like:

> Built and optimized a C++ GEMM engine using cache blocking, register tiling, SIMD/FMA, loop unrolling, and multicore execution; benchmarked hardware behavior and achieved X GFLOP/s / Y% of optimized BLAS performance.

The exact claim must be determined from real measurements and must never be fabricated.

---

# 3. Project Philosophy

This project should follow several important principles.

## 3.1 Measurement before optimization

Do not blindly apply every known GEMM optimization immediately.

The intended process is:

1. establish a baseline
2. benchmark it
3. identify a bottleneck
4. apply one optimization
5. benchmark again
6. explain the performance change
7. retain the optimization only if justified

The repository should preserve enough benchmark history to show the progression.

---

## 3.2 Correctness first

Every optimized implementation must be tested against a trusted reference implementation.

A fast incorrect GEMM is useless.

Optimizations must therefore remain separable enough that individual implementations can be tested.

---

## 3.3 Educational transparency

Do not hide the important logic behind large abstractions.

This is a performance-engineering learning project.

It should be possible to inspect:

- loop structure
- memory accesses
- block sizes
- register tiles
- SIMD operations
- scheduling decisions

Avoid premature framework complexity.

---

## 3.4 Do not overengineer V1

The initial goal is a high-performance CPU GEMM.

GPU code, JIT compilation, autotuning, ML-based tuning, distributed GEMM, etc. are optional later extensions.

A completed CPU GEMM project is much better than an unfinished giant framework.

---

# 4. Primary Technical Goal

Build a CPU GEMM implementation that progresses through approximately these stages:

```text
Reference implementation
        |
        v
Naive triple-loop GEMM
        |
        v
Loop-order experimentation
        |
        v
Cache-aware blocking / tiling
        |
        v
Register blocking / microkernel
        |
        v
Loop unrolling
        |
        v
Compiler vectorization analysis
        |
        v
Explicit SIMD / FMA
        |
        v
Multicore GEMM
        |
        v
Hardware profiling
        |
        v
Comparison against optimized BLAS
```

Possible future extension:

```text
                 CPU GEMM
                    |
             +------+------+
             |             |
             v             v
         Autotuner       GPU GEMM
             |             |
             +------+------+
                    |
                    v
          hardware-aware GEMM runtime
```

---

# 5. Initial Supported Data Type

Start with:

```cpp
float
```

Reasons:

- simple
- common GEMM workload
- SIMD-friendly
- easy comparison against SGEMM implementations

Do not initially attempt to support every numeric type.

Potential later support:

- `double`
- FP16
- BF16

But these are out of scope for early versions.

---

# 6. Matrix Representation

Prefer contiguous row-major storage.

Possible representation:

```cpp
std::vector<float>
```

with indexing:

```cpp
matrix[row * cols + col]
```

For performance-critical kernels, expose raw pointers:

```cpp
const float* A;
const float* B;
float* C;
```

Avoid:

```cpp
std::vector<std::vector<float>>
```

because rows may not be contiguous and pointer chasing obscures memory behavior.

A small matrix wrapper is acceptable if it remains zero-cost for performance code.

For example:

```cpp
class Matrix {
public:
    Matrix(size_t rows, size_t cols);

    float* data();
    const float* data() const;

    float& operator()(size_t row, size_t col);
    const float& operator()(size_t row, size_t col) const;

    size_t rows() const;
    size_t cols() const;

private:
    size_t rows_;
    size_t cols_;
    std::vector<float> data_;
};
```

But the hot GEMM path should work on raw contiguous memory.

---

# 7. Initial GEMM Interface

A simple first interface might be:

```cpp
void gemm_naive(
    const float* A,
    const float* B,
    float* C,
    size_t M,
    size_t N,
    size_t K
);
```

Assume:

```text
A: M x K
B: K x N
C: M x N
```

row-major.

Initially:

```text
C = A * B
```

Later introduce:

```cpp
void gemm(
    const float* A,
    const float* B,
    float* C,
    size_t M,
    size_t N,
    size_t K,
    float alpha,
    float beta
);
```

for BLAS-like semantics:

```text
C = alpha * A * B + beta * C
```

Do not complicate the first implementation with transposed operands unless needed later.

---

# 8. Phase 0 — Repository / Build Infrastructure

Set up a clean C++ project.

Preferred language level:

```text
C++17 or C++20
```

There is no requirement to use C++23.

Use:

```text
CMake
```

Build configurations should support at least:

```text
Debug
Release
```

Release benchmarks should use appropriate optimization flags.

Possible GCC/Clang options:

```text
-O3
-march=native
```

Do not hardcode architecture-specific options in a way that breaks portability.

Create a CMake option if necessary.

Example:

```text
GEMM_NATIVE_ARCH=ON
```

---

# 9. Suggested Repository Layout

Something approximately like:

```text
gemm/
├── CMakeLists.txt
├── README.md
├── LICENSE
│
├── include/
│   └── gemm/
│       ├── gemm.hpp
│       ├── matrix.hpp
│       └── benchmark.hpp
│
├── src/
│   ├── gemm_naive.cpp
│   ├── gemm_loop_order.cpp
│   ├── gemm_blocked.cpp
│   ├── gemm_microkernel.cpp
│   ├── gemm_simd.cpp
│   ├── gemm_parallel.cpp
│   └── matrix.cpp
│
├── tests/
│   ├── test_gemm.cpp
│   └── test_matrix.cpp
│
├── benchmarks/
│   ├── benchmark_main.cpp
│   ├── benchmark_sizes.cpp
│   └── benchmark_results/
│
├── scripts/
│   ├── run_benchmarks.py
│   ├── plot_results.py
│   └── analyze_results.py
│
├── docs/
│   ├── architecture.md
│   ├── optimization_log.md
│   ├── methodology.md
│   └── results.md
│
└── results/
    ├── raw/
    └── plots/
```

This structure is only a starting point.

Do not create empty files solely to match the layout if they are unnecessary yet.

Grow the repository incrementally.

---

# 10. Phase 1 — Correct Naive GEMM

Start with the canonical implementation:

```cpp
for (size_t i = 0; i < M; ++i) {
    for (size_t j = 0; j < N; ++j) {
        float sum = 0.0f;

        for (size_t k = 0; k < K; ++k) {
            sum += A[i * K + k] * B[k * N + j];
        }

        C[i * N + j] = sum;
    }
}
```

This implementation should be intentionally straightforward.

Do not optimize it heavily.

It serves as:

- correctness baseline
- performance baseline
- comparison target

---

# 11. Correctness Testing

Test multiple matrix shapes.

Examples:

```text
1 x 1
2 x 2
3 x 3

1 x N
M x 1

2 x 3 multiplied by 3 x 4

odd dimensions
non-square dimensions

small random matrices
larger random matrices
```

Also test:

- zero matrices
- identity matrices
- negative values
- deterministic known-answer matrices

Floating-point comparisons should use appropriate tolerances.

For example:

```cpp
abs(expected - actual) <= atol + rtol * abs(expected)
```

Do not require exact floating-point equality for optimized kernels because operation ordering may differ.

---

# 12. Reference Implementation

Initially, a simple obviously-correct scalar implementation can serve as the reference.

Eventually compare results against an external BLAS library if conveniently available.

Possible comparison targets include implementations such as:

- OpenBLAS
- BLIS
- Accelerate on macOS
- Intel oneMKL where available

Do not make the build depend on one proprietary library.

External BLAS comparison should ideally be optional.

---

# 13. Benchmarking Infrastructure

Benchmarking is a first-class part of this project.

The benchmark system should capture:

```text
implementation
M
N
K
elapsed time
GFLOP/s
number of repetitions
possibly min / median / mean
compiler
compiler flags
CPU architecture
thread count
```

GFLOP/s:

\[
GFLOP/s =
\frac{2MNK}{t \times 10^9}
\]

where `t` is execution time in seconds.

Example helper:

```cpp
double gflops(
    size_t M,
    size_t N,
    size_t K,
    double seconds
) {
    const double operations =
        2.0 *
        static_cast<double>(M) *
        static_cast<double>(N) *
        static_cast<double>(K);

    return operations / seconds / 1e9;
}
```

---

# 14. Benchmark Methodology

Do not measure only one execution.

For each configuration:

1. warm up the implementation
2. execute several measured runs
3. report median timing or another defensible statistic

Median is preferable to a single measurement.

Avoid benchmarking extremely small kernels where timer resolution dominates.

Test across matrix sizes.

Example square sizes:

```text
32
64
128
256
512
1024
2048
4096
```

Use sizes appropriate for available memory and runtime.

Also eventually test rectangular shapes because real GEMM is not always square.

Potential examples:

```text
M=1024 K=1024 N=256
M=4096 K=256  N=256
M=128  K=4096 N=4096
```

---

# 15. Phase 2 — Loop Ordering Experiment

Implement all six valid permutations:

```text
ijk
ikj
jik
jki
kij
kji
```

Do NOT assume which is fastest without benchmarking.

For row-major matrices, analyze why some orders behave better.

For example, `ijk`:

```cpp
for (i)
    for (j)
        for (k)
            C[i][j] += A[i][k] * B[k][j];
```

accesses:

```text
A[i][k]
```

contiguously but accesses:

```text
B[k][j]
```

down a column.

Because B is row-major:

```text
B[0][j]
B[1][j]
B[2][j]
...
```

has a stride approximately equal to `N`.

This is poor spatial locality.

Contrast with:

```cpp
for (i)
    for (k)
        for (j)
            C[i][j] += A[i][k] * B[k][j];
```

The inner `j` loop accesses:

```text
B[k][j]
C[i][j]
```

contiguously.

Also:

```cpp
A[i][k]
```

is reused throughout the inner loop.

This should be measured rather than just stated theoretically.

Produce results showing:

```text
loop order vs matrix size vs GFLOP/s
```

---

# 16. Phase 3 — Cache Blocking / Tiling

Once loop ordering is understood, implement blocked GEMM.

Conceptually:

```cpp
for (size_t ii = 0; ii < M; ii += BM) {
    for (size_t kk = 0; kk < K; kk += BK) {
        for (size_t jj = 0; jj < N; jj += BN) {

            // compute one C block
        }
    }
}
```

Inside each block:

```text
A block: BM x BK
B block: BK x BN
C block: BM x BN
```

Experiment with block sizes such as:

```text
8
16
32
64
128
256
```

but do not assume square block dimensions must be optimal.

Eventually support:

```text
BM
BN
BK
```

independently.

The purpose is to reuse data while it remains in cache.

---

# 17. Cache Reasoning

The blocked implementation should eventually reason about working-set size.

For float matrices:

```text
sizeof(float) = 4 bytes
```

Approximate tile storage:

\[
4(B_M B_K + B_K B_N + B_M B_N)
\]

bytes.

This can be compared to:

- L1 cache
- L2 cache
- L3 cache

The project should document actual cache characteristics of the test machine when possible.

The optimization process should explore:

> How do block sizes interact with the physical cache hierarchy?

Do not assume all cache is usable for the kernel.

Set associativity, competing data, cache replacement, and other execution effects mean the theoretical cache capacity is only a rough guide.

---

# 18. Phase 4 — Microkernel / Register Blocking

After cache blocking, build a small inner microkernel.

Instead of calculating one C element at a time, calculate a small `MR x NR` tile.

Example:

```text
4 x 4
```

Conceptually maintain:

```text
c00 c01 c02 c03
c10 c11 c12 c13
c20 c21 c22 c23
c30 c31 c32 c33
```

as local accumulators.

The goal is for the compiler or explicit SIMD implementation to keep these values in registers.

Experiment with microkernel shapes:

```text
2 x 4
4 x 4
4 x 8
8 x 4
8 x 8
```

depending on architecture.

Do not assume a bigger microkernel is always faster.

There is a tradeoff:

```text
larger microkernel
        |
        +--> more reuse
        +--> more independent work
        +--> more instruction-level parallelism
        |
        +--> higher register pressure
                 |
                 +--> possible register spilling
```

The project should experimentally observe this tradeoff.

---

# 19. Phase 5 — Loop Unrolling

Apply controlled loop unrolling to the hot inner K loop.

Example conceptual transformation:

Before:

```cpp
for (size_t k = 0; k < K; ++k) {
    c0 += a[k] * b0[k];
}
```

After unrolling by four:

```cpp
c0 += a[k + 0] * b0[k + 0];
c0 += a[k + 1] * b0[k + 1];
c0 += a[k + 2] * b0[k + 2];
c0 += a[k + 3] * b0[k + 3];
```

Or with multiple independent accumulators.

Potential benefits:

- reduced branch overhead
- reduced loop-control overhead
- more instruction-level parallelism
- better scheduling opportunities
- easier vectorization in some cases

Potential costs:

- code size
- register pressure
- instruction-cache effects
- diminishing returns

Benchmark unroll factors such as:

```text
1
2
4
8
```

Do not assume manual unrolling always beats compiler-generated unrolling.

Inspect generated assembly.

---

# 20. Phase 6 — Compiler Optimization Analysis

Compare builds such as:

```text
-O0
-O2
-O3
-O3 -march=native
```

when supported.

Inspect assembly generated for performance-critical kernels.

Questions to investigate:

- Did the compiler vectorize the loop?
- Are scalar instructions being used?
- Are SIMD instructions being used?
- Are FMA instructions generated?
- Are accumulators kept in registers?
- Is stack spilling occurring?
- Was the loop unrolled automatically?
- Did aliasing concerns prevent vectorization?

Use compiler vectorization reports where available.

Examples may include:

```text
-fopt-info-vec
-Rpass=loop-vectorize
```

depending on compiler.

Do not make compiler-specific flags mandatory for the whole project.

---

# 21. Pointer Aliasing

Investigate whether aliasing assumptions affect compiler optimization.

For example, conceptually:

```cpp
void kernel(
    const float* A,
    const float* B,
    float* C
);
```

The compiler may need to conservatively reason about whether memory overlaps.

Architecture/compiler-specific mechanisms such as `restrict` / `__restrict__` may improve optimization.

This should be investigated carefully and documented.

Do not introduce undefined behavior by claiming non-aliasing when buffers can actually overlap.

---

# 22. Phase 7 — SIMD

After understanding compiler auto-vectorization, implement explicit SIMD if useful.

The implementation should ideally be architecture-separated.

Possible architectures:

### x86-64

Potential instruction sets:

```text
SSE
AVX2
AVX-512
FMA
```

### ARM

Potential instruction set:

```text
NEON
```

Do not design the entire project around one architecture unless necessary.

A reasonable abstraction might be:

```text
generic scalar kernel
architecture-specific optimized kernels
runtime or compile-time selection
```

But keep the design simple initially.

---

# 23. SIMD Concept

Instead of computing:

```text
C0 += A * B0
C1 += A * B1
C2 += A * B2
C3 += A * B3
```

one scalar at a time, operate on vectors.

Conceptually:

```text
B vector:
[b0 b1 b2 b3 b4 b5 b6 b7]

A scalar broadcast:
[a  a  a  a  a  a  a  a]

FMA:

C = A * B + C
```

This maps naturally to GEMM.

The project should understand:

- vector width
- aligned vs unaligned accesses
- broadcasts
- loads/stores
- fused multiply-add
- register pressure
- tail handling

---

# 24. Tail Handling

Matrix dimensions may not be multiples of:

```text
block size
SIMD width
microkernel width
unroll factor
```

Optimized code must correctly handle remainders.

Possible strategies:

- scalar cleanup loops
- masked vector operations where supported
- specialized remainder kernels

Correctness should never rely on dimensions being convenient powers of two.

---

# 25. Phase 8 — Packing

Potentially introduce matrix packing after basic blocked/SIMD GEMM works.

Packing means copying blocks into a layout optimized for the microkernel.

Example:

```text
Original B layout
        |
        v
pack B block
        |
        v
contiguous microkernel-friendly buffer
```

Possible benefits:

- sequential memory access
- predictable alignment
- reduced cache/TLB complexity
- easier SIMD loads
- reduced awkward strides

Packing introduces overhead.

The project should determine when the reuse gained from packing outweighs the copy cost.

Do not introduce packing too early.

---

# 26. Phase 9 — Multithreading

Once single-core performance is reasonably optimized, introduce multicore execution.

Possible starting strategy:

Partition C into independent tiles.

Example:

```text
+----+----+----+----+
| T0 | T1 | T2 | T3 |
+----+----+----+----+
| T4 | T5 | T6 | T7 |
+----+----+----+----+
| T8 | T9 |T10 |T11 |
+----+----+----+----+
```

Each worker computes one or more C tiles.

---

# 27. Threading Strategies to Compare

Potential approaches:

### Static partitioning

Each thread receives a fixed region.

Advantages:

- low scheduler overhead
- predictable memory access

Disadvantages:

- potential imbalance for unusual workloads

### Dynamic work queue

Threads consume tile jobs from a shared queue.

Advantages:

- better load balancing

Disadvantages:

- synchronization overhead
- contention

Potential later work stealing is optional.

---

# 28. Avoid Creating Threads Per GEMM Tile

Prefer persistent worker threads or a thread pool for repeated work.

Creating and destroying operating-system threads repeatedly would distort performance.

The threading infrastructure should be relatively simple and should not overwhelm the GEMM code itself.

---

# 29. Multicore Performance Metrics

Measure:

```text
1 thread
2 threads
4 threads
8 threads
...
```

depending on hardware.

Calculate speedup:

\[
S(p) = \frac{T_1}{T_p}
\]

Also calculate parallel efficiency:

\[
E(p) = \frac{S(p)}{p}
\]

Study why scaling eventually becomes sublinear.

Possible causes:

- memory bandwidth
- cache contention
- synchronization
- limited core count
- thermal/power behavior
- shared execution resources

---

# 30. False Sharing

When multithreading, consider false sharing.

If multiple worker threads repeatedly update different values located on the same cache line, coherence traffic can hurt performance.

The GEMM tile decomposition should minimize shared writes.

Ideally different threads should own disjoint output regions.

---

# 31. Thread Affinity

Potential advanced experiment:

Investigate whether pinning threads to cores changes performance.

This should be optional because affinity APIs differ across operating systems.

Do not make V1 depend on affinity support.

---

# 32. Hardware Performance Counters

Timing alone is not enough.

Where supported, use performance counters.

Linux `perf` is a likely tool.

Potential counters:

```text
cycles
instructions
IPC
cache references
cache misses
branch instructions
branch misses
L1 misses
LLC misses
```

Availability varies by CPU.

Do not hardcode assumptions that every event exists.

---

# 33. Questions Hardware Counters Should Help Answer

Examples:

### Loop ordering

Did improved locality reduce cache misses?

### Blocking

Did cache behavior improve?

### Register blocking

Did arithmetic throughput improve?

### Unrolling

Did IPC increase?

### SIMD

Did instructions per FLOP decrease?

### Multithreading

Did memory bandwidth become the bottleneck?

The project should connect measurements to architectural explanations.

---

# 34. Arithmetic Intensity

Introduce the concept:

\[
\text{Arithmetic Intensity}
=
\frac{\text{FLOPs}}{\text{Bytes Transferred}}
\]

GEMM is important because blocking allows significant data reuse, increasing effective arithmetic intensity.

This explains why well-optimized GEMM can become compute-bound rather than memory-bandwidth-bound.

---

# 35. Roofline Model

Eventually create a simple Roofline analysis.

Roofline performance bound:

\[
P = \min(P_{\text{peak}}, B \times I)
\]

where:

- \(P_{\text{peak}}\) = peak compute performance
- \(B\) = memory bandwidth
- \(I\) = arithmetic intensity

Use it to reason about whether a given implementation is:

```text
memory-bound
```

or:

```text
compute-bound
```

This does not need to be implemented immediately.

It belongs in the later analysis stage.

---

# 36. Comparison Against BLAS

Eventually benchmark against one high-quality GEMM implementation available on the machine.

Possible libraries:

```text
OpenBLAS
BLIS
Apple Accelerate
oneMKL
```

The comparison should report:

```text
our GEMM GFLOP/s
reference GEMM GFLOP/s
percentage of reference
```

For example:

\[
\text{Relative performance}
=
\frac{P_{\text{ours}}}{P_{\text{BLAS}}}
\times100\%
\]

Do not treat failing to beat BLAS as a failure.

Reaching a meaningful fraction of a heavily optimized production library is already informative.

The learning goal is understanding why the gap exists.

---

# 37. Benchmark Visualization

Use scripts to produce plots.

Potential plots:

### Performance vs matrix size

```text
x-axis: N
y-axis: GFLOP/s
lines: implementations
```

### Optimization progression

```text
naive
loop reordered
blocked
microkernel
unrolled
SIMD
parallel
BLAS
```

### Thread scaling

```text
x-axis: threads
y-axis: speedup
```

### Block-size sweep

```text
x-axis: block size
y-axis: GFLOP/s
```

### Microkernel sweep

```text
x-axis: kernel configuration
y-axis: GFLOP/s
```

---

# 38. Preserve Optimization History

Do not continually overwrite a single `gemm()` function.

Keep meaningful implementations available for comparison.

Example:

```cpp
gemm_naive()
gemm_ikj()
gemm_blocked()
gemm_register_blocked()
gemm_unrolled()
gemm_simd()
gemm_parallel()
```

This is important because the project story is based on progression.

Avoid creating twenty nearly identical versions with meaningless names.

Each retained version should correspond to a major optimization concept.

---

# 39. Results Format

Benchmark results should ideally be machine-readable.

CSV is sufficient.

Example:

```text
implementation,M,N,K,threads,time_ms,gflops
naive,512,512,512,1,85.2,3.15
ikj,512,512,512,1,18.4,14.59
blocked,512,512,512,1,10.1,26.58
```

A Python plotting script is acceptable.

The actual GEMM implementation should remain C++.

---

# 40. Reproducibility

Store environment information alongside benchmark results when possible.

Example:

```text
CPU
OS
compiler
compiler version
optimization flags
matrix data type
thread count
date
```

This makes comparisons meaningful.

Do not compare benchmarks collected under dramatically different conditions without documenting that fact.

---

# 41. Performance Benchmark Safety

Ensure the compiler cannot optimize away GEMM because the result is unused.

Possible strategies:

- compute a checksum after each measured computation
- consume output outside the measured region
- otherwise ensure observable results

But avoid including expensive checksum operations inside the timed GEMM region.

---

# 42. Random Input Generation

Use deterministic random generation with known seeds.

Example:

```cpp
std::mt19937 rng(seed);
```

This improves reproducibility.

Input generation must occur outside the benchmark timing region.

---

# 43. Memory Allocation

Do not include matrix allocation in GEMM timing unless explicitly benchmarking allocation.

Allocate A, B, and C before starting the measured region.

Eventually investigate alignment if SIMD makes alignment relevant.

Potential aligned allocation approaches should remain portable or architecture-isolated.

---

# 44. Important Performance Concepts This Project Should Teach

The code and documentation should demonstrate understanding of:

### Spatial locality

Accessing nearby memory benefits from cache-line fetches.

### Temporal locality

Reusing recently accessed data while it remains in cache.

### Cache blocking

Structuring work so the active working set fits into the memory hierarchy.

### Register blocking

Keeping frequently updated values in registers.

### SIMD

Performing one instruction across multiple data elements.

### FMA

Computing:

\[
a \times b + c
\]

in one fused operation.

### Instruction-level parallelism

Providing independent instructions so the CPU can execute multiple operations simultaneously.

### Register pressure

Too many live values can force register spills.

### Memory bandwidth

Data transfer can limit scaling.

### Cache coherence

Multicore writes can introduce coherence traffic.

### Compiler optimization

Source structure influences optimization opportunities.

---

# 45. Potential Optimization Ladder

A reasonable project history might become:

```text
V0
Reference scalar GEMM

V1
Naive ijk GEMM

V2
Loop-order experiments

V3
Best reordered scalar GEMM

V4
Cache-blocked GEMM

V5
Register-blocked microkernel

V6
Unrolled microkernel

V7
Compiler-vectorized GEMM

V8
Explicit SIMD GEMM

V9
Packed SIMD GEMM

V10
Multithreaded GEMM

V11
Autotuned GEMM
```

Do not implement all these immediately.

---

# 46. Milestone 1

The first useful milestone should include only:

```text
CMake project
matrix representation
naive GEMM
reference GEMM
correctness tests
benchmark harness
GFLOP/s calculation
several matrix sizes
CSV output
basic README
```

Nothing more is required before benchmarking the naive implementation.

---

# 47. Milestone 2

Implement six loop orders:

```text
ijk
ikj
jik
jki
kij
kji
```

Benchmark each.

Document:

- memory access pattern
- observed performance
- interpretation

Generate first performance graph.

---

# 48. Milestone 3

Implement cache blocking.

Support configurable:

```text
BM
BN
BK
```

Benchmark several choices.

Try to connect optimal configurations to cache hierarchy.

---

# 49. Milestone 4

Implement a scalar microkernel.

Explore register blocking.

Inspect optimized assembly.

Determine whether accumulators remain in registers.

Investigate when register spilling appears.

---

# 50. Milestone 5

Experiment with K-loop unrolling.

Compare:

```text
unroll 1
unroll 2
unroll 4
unroll 8
```

Inspect generated assembly.

Measure whether manual unrolling actually improves performance.

---

# 51. Milestone 6

Study auto-vectorization.

Compare compiler flags.

Inspect assembly.

Then optionally introduce explicit SIMD.

Do not immediately jump to intrinsics without understanding what the compiler already does.

---

# 52. Milestone 7

Add multithreading.

Start with straightforward partitioning of output tiles.

Measure scaling.

Then consider whether dynamic scheduling provides any benefit.

---

# 53. Milestone 8

Profile with hardware counters.

Produce an architectural explanation of performance evolution.

---

# 54. Milestone 9

Compare against optimized BLAS.

Document the remaining performance gap.

Investigate why the optimized library is faster.

Potential reasons:

- sophisticated packing
- architecture-specific kernels
- better register tiling
- optimized prefetching
- assembly microkernels
- NUMA awareness
- better scheduling
- special-case kernels

---

# 55. Possible V2 — Autotuning

After CPU GEMM is mature, build an autotuner.

Search parameters such as:

```text
BM
BN
BK
MR
NR
unroll factor
thread count
```

Example conceptual search:

```cpp
for (BM : block_sizes) {
    for (BN : block_sizes) {
        for (BK : block_sizes) {
            for (MR : microkernels) {
                benchmark();
            }
        }
    }
}
```

Record the fastest valid configuration.

---

# 56. Smarter Autotuning

Potential progression:

```text
brute-force parameter search
        |
        v
pruned search
        |
        v
hardware-informed candidate generation
```

Questions:

- Can cache dimensions predict good BM/BN/BK?
- Can SIMD width predict NR?
- Can architectural register count help predict MR/NR?
- Are optimal parameters dependent on matrix dimensions?
- Does one configuration work for all GEMM shapes?

This starts moving toward runtime/compiler optimization.

---

# 57. Possible V3 — GPU GEMM

GPU work is NOT part of the initial deliverable.

Possible later trajectory using CUDA:

```text
naive GPU GEMM
        |
        v
coalesced memory access
        |
        v
shared-memory tiling
        |
        v
register tiling
        |
        v
warp-aware execution
        |
        v
vectorized loads
        |
        v
Tensor Core exploration
```

Compare against cuBLAS if running on NVIDIA hardware.

---

# 58. CPU/GPU Conceptual Mapping

The CPU implementation should provide useful conceptual grounding for GPU optimization.

Rough analogy:

```text
CPU                         GPU

cache blocking       <->   shared-memory tiling

SIMD                 <->   SIMT execution

register blocking    <->   register tiling

CPU threads          <->   thread blocks / warps

FMA                  <->   CUDA cores / matrix operations

cache hierarchy      <->   global/shared/register hierarchy
```

This relationship is important to the broader learning goal.

---

# 59. Possible V4 — Kernel Generation / Runtime

An ambitious later extension could turn the project into a small hardware-aware GEMM runtime.

Input:

```text
M
N
K
CPU architecture
cache information
SIMD width
thread count
```

Runtime chooses:

```text
block dimensions
microkernel
unroll factor
SIMD kernel
thread partitioning
```

This would turn the project from:

> one optimized matrix multiplication implementation

into:

> a small hardware-aware numerical kernel runtime.

This is explicitly a future extension.

Do not architect V1 around this requirement.

---

# 60. Coding Standards

Use modern C++ but prioritize clarity.

Prefer:

```cpp
std::size_t
std::vector
RAII
constexpr
```

where appropriate.

Avoid unnecessary:

```text
inheritance
template metaprogramming
runtime polymorphism
complex design patterns
```

unless they solve a real problem.

The performance kernel itself should remain straightforward to inspect.

---

# 61. Optimization Rules

Never:

- fabricate benchmark numbers
- claim an optimization improved performance without measuring
- assume larger blocks are faster
- assume manual SIMD beats auto-vectorization
- assume manual unrolling beats the compiler
- remove correctness checks merely for speed
- include setup/allocation in kernel timing accidentally
- compare Debug builds against Release libraries
- optimize solely around one matrix size without documenting it

---

# 62. Performance Regression Testing

Eventually preserve benchmark baselines.

A lightweight system could warn when performance drops substantially.

Do not make exact GFLOP/s values part of ordinary unit tests because system noise makes them unstable.

Instead separate:

```text
correctness tests
performance benchmarks
```

---

# 63. README Structure

The final README should eventually tell the project story.

Suggested structure:

```text
# High-Performance GEMM

## Goal

## GEMM Background

## Baseline Implementation

## Benchmark Methodology

## Optimization 1: Loop Ordering

## Optimization 2: Cache Blocking

## Optimization 3: Register Blocking

## Optimization 4: Loop Unrolling

## Optimization 5: SIMD

## Optimization 6: Multithreading

## Hardware Counter Analysis

## Roofline Analysis

## Comparison Against BLAS

## Final Results

## Lessons Learned

## Build Instructions
```

Avoid writing the entire final README before results exist.

Update it progressively.

---

# 64. Optimization Log

Maintain something like:

```text
docs/optimization_log.md
```

For each experiment record:

```text
Hypothesis:
What do I think will improve?

Change:
What did I modify?

Expected result:
Why should it help?

Benchmark:
What happened?

Explanation:
Why?

Decision:
Keep / revert / investigate further.
```

Example:

```text
Hypothesis:
Changing ijk -> ikj should improve B locality.

Change:
Reordered k and j loops.

Expected:
Sequential traversal across B rows and C rows.

Result:
2.8x higher GFLOP/s at N=1024.

Interpretation:
Lower cache-miss pressure and more compiler-friendly inner loop.

Decision:
Use ikj as scalar baseline.
```

All numbers must be real.

---

# 65. Benchmark Output Philosophy

The most compelling output of the project should eventually be a progression graph such as:

```text
                     GFLOP/s

Naive                    X
Loop reordered           X
Blocked                  X
Register blocked         X
Unrolled                 X
SIMD                     X
Multithreaded            X
Optimized BLAS           X
```

Again, actual values must be measured.

This graph should summarize the entire engineering story.

---

# 66. Questions the Project Should Eventually Be Able to Answer

By the end, I want to understand:

1. Why can two O(N³) GEMM implementations differ dramatically in speed?

2. Why does loop ordering matter?

3. How do cache lines affect matrix traversal?

4. Why does blocking improve GEMM?

5. How should block size relate to cache capacity?

6. Why does register blocking improve throughput?

7. What limits microkernel size?

8. When does register spilling occur?

9. Why can loop unrolling help?

10. When does the compiler already perform unrolling?

11. What prevents compiler auto-vectorization?

12. How does SIMD map onto GEMM?

13. Why are FMA instructions important?

14. What is arithmetic intensity?

15. Why is optimized GEMM often compute-bound?

16. How does multicore GEMM scale?

17. What eventually limits multicore speedup?

18. Why do production BLAS libraries outperform simple optimized implementations?

19. How does CPU GEMM optimization relate to GPU kernels?

20. How could a compiler/runtime automatically choose GEMM parameters?

---

# 67. Things NOT to Do Yet

Do not initially implement:

- CUDA
- distributed GEMM
- MPI
- neural-network frameworks
- automatic differentiation
- convolution
- arbitrary tensor operations
- JIT compilation
- Tensor Cores
- custom assembly kernels
- complicated expression templates
- heterogeneous scheduling
- NUMA-aware scheduling

These are possible extensions.

The initial project must first prove the basic CPU performance-engineering story.

---

# 68. First Codex Task

Start with Milestone 1 only.

Create the smallest coherent implementation containing:

1. CMake project
2. contiguous row-major Matrix representation
3. scalar reference GEMM
4. naive `ijk` GEMM
5. correctness tests
6. simple benchmark executable
7. GFLOP/s calculation
8. deterministic random matrix initialization
9. multiple benchmark sizes
10. CSV-compatible benchmark output
11. basic README with build/run instructions

Do NOT implement:

- blocking
- SIMD
- explicit multithreading
- loop unrolling
- autotuning
- GPU support

yet.

The first goal is to establish a trustworthy baseline.

---

# 69. First Implementation Design

Suggested files:

```text
CMakeLists.txt

include/gemm/matrix.hpp
include/gemm/gemm.hpp

src/matrix.cpp
src/gemm_reference.cpp
src/gemm_naive.cpp

tests/test_gemm.cpp

benchmarks/benchmark_main.cpp

README.md
```

Avoid excessive project scaffolding.

---

# 70. Suggested Initial API

```cpp
namespace gemm {

void reference(
    const float* A,
    const float* B,
    float* C,
    std::size_t M,
    std::size_t N,
    std::size_t K
);

void naive_ijk(
    const float* A,
    const float* B,
    float* C,
    std::size_t M,
    std::size_t N,
    std::size_t K
);

}
```

Matrix wrapper:

```cpp
namespace gemm {

class Matrix {
public:
    Matrix(std::size_t rows, std::size_t cols);

    std::size_t rows() const noexcept;
    std::size_t cols() const noexcept;

    float* data() noexcept;
    const float* data() const noexcept;

    float& operator()(std::size_t row, std::size_t col);
    const float& operator()(std::size_t row, std::size_t col) const;

private:
    std::size_t rows_;
    std::size_t cols_;
    std::vector<float> data_;
};

}
```

Exact API can change if there is a clearly better reason.

---

# 71. Testing Expectations for First Commit

Test at least:

```text
1x1 * 1x1

2x2 * 2x2 known values

2x3 * 3x2 known values

identity multiplication

zero multiplication

random matrices against reference

odd dimensions
```

For random matrices compare with floating-point tolerance.

---

# 72. Benchmark Expectations for First Commit

Benchmark something approximately like:

```text
64 x 64
128 x 128
256 x 256
512 x 512
1024 x 1024
```

Adjust if runtime becomes excessive.

Output approximately:

```text
implementation,M,N,K,time_ms,gflops
naive_ijk,64,64,64,...
naive_ijk,128,128,128,...
...
```

Perform warmup runs.

Use multiple measured iterations.

Report median.

---

# 73. Timing

Use:

```cpp
std::chrono::steady_clock
```

or an equally appropriate monotonic clock.

Do not use wall-clock time APIs that can jump.

---

# 74. Benchmark Correctness Guard

After timing, use output values somehow so the compiler cannot remove the multiplication.

Possible simple checksum:

```cpp
float checksum = 0.0f;

for (...) {
    checksum += C[i];
}
```

Print or otherwise consume it outside the timed region.

---

# 75. First README

The first README should be concise.

It should explain:

- this is a from-scratch GEMM performance-engineering project
- current implementation is intentionally naive
- future work will progressively optimize cache use, SIMD, and multicore execution
- how to configure
- how to build
- how to test
- how to run benchmarks

Do not claim performance results before benchmarks are run.

---

# 76. Git / Commit Philosophy

Major optimizations should ideally correspond to understandable commits.

Examples:

```text
baseline GEMM and benchmark harness

benchmark loop-order permutations

add cache-blocked GEMM

add register-blocked microkernel

experiment with K-loop unrolling

add AVX2 microkernel

add multicore tile scheduler
```

This helps preserve the evolution of the project.

---

# 77. Longer-Term Resume Target

The project may eventually support bullets in the spirit of:

```text
• Built a high-performance C++ GEMM engine and improved throughput by X× over a naive baseline using cache blocking, register tiling, SIMD/FMA, and loop-level optimization.

• Profiled cache behavior, instruction throughput, and multicore scaling using hardware performance counters; achieved Y GFLOP/s and Z% of optimized BLAS performance.
```

Potential third bullet if warranted:

```text
• Designed a tiled multicore execution engine / autotuner that selected cache and microkernel parameters based on benchmarked hardware behavior.
```

These are NOT current claims.

They are target outcomes.

Never fill X/Y/Z with invented values.

---

# 78. Broader Project Narrative

The project should tell this story:

```text
I started with the mathematical algorithm.

Then I asked:

Why is it slow?

That led to:

memory access patterns

then:

cache locality

then:

blocking

then:

register reuse

then:

instruction-level parallelism

then:

SIMD

then:

multicore scaling

then:

performance modeling

then potentially:

GPU architecture and compiler/runtime optimization.
```

The progression itself is one of the most important parts of the project.

---

# 79. Primary Success Criterion

Success is NOT:

> I wrote matrix multiplication.

Success is:

> I can explain, measure, and experimentally demonstrate how the same mathematical computation maps differently onto modern hardware, and I progressively transformed a naive implementation into an efficient numerical kernel.

---

# 80. Instructions to Codex Going Forward

When helping with this repository:

1. Preserve the educational progression.

2. Do not skip immediately to the final optimized answer unless explicitly requested.

3. Prefer explaining why an optimization is appropriate before applying it.

4. Keep implementations benchmarkable against previous versions.

5. Never fabricate benchmark numbers.

6. Never report an optimization as successful until it is measured.

7. Keep correctness testing independent of performance benchmarking.

8. Prefer simple code over abstraction-heavy architecture.

9. Keep the hot path inspectable.

10. Point out architecture-specific behavior when relevant.

11. If a proposed optimization may not improve performance, say so and benchmark it.

12. When changing performance-critical code, consider how the compiler will lower it.

13. When appropriate, inspect generated assembly rather than assuming what the compiler did.

14. Record significant optimization decisions in the optimization log.

15. Do not introduce GPU work until the CPU implementation has reached a meaningful level of maturity.

16. Avoid implementing future milestones merely because they are listed here.

17. Work incrementally.

---

# 81. Immediate Action

For now, implement **Milestone 1 only**.

Before doing performance optimization, establish:

```text
correctness
repeatable benchmarks
clean baseline
reproducible results
```

Once the baseline works, the next task will be the six loop-order experiment.

The expected project sequence from there is:

```text
Baseline
  ↓
Loop ordering
  ↓
Cache blocking
  ↓
Register microkernel
  ↓
Loop unrolling
  ↓
Vectorization
  ↓
Explicit SIMD
  ↓
Packing
  ↓
Multicore
  ↓
Hardware-counter analysis
  ↓
BLAS comparison
  ↓
Optional autotuning
  ↓
Optional GPU implementation
```

Treat this document as the project's current technical charter. Revise it as real measurements teach us more about the design.