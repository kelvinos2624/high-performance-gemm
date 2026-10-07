#!/usr/bin/env python3
"""Plot one compiler sweep's 512-cubed results; requires matplotlib."""
import argparse
import csv
from pathlib import Path
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("csv", type=Path)
    parser.add_argument("--output", type=Path, default=Path("results/plots/compiler.png"))
    args = parser.parse_args()
    with args.csv.open() as source:
        rows = [r for r in csv.DictReader(source) if (r["M"], r["N"], r["K"]) == ("512", "512", "512")]
    data = {(r["build"], r["implementation"]): float(r["gflops"]) for r in rows}
    builds = ["O0", "O2", "O3", "O3-native", "O3-no-vector"]
    kernels = ["naive_ijk", "ikj", "blocked", "microkernel"]
    if len(rows) != 20 or set(data) != {(b, k) for b in builds for k in kernels}:
        raise ValueError("Expected one row per build/kernel at 512 cubed")
    fig, ax = plt.subplots(figsize=(10, 6), constrained_layout=True)
    for index, build in enumerate(builds):
        xs = [i + (index - 2) * 0.16 for i in range(len(kernels))]
        bars = ax.bar(xs, [data[build, k] for k in kernels], width=0.15, label=build)
        ax.bar_label(bars, fmt="%.1f", fontsize=8, padding=3)
    ax.set_xticks(range(len(kernels)), ["naive ijk", "ikj", "blocked 32×128×32", "microkernel 4×4"])
    ax.set_yscale("log")
    ax.set_ylim(0.3, max(data.values()) * 2.5)
    ax.set_ylabel("GFLOP/s from median time (log scale)")
    ax.set_title("Compiler experiment — 512³ GEMM\nSame source; different compiler settings")
    ax.legend(ncol=3, loc="upper left")
    ax.grid(axis="y", alpha=0.2)
    fig.supxlabel(args.csv.name, fontsize=8)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(args.output, dpi=170)
    plt.close(fig)
    print(args.output)


if __name__ == "__main__":
    main()
