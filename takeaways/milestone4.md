# Milestone 4 Findings

This milestone establishes working register-blocked microkernels and direct evidence of how the compiler allocates their accumulators. It also showed that keeping values in registers alone does not necessarily guarantee better performance.


# Summary of Changes

- Added microtiles of 2×4, 4×4, 4×8, 8×4, and 8×8, plus a 16×16 register-pressure experiment.
- Integrated them into the existing cache-blocked structure.
- Added scalar cleanup for incomplete microtiles.
- Extended tests and benchmark options with MR and NR.
- Saved two benchmark sweeps, comparison plots, optimized assembly, and an explanation of the findings.
Earlier implementations remain available for comparison.


# How it was Done

The outer ii → kk → jj cache-block loops remain unchanged. Within each macro tile, a microkernel:
1. Loads an MR×NR region of C into local accumulators.
2. Advances through the current K block.
3. Reuses each B value across multiple rows and each A value across multiple columns.
4. Stores the accumulated outputs back to C.
This aims to reduce repeated C loads/stores and expose independent arithmetic chains. Loading existing C values preserves partial sums from earlier K blocks.
MR and NR are compile-time dimensions inside the tile bodies, giving the compiler a chance to place accumulators in registers. That was an expectation to verify, not an assumption. No manual K unrolling or explicit SIMD intrinsics were added.


# Evaluation Process

The main comparison fixed the macro tile at 32×128×32, varying only the microtile. Each variant was measured against both plain blocked GEMM and ikj on three square problems and one odd rectangular problem.
Validated warmups were used, five timed calls per configuration, and median timings. A reverse-order repeat produced 64 measured configurations across the two sweeps.
Also inspected optimized assembly generated with the Release compiler flags:

Microtile	Observed accumulator behavior
2×4, 4×4	Remain in registers throughout K
4×8, 8×4	Spill and reload inside K
8×8	Extensive hot-loop spilling
16×16	Stack-resident accumulator array updated using compiler-generated vector instructions

Ordinary function-entry register saves were distinguished from spills inside the computational loop.


# Performance-Related Observations

Small tiles achieved register residency. Larger variants reveal the register-pressure tradeoff: additional accumulators can force memory traffic back into the hot loop.

Notably, 4x4 lost to plain blocked GEMM on every tested square shape in both sweeps. At 512^2:
- 4x4: 24.46/24.02 GFLOP/s
- Plain blocked: 30.41/30.35 GFLOP/s

Blocked comparator uses vector FMA instructions, while 4x4 uses scalar FMA.
Worth noting that tile-call overhead and repeated load/store at K-block boundaries remain part of implementation.

16x16 case beat blocked at 1024^2, but only roughly matched ikj. Its performance does not have clear evidence that 356 accumulators stayed in registers.

This milestone is not isolated enough to determine how much time is coming from spills, call overhead, instruction selection, or operand reuse. Results primarily apply to compiler, machine, macro tile, and measured shapes.


# Lesson as a Phrase

Register residency does not automatically mean higher performance. More register reuse helps only if it doesn’t sacrifice vectorization or create register pressure.
