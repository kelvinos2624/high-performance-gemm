#!/usr/bin/env python3
"""Matched single-thread scalar/NEON experiment; no automatic tuning."""
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
SHAPES = [(64,64,64), (256,256,256), (512,512,512), (1024,1024,1024),
          (255,513,257), (3,5,257)]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--binary', type=Path, default=ROOT/'build/neon-release/gemm_benchmark')
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--reverse', action='store_true')
    args = parser.parse_args()
    binary = args.binary.resolve()
    sources = [ROOT/'CMakeLists.txt', ROOT/'benchmarks/benchmark_main.cpp', Path(__file__).resolve(),
               *sorted(p for p in (ROOT/'src').glob('*') if p.is_file()),
               *sorted((ROOT/'include/gemm').glob('*.hpp'))]
    meta = dict(status='running', utc=datetime.now(timezone.utc).isoformat(),
                platform=platform.platform(), binary_sha256=hashlib.sha256(binary.read_bytes()).hexdigest(),
                source_sha256={str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest() for p in sources},
                compile_commands=json.loads((binary.parent/'compile_commands.json').read_text()),
                compiler=subprocess.check_output(['/usr/bin/c++','--version'],text=True),
                note='One thread, BM/BN/BK=32/128/32, MR/NR=4/4, unroll=1. No affinity control.', commands=[])
    args.output.parent.mkdir(parents=True,exist_ok=True)
    cases = ['ikj','blocked','microkernel','neon_4x4']
    if args.reverse:
        cases.reverse()
    with args.output.open('x') as output:
        try:
            writer = None
            # BENCHMARK-IMPORTANT: Run cases serially with matched settings and
            # reference-validated warmups; retain zeroing/dispatch in timed calls.
            for shape in SHAPES:
                for name in cases:
                    command = [str(binary),'--implementation',name,'--shape',*map(str,shape),'--repetitions','5']
                    if name != 'ikj':
                        command += ['--bm','32','--bn','128','--bk','32']
                    if name == 'microkernel':
                        command += ['--mr','4','--nr','4','--unroll','1']
                    meta['commands'].append(command)
                    row, = csv.DictReader(io.StringIO(subprocess.check_output(command,text=True)))
                    if writer is None:
                        writer = csv.DictWriter(output, fieldnames=list(row))
                        writer.writeheader()
                    writer.writerow(row)
                    output.flush()
                    print(shape,name,row['gflops'],flush=True)
            meta['status'] = 'complete'
        finally:
            args.output.with_suffix('.metadata.json').write_text(json.dumps(meta,indent=2)+'\n')


if __name__ == '__main__':
    main()
