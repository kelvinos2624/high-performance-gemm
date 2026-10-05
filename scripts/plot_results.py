#!/usr/bin/env python3
"""Plot a complete six-order square-size benchmark CSV (requires matplotlib)."""

import argparse
import csv
import math
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("csv", type=Path)
    parser.add_argument("--output", type=Path, default=Path("results/plots/loop-orders.png"))
    args = parser.parse_args()
    orders = ("naive_ijk", "ikj", "jik", "jki", "kij", "kji")
    series = {name: {} for name in orders}
    with args.csv.open(newline="") as source:
        for row in csv.DictReader(source):
            name, size = row["implementation"], int(row["M"])
            throughput = float(row["gflops"])
            if name not in series or size != int(row["N"]) or size != int(row["K"]):
                raise ValueError("Expected six known loop orders and square matrices")
            if size <= 0 or not math.isfinite(throughput) or throughput <= 0:
                raise ValueError("Size and throughput must be positive and finite")
            if size in series[name]:
                raise ValueError("Duplicate implementation/size; select a single sweep")
            series[name][size] = throughput
    sizes = sorted(series["naive_ijk"])
    if not sizes or any(sorted(values) != sizes for values in series.values()):
        raise ValueError("Every loop order must have the same nonempty size set")

    fig, ax = plt.subplots(figsize=(9, 5.5), constrained_layout=True)
    for name, marker in zip(orders, ("o", "s", "^", "D", "v", "X")):
        ax.plot(sizes, [series[name][size] for size in sizes],
                marker=marker, linewidth=2, label=name)
    ax.set_xscale("log", base=2)
    ax.set_yscale("log")
    ax.set_xticks(sizes, [str(size) for size in sizes])
    ax.set_xlabel("Square dimension (M = N = K)")
    ax.set_ylabel("GFLOP/s from median latency (log scale; higher is better)")
    ax.set_title("GEMM loop-order comparison")
    ax.grid(True, which="both", alpha=0.2)
    ax.legend(ncol=3)
    fig.supxlabel("Source: " + args.csv.name, fontsize=8)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(args.output, dpi=180)
    plt.close(fig)
    print(args.output)


if __name__ == "__main__":
    main()
