#!/usr/bin/env python3
"""Plot repeated throughput and speedup over the matching serial blocked run."""
import csv
from pathlib import Path
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[1]
RUNS = [list(csv.DictReader((ROOT / ('results/raw/parallel-' + name + '.csv')).open()))
        for name in ('primary', 'reverse')]
SHAPES = [(128,128,128), (512,512,512), (1024,1024,1024), (255,513,257), (16,1024,512)]
fig, axes = plt.subplots(2, 5, figsize=(17, 7), squeeze=False)
for col, shape in enumerate(SHAPES):
    for run, style, name in zip(RUNS, ('-', '--'), ('primary', 'reverse')):
        rows = [r for r in run if tuple(int(r[k]) for k in ('M','N','K')) == shape]
        baseline = float(next(r['gflops'] for r in rows if r['implementation'] == 'blocked'))
        for schedule, color in (('static', '#2463a6'), ('dynamic', '#c75722')):
            chosen = sorted((r for r in rows if r['schedule'] == schedule),
                            key=lambda r: int(r['requested_threads']))
            x = [int(r['requested_threads']) for r in chosen]
            y = [float(r['gflops']) for r in chosen]
            axes[0,col].plot(x, y, style, color=color, marker='o', label=schedule + ' ' + name)
            axes[1,col].plot(x, [v/baseline for v in y], style, color=color, marker='o')
    axes[0,col].set_title('{} × {} × {}\nworker cap: {}'.format(*shape, min(12, (shape[0]+31)//32)))
    axes[1,col].axhline(1, color='gray', linewidth=1)
    for ax in axes[:,col]:
        ax.grid(alpha=.2)
        ax.set_xticks([1,2,4,8,12])
        ax.set_ylim(bottom=0)
    axes[1,col].set_xlabel('Requested workers')
axes[0,0].set_ylabel('GFLOP/s')
axes[1,0].set_ylabel('Speedup over serial blocked')
axes[0,0].legend(fontsize=8)
fig.suptitle('Milestone 7: whole-call multicore scaling on Apple M2 Pro\nBM/BN/BK = 32/128/32; five repetitions per median; 16-row case capped at one worker')
fig.tight_layout(rect=(0,0,1,.92))
output = ROOT / 'results/plots/parallel.png'
fig.savefig(output, dpi=150)
print(output)
