#!/usr/bin/env python3
"""Reproduce assembly from the actual build commands and summarize tile bodies."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import shlex
import subprocess


def body(text, symbol):
    start = next(m.start() for m in re.finditer(r'^__ZN[^\n]+:', text, re.M) if symbol in m.group())
    return text[start:text.index('.cfi_endproc', start)]


def instructions(text):
    return [line.split(';')[0].strip() for line in text.splitlines()
            if line.startswith('\t') and not line.lstrip().startswith('.')]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--build', type=Path, default=Path('build/neon-release'))
    parser.add_argument('--output', type=Path, default=Path('results/assembly/neon'))
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    sources = ('microkernel_neon', 'microkernel_tiles', 'gemm_microkernel', 'microkernel_driver', 'gemm_blocked')
    commands = []
    for entry in json.loads((args.build/'compile_commands.json').read_text()):
        stem = Path(entry['file']).stem
        if stem not in sources:
            continue
        # COMPILER-IMPORTANT: Preserve real target/optimization/definition flags;
        # only replace object output with assembly emission. No forced inlining.
        cmd = shlex.split(entry['command'])
        cmd[cmd.index('-c')] = '-S'
        cmd[cmd.index('-o')+1] = str((args.output/(stem+'.s')).resolve())
        subprocess.run(cmd, cwd=entry['directory'], check=True)
        commands.append(cmd)
    (args.output/'commands.json').write_text(json.dumps(commands, indent=2)+'\n')
    summary = {}
    for name, file, symbol in [('neon','microkernel_neon','13tile_4x4_neon'),
                                ('scalar','microkernel_tiles','8tile_4x4E')]:
        text = body((args.output/(file+'.s')).read_text(), symbol)
        loop = text[text.index('LBB1_2:'):text.index('LBB1_3:')]
        ops = instructions(loop)
        summary[name] = dict(loop_instructions=len(ops),
            scalar_fma=sum(x.startswith('fmadd') for x in ops),
            vector_fma=sum(x.startswith('fmla.4s') for x in ops),
            loop_stack_references=[x for x in ops if re.search(r'\bsp\b',x)],
            loop_calls=[x for x in ops if re.match(r'bl\s|blr\s',x)],
            body_sha256=hashlib.sha256('\n'.join(instructions(text)).encode()).hexdigest())
    summary['interpretation'] = 'Static assembly counts on the recorded Apple Clang ARM64 build; not dynamic PMU counts. Inspect raw assembly to verify accumulator lifetime and driver dispatch.'
    (args.output/'summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary,indent=2))


if __name__ == '__main__':
    main()
