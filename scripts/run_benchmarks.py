#!/usr/bin/env python3
"""Run a square-size sweep, optionally reversing implementation order."""

import argparse
import csv
import io
from pathlib import Path
import subprocess


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--executable", type=Path, default=Path("build/release/gemm_benchmark"))
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--repetitions", type=int, default=5)
    parser.add_argument("--reverse", action="store_true")
    parser.add_argument("sizes", type=int, nargs="*", default=[64, 128, 256, 512, 1024])
    args = parser.parse_args()
    if args.repetitions <= 0 or any(size <= 0 for size in args.sizes):
        parser.error("Sizes and repetitions must be positive")
    orders = ["naive_ijk", "ikj", "jik", "jki", "kij", "kji"]
    if args.reverse:
        orders.reverse()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("w", newline="") as output:
        writer = None
        # BENCHMARK-IMPORTANT: Launch sequentially, never concurrently. Each
        # process performs its own untimed setup/validation/warmup before timing.
        for size in args.sizes:
            for name in orders:
                result = subprocess.run(
                    [str(args.executable.resolve()), "--implementation", name,
                     "--repetitions", str(args.repetitions), str(size)],
                    capture_output=True, text=True, check=True)
                reader = csv.DictReader(io.StringIO(result.stdout))
                rows = list(reader)
                if len(rows) != 1 or rows[0]["implementation"] != name:
                    raise ValueError("Expected one CSV row for " + name)
                if writer is None:
                    writer = csv.DictWriter(output, fieldnames=reader.fieldnames)
                    writer.writeheader()
                writer.writerows(rows)
                output.flush()
    print(args.output)


if __name__ == "__main__":
    main()
