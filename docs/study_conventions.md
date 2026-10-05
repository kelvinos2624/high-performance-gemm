When implementing or modifying this GEMM project, explicitly mark the lines and regions that I should personally study and understand.

The purpose is to distinguish performance-critical / conceptually important code from ordinary project scaffolding and boilerplate.

## Marking convention

Use these comments where appropriate:

```cpp
// PERF-CRITICAL:
```

Use this for code whose structure, ordering, memory-access pattern, instruction choice, or implementation could materially affect GEMM performance.

Examples:
- loop ordering
- matrix indexing inside hot loops
- cache-blocking loops
- block boundary calculations
- microkernel code
- register accumulators
- SIMD loads/stores
- broadcasts
- FMA operations
- packing logic
- thread/task decomposition
- synchronization in the execution path
- prefetching
- alignment assumptions
- aliasing-related declarations
- anything directly affecting cache locality, vectorization, ILP, register pressure, or memory traffic

---

Use:

```cpp
// PERF-SEMANTICS:
```

for lines that are important because they preserve the meaning or correctness of a performance optimization.

Examples:
- zeroing C before an accumulating `ikj` implementation
- handling matrix tails
- clamping block boundaries
- ensuring packed buffers contain the expected data
- initialization required by an accumulator-based microkernel
- conditions preventing out-of-bounds SIMD accesses

These may not themselves make the program faster, but I need to understand them to understand why the optimized implementation is correct.

---

Use:

```cpp
// BENCHMARK-IMPORTANT:
```

for benchmark methodology that could change the validity of performance results.

Examples:
- start/end of timed regions
- warmup execution
- repetition logic
- median calculation
- GFLOP/s calculation
- avoiding allocation inside the timed region
- checksum / optimization guards
- thread-count configuration
- anything that might accidentally contaminate measurements

---

Use:

```cpp
// COMPILER-IMPORTANT:
```

for source constructs specifically intended to influence compiler optimization.

Examples:
- `restrict` / `__restrict__`
- `constexpr` parameters affecting specialization
- manual unrolling
- forced inlining if introduced
- alignment hints
- vectorization-related structure
- architecture-specific intrinsics
- constructs intended to keep values in registers

Explain briefly what we expect the compiler to do because of the code.

---

## Comment style

Do not mark every line individually if several adjacent lines form one concept.

Prefer:

```cpp
// PERF-CRITICAL: Inner j loop walks B and C contiguously.
// A[i,k] is reused across the entire row, improving spatial locality
// and exposing a vectorizable inner loop.
const float a = A[i * K + k];

for (std::size_t j = 0; j < N; ++j) {
    C[i * N + j] += a * B[k * N + j];
}
```

rather than:

```cpp
// PERF-CRITICAL
const float a = ...

// PERF-CRITICAL
for (...) {

// PERF-CRITICAL
    C[...] += ...
}
```

Keep comments concise and technically meaningful.

Do not clutter ordinary boilerplate with these markers.

---

## What NOT to mark

Normally do not mark:

- CMake boilerplate
- namespace declarations
- ordinary getters/setters
- generic file organization
- CLI parsing
- CSV string formatting
- obvious test harness plumbing
- ordinary constructors/destructors
- documentation-only changes

unless something in them genuinely affects performance measurements or hot-path behavior.

---

## Important learning rule

If you introduce a new optimization, do not merely implement it.

Before or alongside the implementation, identify:

1. what bottleneck it is intended to address,
2. which lines implement the actual optimization,
3. what hardware behavior those lines are trying to change,
4. what measurable effect we expect,
5. what result would falsify our hypothesis.

For example:

```text
Optimization:
ijk -> ikj loop reordering

Bottleneck:
Strided traversal of row-major B in the inner loop.

Important code:
The k/j loop interchange and reuse of A[i,k].

Expected hardware effect:
Sequential B/C access, improved spatial locality, easier vectorization.

Expected benchmark effect:
Higher GFLOP/s, especially as matrices exceed smaller cache levels.

Possible falsification:
No improvement or regression after controlling for compiler flags and benchmark noise.
```

---

## After every implementation

At the end of your response, include a section called:

```text
Important code to study
```

List only the files and approximate regions that I should personally inspect.

For each region, explain in 1–3 sentences why it matters.

Example:

```text
Important code to study

src/gemm_ikj.cpp
- Inner k/j loop: this is the actual locality optimization.
- A scalar temporary: demonstrates reuse of A[i,k].

benchmarks/benchmark_main.cpp
- Timed region: determines whether measurements include setup overhead.
- Median calculation: determines how repeated timings are summarized.
```

Also include:

```text
Safe to skim
```

listing files or changes that are mostly scaffolding and do not need deep study.

---

## Performance-critical authorship boundary

When the implementation reaches more advanced stages—especially:

- cache blocking
- register blocking
- microkernels
- manual unrolling
- SIMD intrinsics
- packing
- thread decomposition

do not silently make major performance-design decisions for me.

If you need to choose among meaningful alternatives, state the choice clearly and explain it.

For example, do not simply choose:

```text
MR = 8
NR = 8
```

without explaining why.

Likewise, do not introduce a specific SIMD layout, packing format, block-loop ordering, or thread partitioning without making the decision visible.

The goal is for me to remain the owner of the performance reasoning even when you help write the implementation.

---

## Core principle

Treat code as belonging to one of two categories:

```text
scaffolding / implementation plumbing
```

or

```text
code that teaches me something about GEMM performance
```

Make the second category visually obvious.

I should be able to open any optimized GEMM source file and quickly identify the small subset of code that I absolutely need to understand well enough to reproduce and explain in an interview.