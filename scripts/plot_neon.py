#!/usr/bin/env python3
"""Matched scalar/NEON throughput; primary and reversed order sweeps."""
import csv
from pathlib import Path
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[1]
runs = [list(csv.DictReader((ROOT/('results/raw/neon-'+r+'.csv')).open()))
        for r in ('primary','reverse')]
shapes = [(64,64,64),(256,256,256),(512,512,512),(1024,1024,1024),(255,513,257)]
names = ['ikj','blocked','microkernel','neon_4x4']
fig, ax = plt.subplots(figsize=(12,5))
for i, (name, color) in enumerate(zip(names,['#7c8b99','#4773a5','#c17f38','#299166'])):
    for r, rows in enumerate(runs):
        heights = [float(next(x['gflops'] for x in rows if x['implementation']==name and
                   tuple(int(x[k]) for k in ('M','N','K'))==shape)) for shape in shapes]
        x = [s-.35+i*.19+r*.075 for s in range(len(shapes))]
        ax.bar(x,heights,width=.073,color=color,alpha=1 if r==0 else .5,
               label=name+(' primary' if r==0 else ' reverse'))
ax.set_xticks(range(len(shapes)), ['64³','256³','512³','1024³','255×513×257'])
ax.set_ylabel('GFLOP/s (median of five calls)')
ax.set_title('NEON 4×4: matched single-thread GEMM on Apple M2 Pro\nBM/BN/BK = 32/128/32; full C=AB calls, shared scalar/NEON driver')
ax.grid(axis='y',alpha=.2)
ax.set_axisbelow(True)
ax.legend(ncol=4,fontsize=8,loc='upper center',bbox_to_anchor=(.5,-.12))
fig.tight_layout()
fig.savefig(ROOT/'results/plots/neon.png',dpi=150,bbox_inches='tight')
