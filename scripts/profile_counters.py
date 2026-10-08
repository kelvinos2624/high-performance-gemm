#!/usr/bin/env python3
"""Capture raw macOS powermetrics alongside a gated, validated GEMM workload."""
import argparse
import csv
import hashlib
import io
import json
import os
import platform
import selectors
import subprocess
import time
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CASES = {
    'naive': ['--implementation', 'naive_ijk'],
    'ikj': ['--implementation', 'ikj'],
    'blocked': ['--implementation', 'blocked'],
    'micro4': ['--implementation', 'microkernel', '--mr', '4', '--nr', '4'],
    'unroll4': ['--implementation', 'microkernel', '--mr', '4', '--nr', '4', '--unroll', '4'],
    'static4': ['--implementation', 'parallel', '--threads', '4', '--schedule', 'static'],
    'static12': ['--implementation', 'parallel', '--threads', '12', '--schedule', 'static'],
    'dynamic12': ['--implementation', 'parallel', '--threads', '12', '--schedule', 'dynamic'],
}


def event(stream, expected, timeout):
    with selectors.DefaultSelector() as selector:
        selector.register(stream, selectors.EVENT_READ)
        if not selector.select(timeout):
            raise RuntimeError('Timed out waiting for ' + expected)
        line = stream.readline().strip()
    if line != expected:
        raise RuntimeError('Expected {}, received {!r}'.format(expected, line))
    return dict(event=expected, wall_time_ns=time.time_ns(), monotonic_ns=time.monotonic_ns())


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--binary', type=Path, default=ROOT / 'build/m8-release/gemm_benchmark')
    parser.add_argument('--output', type=Path, required=True, help='New directory; never overwrites results')
    parser.add_argument('--seconds', type=int, default=10)
    parser.add_argument('--size', type=int, default=512)
    parser.add_argument('--cases', nargs='+', choices=CASES, default=list(CASES))
    parser.add_argument('--reverse', action='store_true')
    parser.add_argument('--workload-only', action='store_true', help='Validation smoke test; NO hardware counters')
    args = parser.parse_args()
    if not 1 <= args.seconds <= 3600 or args.size <= 0:
        parser.error('Seconds must be 1..3600 and size must be positive')
    if not args.workload_only and args.seconds < 5:
        parser.error('Counter capture needs at least five seconds for interior samples')
    if not args.workload_only and platform.system() != 'Darwin':
        parser.error('This collector requires macOS powermetrics')
    if os.geteuid() == 0:
        parser.error('Run this script as your normal user, after sudo -v; only the collector needs root')
    if len(set(args.cases)) != len(args.cases):
        parser.error('Duplicate cases would overwrite artifacts')
    binary = args.binary.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    sources = [ROOT / 'CMakeLists.txt', ROOT / 'benchmarks/benchmark_main.cpp', Path(__file__).resolve(),
               *sorted(p for p in (ROOT / 'src').glob('*') if p.is_file()), *sorted((ROOT / 'include/gemm').glob('*.hpp'))]
    metadata = dict(status='started', utc=datetime.now(timezone.utc).isoformat(),
                    platform=platform.platform(), machine=platform.machine(),
                    mode='workload-only-no-counters' if args.workload_only else 'powermetrics',
                    binary=str(binary), binary_sha256=hashlib.sha256(binary.read_bytes()).hexdigest(),
                    source_sha256={str(p.relative_to(ROOT)): hashlib.sha256(p.read_bytes()).hexdigest()
                                   for p in sources}, cases=[])
    cc = binary.parent / 'compile_commands.json'
    if cc.exists():
        metadata['compile_commands'] = json.loads(cc.read_text())
    metadata_path = args.output / 'metadata.json'
    def save():
        metadata_path.write_text(json.dumps(metadata, indent=2) + '\n')
    save()
    try:
        if not args.workload_only:
            # BENCHMARK-IMPORTANT: Privilege/event availability is probed before
            # launching the workload. Failure never becomes a zero counter value.
            probe = subprocess.run(['sudo', '-n', '/usr/bin/powermetrics', '--samplers', 'tasks',
                                    '--show-process-ipc', '--show-process-amp', '-i', '1000', '-n', '1'],
                                   capture_output=True, timeout=15)
            (args.output / 'probe.txt').write_bytes(probe.stdout + probe.stderr)
            if probe.returncode:
                raise RuntimeError('powermetrics probe failed; see probe.txt. Authenticate with sudo -v in your terminal.')
        for name in reversed(args.cases) if args.reverse else args.cases:
            command = [str(binary), *CASES[name], '--profile-seconds', str(args.seconds),
                       '--profile-wait', str(args.size)]
            if name not in ('naive', 'ikj'):
                command += ['--bm', '32', '--bn', '128', '--bk', '32']
            record = dict(name=name, command=command, events=[], status='started')
            metadata['cases'].append(record)
            save()
            collector = None
            with (args.output / (name + '.csv')).open('w') as output, \
                 (args.output / (name + '.powermetrics.plist')).open('wb') as raw, \
                 (args.output / (name + '.collector.stderr')).open('wb') as errors:
                workload = subprocess.Popen(command, stdin=subprocess.PIPE, stdout=output,
                                            stderr=subprocess.PIPE, text=True)
                record['pid'] = workload.pid
                try:
                    record['events'].append(event(workload.stderr, 'PROFILE_READY', 120))
                    if not args.workload_only:
                        # BENCHMARK-IMPORTANT: Baseline sampling begins while the
                        # already-validated workload waits. Keep raw plist output;
                        # use only full intervals between GO and PROFILE_DONE,
                        # matched by PID. Never attribute system-wide counters to GEMM.
                        sampler = ['sudo', '-n', '/usr/bin/powermetrics', '--samplers', 'tasks',
                                   '--show-process-ipc', '--show-process-amp', '--format', 'plist',
                                   '-i', '1000', '-n', str(args.seconds + 4)]
                        record['collector_command'] = sampler
                        collector = subprocess.Popen(sampler, stdout=raw, stderr=errors)
                        time.sleep(1.2)
                        if collector.poll() is not None:
                            raise RuntimeError('Collector exited before workload start; inspect collector.stderr')
                    record['events'].append(dict(event='GO', wall_time_ns=time.time_ns(),
                                                 monotonic_ns=time.monotonic_ns()))
                    workload.stdin.write('GO\n')
                    workload.stdin.flush()
                    record['events'].append(event(workload.stderr, 'PROFILE_DONE', args.seconds + 120))
                    _, stderr = workload.communicate(timeout=120)
                    record['workload_stderr'] = stderr
                    if workload.returncode:
                        raise RuntimeError('Workload failed: ' + stderr)
                    if collector is not None and collector.wait(timeout=10):
                        raise RuntimeError('Collector failed; inspect collector.stderr')
                    record['status'] = 'workload-validated' if args.workload_only else 'captured-unreviewed'
                finally:
                    if workload.poll() is None:
                        workload.terminate()
                        workload.wait(timeout=10)
                    if collector is not None and collector.poll() is None:
                        collector.terminate()
                        collector.wait(timeout=10)
                    save()
            rows = list(csv.DictReader(io.StringIO((args.output / (name + '.csv')).read_text())))
            if len(rows) != 1 or int(rows[0]['calls']) <= 0:
                raise RuntimeError('Missing workload summary')
            print(name, record['status'], flush=True)
        metadata['status'] = 'workload-validated-no-counters' if args.workload_only else 'captured-unreviewed'
    except Exception as error:
        metadata['status'] = 'failed'
        metadata['error'] = str(error)
        raise
    finally:
        save()


if __name__ == '__main__':
    main()
