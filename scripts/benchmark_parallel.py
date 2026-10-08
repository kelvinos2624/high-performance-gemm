#!/usr/bin/env python3
"""Serial scaling sweep; each subprocess validates against the double reference."""
import argparse
import csv
import hashlib
import io
import json
import platform
import subprocess
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--binary', type=Path, default=ROOT / 'build/m7-release/gemm_benchmark')
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--reverse', action='store_true')
    args = parser.parse_args()
    binary = args.binary.resolve()
    cases = [('blocked', 1, 'none'), ('ikj', 1, 'none')]
    cases += [('parallel', t, s) for s in ('static', 'dynamic') for t in (1, 2, 4, 8, 12)]
    if args.reverse:
        cases.reverse()
    commands = []
    rows = []
    # BENCHMARK-IMPORTANT: Same macrotiles/compiler for serial and parallel.
    # Whole-call timing includes thread startup/join, allocation and C zeroing.
    # Sweep sequentially: running benchmarks concurrently would confound scaling.
    for shape in ((128,128,128), (512,512,512), (1024,1024,1024),
                  (255,513,257), (16,1024,512)):
        for kernel, threads, schedule in cases:
            command = [str(binary), '--implementation', kernel, '--shape', *map(str, shape),
                       '--repetitions', '5']
            if kernel != 'ikj':
                command += ['--bm', '32', '--bn', '128', '--bk', '32']
            if kernel == 'parallel':
                command += ['--threads', str(threads), '--schedule', schedule]
            commands.append(command)
            row = list(csv.DictReader(io.StringIO(subprocess.check_output(command, text=True))))
            assert len(row) == 1
            rows.extend(row)
            print(shape, kernel, threads, schedule, row[0]['gflops'], flush=True)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open('w') as f:
        writer = csv.DictWriter(f, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)
    sources = [ROOT / 'CMakeLists.txt', Path(__file__).resolve(), *sorted((ROOT / 'src').glob('*')),
               *sorted((ROOT / 'include/gemm').glob('*')), ROOT / 'benchmarks/benchmark_main.cpp']
    metadata = dict(utc=datetime.now(timezone.utc).isoformat(), platform=platform.platform(),
                    machine=platform.machine(), commands=commands,
                    binary_sha256=hashlib.sha256(binary.read_bytes()).hexdigest(),
                    source_sha256={str(p.relative_to(ROOT)): hashlib.sha256(p.read_bytes()).hexdigest()
                                   for p in sources},
                    notes='No affinity/QoS control; OS chooses cores. Caller participates. Median of five timed calls per case; one warmup.')
    compile_commands = binary.parent / 'compile_commands.json'
    if compile_commands.exists():
        metadata['compile_commands'] = json.loads(compile_commands.read_text())
    metadata['compiler'] = subprocess.check_output(['/usr/bin/c++', '--version'], text=True)
    args.output.with_suffix('.metadata.json').write_text(json.dumps(metadata, indent=2) + '\n')


if __name__ == '__main__':
    main()
