#!/usr/bin/env python3
"""Fixed Milestone 4 experiment; does not select or tune runtime defaults."""
import argparse
import csv
import io
from pathlib import Path
import subprocess

SHAPES = [(256, 256, 256), (512, 512, 512), (1024, 1024, 1024), (255, 513, 257)]
MICROTILES = [(2,4), (4,4), (4,8), (8,4), (8,8), (16,16)]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--executable", type=Path, default=Path("build/release/gemm_benchmark"))
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--repetitions", type=int, default=5)
    parser.add_argument("--reverse", action="store_true")
    args = parser.parse_args()
    if args.repetitions <= 0:
        parser.error("Repetitions must be positive")
    cases = [("ikj", None), ("blocked", None)] + [("microkernel", t) for t in MICROTILES]
    if args.reverse:
        cases.reverse()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("w", newline="") as output:
        writer = None
        # BENCHMARK-IMPORTANT: Serial runs avoid competing benchmark processes.
        # Each case gets a fresh process, deterministic inputs and a validated warmup.
        for shape in SHAPES:
            for name, microtile in cases:
                command = [str(args.executable.resolve()), "--repetitions", str(args.repetitions),
                           "--implementation", name,
                           "--shape", *map(str, shape)]
                if name != "ikj":
                    command += ["--bm", "32", "--bn", "128", "--bk", "32"]
                if microtile:
                    command += ["--mr", str(microtile[0]), "--nr", str(microtile[1])]
                result = subprocess.run(command, capture_output=True, text=True, check=True)
                reader = csv.DictReader(io.StringIO(result.stdout))
                rows = list(reader)
                if len(rows) != 1:
                    raise ValueError("Expected exactly one benchmark row")
                if writer is None:
                    writer = csv.DictWriter(output, fieldnames=reader.fieldnames)
                    writer.writeheader()
                writer.writerows(rows)
                output.flush()
    print(args.output)


if __name__ == "__main__":
    main()
