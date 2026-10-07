#!/usr/bin/env python3
"""Milestone 6: reproducible Clang build/assembly preparation and serial timing."""
import argparse
import csv
import hashlib
import io
import json
from pathlib import Path
import shlex
import subprocess

ROOT = Path(__file__).resolve().parents[1]
ARTIFACTS = ROOT / "results/compiler"
VARIANTS = {
    "O0": "-O0 -DNDEBUG",
    "O2": "-O2 -DNDEBUG",
    "O3": "-O3 -DNDEBUG",
    "O3-native": "-O3 -DNDEBUG",
    "O3-no-vector": "-O3 -DNDEBUG -fno-vectorize -fno-slp-vectorize",
}
SOURCES = ("gemm_naive.cpp", "gemm_loop_order.cpp", "gemm_blocked.cpp", "microkernel_tiles.cpp")
SHAPES = [(128, 128, 128), (256, 256, 256), (512, 512, 512), (127, 193, 129)]
KERNELS = ("naive_ijk", "ikj", "blocked", "microkernel")


def run(command, log=None, cwd=ROOT):
    result = subprocess.run(command, cwd=cwd, capture_output=True, text=True)
    if log:
        log.write_text(result.stdout + result.stderr)
    if result.returncode:
        raise RuntimeError(f"Command failed ({result.returncode}): {shlex.join(command)}\n"
                           + (f"See {log}" if log else result.stderr))
    return result.stdout


def prepare(args):
    compiler = run([args.compiler, "--version"])
    if "clang" not in compiler.lower():
        raise ValueError("This fixed experiment uses Clang-specific no-vector controls")
    ARTIFACTS.mkdir(parents=True, exist_ok=True)
    metadata = {"compiler": compiler, "variants": {}, "shapes": SHAPES,
                "kernels": KERNELS, "macro_tile": [32, 128, 32], "microtile": [4, 4],
                "unroll": 1, "repetitions": 5, "warmups": 1}
    for name, flags in VARIANTS.items():
        build = ROOT / "build/compiler" / name
        dest = ARTIFACTS / name
        dest.mkdir(parents=True, exist_ok=True)
        config = [args.cmake, "-S", str(ROOT), "-B", str(build),
                  "-DCMAKE_BUILD_TYPE=Release", "-DCMAKE_CXX_COMPILER=" + args.compiler,
                  "-DCMAKE_CXX_FLAGS_RELEASE=" + flags, "-DGEMM_VECTORIZATION_REPORTS=ON",
                  "-DGEMM_NATIVE_ARCH=" + ("ON" if name == "O3-native" else "OFF")]
        run(config, dest / "configure.txt")
        # BENCHMARK-IMPORTANT: Finish all builds/tests before any timing starts.
        # Clean builds ensure remark logs are regenerated on repeated preparation.
        run([args.cmake, "--build", str(build), "--clean-first", "--parallel"], dest / "build.txt")
        ctest = str(Path(args.cmake).with_name("ctest")) if "/" in args.cmake else "ctest"
        run([ctest, "--test-dir", str(build), "--output-on-failure"], dest / "tests.txt")
        commands = json.loads((build / "compile_commands.json").read_text())
        (dest / "compile_commands.json").write_text(json.dumps(commands, indent=2) + "\n")
        assembly_commands = []
        for source in SOURCES:
            entry = next(e for e in commands if Path(e["file"]).name == source)
            # Reuse the real kernel compile flags, only replacing object output
            # with assembly output. Do not assume the native flag or CPU target.
            command = shlex.split(entry["command"])
            output_index = command.index("-o")
            command[output_index + 1] = str(dest / (source + ".s"))
            command[command.index("-c")] = "-S"
            run(command, dest / (source + ".remarks.txt"), cwd=Path(entry["directory"]))
            assembly_commands.append(command)
        metadata["variants"][name] = {"configure": config, "assembly_commands": assembly_commands}
        print("Prepared and tested " + name, flush=True)
    files = [ROOT / "CMakeLists.txt"] + list((ROOT / "src").glob("*")) + list((ROOT / "include/gemm").glob("*"))
    files += list((ROOT / "benchmarks").glob("*.cpp")) + [Path(__file__).resolve()]
    metadata["source_sha256"] = {str(p.relative_to(ROOT)): hashlib.sha256(p.read_bytes()).hexdigest()
                                  for p in files if p.is_file()}
    (ARTIFACTS / "metadata.json").write_text(json.dumps(metadata, indent=2) + "\n")


def benchmark(args):
    if args.output is None:
        raise ValueError("Benchmark mode requires --output")
    metadata = json.loads((ARTIFACTS / "metadata.json").read_text())
    # BENCHMARK-IMPORTANT: Reject source edits after preparing binaries so the
    # reports, tests, and timing data refer to the same implementation.
    for name, digest in metadata["source_sha256"].items():
        if hashlib.sha256((ROOT / name).read_bytes()).hexdigest() != digest:
            raise ValueError("Source changed after preparation: " + name)
    cases = [(v, k) for v in VARIANTS for k in KERNELS]
    if args.reverse:
        cases.reverse()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("w", newline="") as output:
        writer = None
        # BENCHMARK-IMPORTANT: Serial fresh processes, fixed shapes and inputs,
        # same five-call median methodology, no simultaneous builds or benchmarks.
        for shape in SHAPES:
            for variant, kernel in cases:
                command = [str(ROOT / "build/compiler" / variant / "gemm_benchmark"),
                           "--implementation", kernel, "--repetitions", "5", "--shape", *map(str, shape)]
                if kernel in ("blocked", "microkernel"):
                    command += ["--bm", "32", "--bn", "128", "--bk", "32"]
                if kernel == "microkernel":
                    command += ["--mr", "4", "--nr", "4", "--unroll", "1"]
                rows = list(csv.DictReader(io.StringIO(run(command))))
                if len(rows) != 1:
                    raise ValueError("Expected one benchmark row")
                row = {"build": variant, **rows[0]}
                if writer is None:
                    writer = csv.DictWriter(output, fieldnames=list(row))
                    writer.writeheader()
                writer.writerow(row)
                output.flush()
            print("Measured " + str(shape), flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("mode", choices=("prepare", "benchmark"))
    parser.add_argument("--cmake", default="cmake")
    parser.add_argument("--compiler", default="/usr/bin/clang++")
    parser.add_argument("--output", type=Path)
    parser.add_argument("--reverse", action="store_true")
    args = parser.parse_args()
    if args.mode == "prepare":
        prepare(args)
    else:
        benchmark(args)


if __name__ == "__main__":
    main()
