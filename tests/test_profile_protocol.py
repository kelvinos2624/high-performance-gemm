#!/usr/bin/env python3
"""Integration checks for profiling boundaries and ordinary benchmark compatibility."""
import csv
import io
import selectors
import subprocess
import sys
from pathlib import Path

binary = str(Path(sys.argv[1] if len(sys.argv) > 1 else 'build/m8-release/gemm_benchmark').resolve())
base = [binary, '--implementation', 'blocked', '--profile-seconds', '1', '--profile-wait', '17']
p = subprocess.Popen(base, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                     stderr=subprocess.PIPE, text=True)
try:
    with selectors.DefaultSelector() as sel:
        sel.register(p.stderr, selectors.EVENT_READ)
        assert sel.select(10), 'Readiness timeout'
        assert p.stderr.readline().strip() == 'PROFILE_READY'
        assert not sel.select(.2), 'Work started before GO'
    assert p.poll() is None
    out, err = p.communicate('GO\n', timeout=10)
    assert p.returncode == 0 and err.strip() == 'PROFILE_DONE'
    row, = csv.DictReader(io.StringIO(out))
    assert int(row['calls']) > 0 and float(row['seconds']) >= 1
    assert float(row['average_gflops']) > 0 and row['threads'] == '1'
finally:
    if p.poll() is None:
        p.kill()
        p.wait()

p = subprocess.run(base, input='WRONG\n', capture_output=True, text=True, timeout=10)
assert p.returncode == 1 and 'requires GO' in p.stderr and 'PROFILE_DONE' not in p.stderr
for args in (['--profile-wait'], ['--profile-seconds','1'],
             ['--implementation','ikj','--profile-seconds','1','16','32'],
             ['--implementation','ikj','--profile-seconds','0','16']):
    p = subprocess.run([binary]+args, capture_output=True, text=True, timeout=10)
    assert p.returncode == 1 and 'Error:' in p.stderr
p = subprocess.run([binary,'--implementation','ikj','--repetitions','2','17'],
                   capture_output=True,text=True,timeout=10)
assert p.returncode == 0 and not p.stderr
row, = csv.DictReader(io.StringIO(p.stdout))
assert row['repetitions'] == '2' and 'time_ms' in row and 'average_gflops' not in row
print('Profile gating, final validation, error paths, and legacy CSV checks passed')
