#!/usr/bin/env python3
"""Plot measured unrolled/original 4x4 speedups; requires matplotlib and numpy."""
import argparse
import csv
from pathlib import Path
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.colors import TwoSlopeNorm
import numpy as np


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("csv", type=Path)
    parser.add_argument("--output", type=Path, default=Path("results/plots/unroll.png"))
    args = parser.parse_args()
    with args.csv.open() as source:
        rows = list(csv.DictReader(source))
    baseline, blocked, shapes, tiles = {}, {}, [], []
    for row in rows:
        shape = tuple(int(row[key]) for key in ("M", "N", "K"))
        tile = (int(row["unroll"]),)
        time = float(row["time_ms"])
        if not np.isfinite(time) or time <= 0:
            raise ValueError("Times must be finite and positive")
        if shape not in shapes:
            shapes.append(shape)
        if row["implementation"] in ("ikj", "blocked"):
            continue
        if row["implementation"] == "microkernel" and tile == (1,):
            if shape in baseline:
                raise ValueError("Duplicate baseline")
            baseline[shape] = time
        elif row["implementation"] == "microkernel":
            if (shape, tile) in blocked:
                raise ValueError("Duplicate blocked case")
            blocked[shape, tile] = time
            if tile not in tiles:
                tiles.append(tile)
        else:
            raise ValueError("Expected ikj, blocked, and microkernel rows")
    if not shapes or not tiles:
        raise ValueError("No measurements")
    ratios = np.array([[baseline[shape] / blocked[shape, tile] for shape in shapes] for tile in tiles])
    fig, ax = plt.subplots(figsize=(9, 7), constrained_layout=True)
    norm = TwoSlopeNorm(vmin=min(0.9, ratios.min()), vcenter=1, vmax=max(1.1, ratios.max()))
    plot = ax.imshow(ratios, cmap="RdYlGn", norm=norm, aspect="auto")
    ax.set_xticks(range(len(shapes)), ["×".join(map(str, shape)) for shape in shapes])
    ax.set_yticks(range(len(tiles)), ["×".join(map(str, tile)) for tile in tiles])
    for i in range(len(tiles)):
        for j in range(len(shapes)):
            ax.text(j, i, f"{ratios[i,j]:.2f}×", ha="center", va="center", color="black")
    ax.set_xlabel("Matrix shape M × N × K")
    ax.set_ylabel("K-loop unroll factor")
    ax.set_title("K-loop unrolling: speedup over original 4×4\n1× = equal; below 1× = slower")
    fig.colorbar(plot, ax=ax, label="factor-1 median time / unrolled median time")
    fig.supxlabel(args.csv.name, fontsize=8)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(args.output, dpi=170)
    plt.close(fig)
    print(args.output)


if __name__ == "__main__":
    main()
