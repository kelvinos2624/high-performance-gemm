# Milestone 5 Findings

Milestone 5 established a controlled K-loop unrolling experiment and demonstrated that expanding the loop does not automatically improve GEMM performance


# Summary of Changes

- Added unroll factors 2, 4, and 8 to the 4×4 microkernel.
- Preserved the original factor-1 implementation as the default and comparison baseline.
- Added scalar cleanup for leftover K values.
- Extended the API, CLI, and CSV output with an unroll parameter.
- Added reduction-tail tests, benchmark scripts, a comparison graph, and saved assembly analysis.


# How it was Done

Instead of processing one K value per loop iteration, the new variants explicitly perform two, four, or eight consecutive updates.

The experiment deliberately kept these choices fixed:
- Microtile: 4×4.
- Macro tile: 32×128×32 for the measured comparison.
- Accumulators: the same sixteen partial sums.
- Arithmetic order: increasing K for each output.

No separate accumulation chains, explicit SIMD, or new compiler flags were introduced. This lets us study unrolling without combining it with other optimizations.
A full group executes only when enough K values remain. A scalar cleanup loop handles the remainder, including macro K blocks shorter than the unroll factor.


# Evaluation Process

Correctness tests exercised every remainder modulo 2, 4, and 8, short K blocks, simultaneous matrix-edge tails, and the earlier microkernel boundary cases.

Performance testing used:
- Three square sizes and one odd rectangular shape.
- A validated warmup and five measured calls per configuration.
- A second sweep in reverse configuration order.
- A targeted seven-repetition follow-up at 512² after an unusually slow result.

All comparisons used freshly measured factor-1 timings from the same binary.


# Performance-Related Observations

What the assembly proved
The compiler actually retained the requested expansion; the source changes were not optimized back into the original loop.
Factor	Scalar FMAs per main iteration	Tile-body instruction bytes
1	16	240
2	32	536
4	64	736
8	128	1,072

The helper was fully inlined, and none of the expanded main loops spilled accumulators to the stack. Higher factors did introduce additional function-entry register saves, which are different from spills inside the reduction loop.
The unchanged factor-1 assembly also showed that this compiler had not already automatically unrolled its K loop.

Overall, the measurements show that there was no stable overall winner.

- At 256², the ranking changed between sweeps.
- At 512², every expanded factor lost to factor 1 in both sweeps and the targeted follow-up.
- At 1024², small gains appeared, but varied enough that they did not justify a tuning policy.
- On the odd rectangular shape, every expanded factor regressed in both sweeps.

For example, the 512² follow-up measured 24.07 GFLOP/s for factor 1, versus 23.85, 23.45, and 23.37 for factors 2, 4, and 8.

The milestone did not isolate the performance contribution of:
- increased code size
- additional function-entry register saves
- instruction scheduling differences
- reduced loop-control frequency
- possible instruction-cache effects, which were not measured directly


# Lesson as a Phrase

More instructions in flight do not automatically mean more throughput. Loop unrolling only helps when the hardware can exploit the additional scheduling freedom enough to outweigh its overhead.
