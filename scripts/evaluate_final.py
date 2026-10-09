#!/usr/bin/env python3
"""Closure experiment: matched existing kernels and optional Accelerate; no tuning."""
import argparse
import csv
import hashlib
import io
import json
import os
import platform
import subprocess
from datetime import datetime, timezone
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
SHAPES=[(256,256,256),(512,512,512),(1024,1024,1024),(255,513,257),(16,1024,512)]
CASES=[('naive','naive_ijk',[],None),('ikj','ikj',[],None),
       ('blocked','blocked',[],None),
       ('scalar4','microkernel',['--mr','4','--nr','4','--unroll','1'],None),
       ('unroll4','microkernel',['--mr','4','--nr','4','--unroll','4'],None),
       ('neon4','neon_4x4',[],None),
       ('static12','parallel',['--threads','12','--schedule','static'],None),
       ('dynamic12','parallel',['--threads','12','--schedule','dynamic'],None),
       ('accelerate_limit1','accelerate',[],'1'),('accelerate_default','accelerate',[],None)]


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--binary',type=Path,default=ROOT/'build/final-release/gemm_benchmark')
    parser.add_argument('--output',type=Path,required=True)
    parser.add_argument('--reverse',action='store_true')
    args=parser.parse_args()
    binary=args.binary.resolve()
    sources=[ROOT/'CMakeLists.txt',Path(__file__).resolve(),
             *sorted(p for d in ('src','include/gemm','benchmarks') for p in (ROOT/d).glob('*') if p.is_file())]
    meta=dict(status='running',utc=datetime.now(timezone.utc).isoformat(),platform=platform.platform(),
              compiler=subprocess.check_output(['/usr/bin/c++','--version'],text=True),
              binary_sha256=hashlib.sha256(binary.read_bytes()).hexdigest(),
              source_sha256={str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest() for p in sources},
              compile_commands=json.loads((binary.parent/'compile_commands.json').read_text()),
              link_command=(binary.parent/'CMakeFiles/gemm_benchmark.dir/link.txt').read_text(),
              note='C=AB, seven repetitions, one warmup, fixed seeds. Accelerate actual workers unknown; environment limit is a request. No packing/threading changes to project kernels.',cases=[])
    args.output.parent.mkdir(parents=True,exist_ok=True)
    with args.output.open('x') as output:
        try:
            writer=None
            # BENCHMARK-IMPORTANT: One fresh process at a time; identical harness
            # and build. Explicitly clear inherited vecLib policy before each run.
            for shape in SHAPES:
                for label,kernel,options,limit in (list(reversed(CASES)) if args.reverse else CASES):
                    env=os.environ.copy()
                    env.pop('VECLIB_MAXIMUM_THREADS',None)
                    if limit is not None: env['VECLIB_MAXIMUM_THREADS']=limit
                    command=[str(binary),'--implementation',kernel,'--shape',*map(str,shape),'--repetitions','7',*options]
                    if kernel in ('blocked','microkernel','neon_4x4','parallel'):
                        command+=['--bm','32','--bn','128','--bk','32']
                    meta['cases'].append(dict(label=label,command=command,VECLIB_MAXIMUM_THREADS=limit))
                    row,=csv.DictReader(io.StringIO(subprocess.check_output(command,env=env,text=True)))
                    row=dict(case=label,blas_thread_policy=('limit1-requested' if limit else 'default') if kernel=='accelerate' else 'not-applicable',**row)
                    if writer is None:
                        writer=csv.DictWriter(output,fieldnames=list(row));writer.writeheader()
                    writer.writerow(row);output.flush()
                    print(shape,label,row['gflops'],flush=True)
            meta['status']='complete'
        finally:
            args.output.with_suffix('.metadata.json').write_text(json.dumps(meta,indent=2)+'\n')


if __name__=='__main__': main()
