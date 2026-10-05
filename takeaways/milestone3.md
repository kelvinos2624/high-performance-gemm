# Milestone 3 Findings

Milestone 3 establishes a configurable cache-blocked GEMM.
It shows that blocking can help in various scenarios, but does not automatically improve an already well-ordered implementation


# Summary of Changes

- Added blocked, with independently configurable BM, BN, and BK.
- Preserved all six earlier loop-order implementations.
- Added handling for partial tiles, oversized tiles, and invalid block dimensions.
- Extended the benchmark with block-size arguments, rectangular shapes, and tile dimensions in CSV output.
- Added a reproducible tile sweep, comparison heatmap, cache analysis, and recorded results.


# How It Was Done

The kernel uses this structure:

    ii → kk → jj       choose a matrix tile
        i → k → j      compute within that tile

The inner j loop still accesses B and C contiguously and reuses one A value. The outer tile loops aim to reuse a smaller region of B across several output rows before moving on.

Three correctness details matter:
- Zero C once: clearing it for every K tile would destroy earlier partial sums.
- Clamp tile boundaries: dimensions need not be multiples of block sizes.
- Advance safely: boundary calculations avoid overflow even for enormous tile arguments.
Required initialization remains inside the timed operation.


# Evaluation Process

10 tile configurations were tested: square tiles from 8-256, plus 4 rectangular tiles.
Each configuration was compared against a freshly measured ikj baseline on three square problems and one odd rectangular problem.
Each configuration received a validated warmup and 5 measured calls.
The sweep was repeated in reverse configuration order, producing 88 measured configurations.


# Performance-Related Observations

Problem	Repeated observation
    256²	64×256×64 improved throughput by 21–25%
    512²	32×128×32 improved throughput by 11–13%
    1024²	Every tested blocked configuration regressed; the best reached about 85% of ikj throughput
    255×513×257	Best observed gains were about 6%, with a changing winning tile

Measurements help demonstrate that tile shape and problem size matter. Simply fitting a tile into cache is insufficient in practice.
Small tiles fit easily but performed poorly. They also shorten inner loops and introduce more loop-management work.

Results did not establish a precise cause of eaach performance change.

Summarized thoughts:
    Cache capacity alone is an insufficient model:
        A tile fitting comfortably in a cache does not imply it is optimal nor does it guarantee better throughput
    Blocking has costs:
        More loops, more boundary checks, shorter inner loops, potentially worse compiler optimizations,
        and potentially disrupted prefetch/vectorization can offset reuse gains.
    The best tile is workload-dependent:
        The winners for 256 and 512 are different and rectangular case shifts again

# Lesson in a Phrase

Performance optimization is not monotonic. A theoretically sensible transformation can improve one regime and regress another.
As seen in this example, tiling does not automatically guarantee better performance universally.
