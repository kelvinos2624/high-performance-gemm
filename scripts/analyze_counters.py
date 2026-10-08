#!/usr/bin/env python3
"""Analyze observed macOS powermetrics delta schema; retain PID-matched interior intervals."""
import argparse
import csv
from datetime import timezone
import hashlib
import json
import math
from pathlib import Path
import plistlib

ROOT = Path(__file__).resolve().parents[1]
FIELDS = ('cpu_instructions', 'cpu_cycles', 'pcpu_instructions', 'pcpu_cycles',
          'cputime_ns', 'ptime_ns', 'interval_ns')


def select_sample(sample, pid, go, done):
    if sample.get('is_delta') is not True or sample.get('invalid', False):
        raise ValueError('Invalid or non-delta sample')
    matches = [t for t in sample['tasks'] if t['pid'] == pid]
    if not matches:
        return None, 'target-absent'
    if len(matches) != 1:
        raise ValueError('Duplicate PID')
    task = matches[0]
    if task.get('invalid', False) or task['name'] != 'gemm_benchmark':
        raise ValueError('Invalid target task')
    for field in FIELDS:
        value = task[field]  # Missing fields are errors, never zero counters.
        if not isinstance(value, (int, float)) or not math.isfinite(value) or value < 0:
            raise ValueError('Invalid counter: ' + field)
    timestamp = sample['timestamp'].replace(tzinfo=timezone.utc).timestamp()
    duration = max(sample['elapsed_ns'], task['interval_ns']) / 1e9
    if not math.isfinite(duration) or duration <= 0:
        raise ValueError('Invalid interval')
    # BENCHMARK-IMPORTANT: plist timestamps have one-second resolution.
    # Expand by +/-1s (covers truncation or rounding), then require containment
    # inside GO/DONE with a further 100ms guard for userspace receipt boundaries.
    start_bound, end_bound = timestamp - 1 - duration, timestamp + 1
    if start_bound <= go + .1 or end_bound >= done - .1:
        return None, 'boundary-or-outside'
    if task['cpu_cycles'] <= 0 or task['pcpu_cycles'] <= 0 or task['interval_ns'] <= 0:
        raise ValueError('No usable cycles/interval')
    return dict(timestamp_utc=sample['timestamp'].isoformat() + 'Z',
                start_bound_epoch=start_bound, end_bound_epoch=end_bound,
                **{field: task[field] for field in FIELDS}), 'selected'


def analyze(directory):
    meta = json.loads((directory / 'metadata.json').read_text())
    if meta['status'] != 'captured-unreviewed' or meta['mode'] != 'powermetrics':
        raise ValueError('Not a completed counter capture')
    result = dict(capture=str(directory), binary_sha256=meta['binary_sha256'],
                  source_sha256=meta['source_sha256'], cases=[])
    for case in meta['cases']:
        if case['status'] != 'captured-unreviewed' or case['workload_stderr']:
            raise ValueError('Unsuccessful workload')
        name = case['name']
        diagnostics = (directory / (name + '.collector.stderr')).read_text().splitlines()
        # This observed warning has no PID/timestamp. Preserve and flag the
        # entire case as provisional; consistency checks cannot prove it harmless.
        if any(line != 'Second underflow occured.' for line in diagnostics):
            raise ValueError('Unrecognized collector diagnostic requires review')
        events = {e['event']: e for e in case['events']}
        go, done = [events[k]['wall_time_ns'] / 1e9 for k in ('GO', 'PROFILE_DONE')]
        mono = (events['PROFILE_DONE']['monotonic_ns'] - events['GO']['monotonic_ns']) / 1e9
        if abs((done - go) - mono) > .01:
            raise ValueError('Wall/monotonic clock mismatch')
        raw = (directory / (name + '.powermetrics.plist')).read_bytes()
        samples = [plistlib.loads(b) for b in raw.split(b'\0') if b.strip()]
        selected, exclusions = [], {}
        previous = None
        for index, sample in enumerate(samples):
            if previous is not None and sample['timestamp'] <= previous:
                raise ValueError('Non-increasing sample timestamps')
            previous = sample['timestamp']
            row, reason = select_sample(sample, case['pid'], go, done)
            if row is None:
                exclusions[reason] = exclusions.get(reason, 0) + 1
            else:
                selected.append(dict(sample_index=index, **row))
        if len(selected) < 3:
            raise ValueError('Too few interior samples')
        sums = {f: sum(s[f] for s in selected) for f in FIELDS}
        # BENCHMARK-IMPORTANT: IPC is a ratio of summed counts, not an average
        # of ratios. CPU-equivalents use matching task CPU and interval times.
        ipc = sums['cpu_instructions'] / sums['cpu_cycles']
        workload, = csv.DictReader((directory / (name + '.csv')).open())
        expected_gflops = 2 * int(workload['M']) * int(workload['N']) * int(workload['K']) * int(workload['calls']) / float(workload['seconds']) / 1e9
        if not math.isclose(expected_gflops, float(workload['average_gflops']), rel_tol=1e-9):
            raise ValueError('Workload accounting mismatch')
        result['cases'].append(dict(name=name, pid=case['pid'], samples=len(selected),
            quality='provisional-collector-warning' if diagnostics else 'checked', diagnostics=diagnostics,
            exclusions=exclusions, sums=sums, ipc=ipc,
            sample_ipc_min=min(s['cpu_instructions']/s['cpu_cycles'] for s in selected),
            sample_ipc_max=max(s['cpu_instructions']/s['cpu_cycles'] for s in selected),
            performance_core_ipc=sums['pcpu_instructions']/sums['pcpu_cycles'],
            cpu_equivalents=sums['cputime_ns']/sums['interval_ns'],
            performance_core_time_fraction=sums['ptime_ns']/sums['cputime_ns'],
            workload=workload, raw_sha256=hashlib.sha256(raw).hexdigest(), selected=selected))
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('captures', nargs='+', type=Path)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    runs = [analyze(p) for p in args.captures]
    if any((r['binary_sha256'], r['source_sha256']) !=
           (runs[0]['binary_sha256'], runs[0]['source_sha256']) for r in runs):
        raise ValueError('Build/source mismatch across captures')
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(dict(schema='powermetrics-delta-v1',
        analyzer_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        timestamp_uncertainty_seconds=1, boundary_guard_seconds=.1,
        note='IPC and CPU accounting use interior samples. GFLOP/s uses the full sustained loop; no instructions/FLOP computed.',
        runs=runs), indent=2) + '\n')
    for run in runs:
        print(run['capture'])
        for c in run['cases']:
            print('{}: n={} IPC={:.3f} [{:.3f}, {:.3f}] CPUs={:.2f} P-time={:.1%} ({})'.format(
                c['name'], c['samples'], c['ipc'], c['sample_ipc_min'], c['sample_ipc_max'],
                c['cpu_equivalents'], c['performance_core_time_fraction'], c['quality']))


if __name__ == '__main__':
    main()
