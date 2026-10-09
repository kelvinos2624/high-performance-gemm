#!/usr/bin/env python3
"""Validate matched final sweeps, summarize ratios, and render progression figures."""
import csv
import hashlib
import json
import math
from pathlib import Path
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

ROOT=Path(__file__).resolve().parents[1]
NAMES=['naive','ikj','blocked','scalar4','unroll4','neon4','static12','dynamic12','accelerate_limit1','accelerate_default']
LABELS=['Naive ijk','Loop order: ikj','Cache blocked','Scalar 4×4','Scalar 4×4, unroll 4',
        'NEON 4×4','Blocked, static 12 workers','Blocked, dynamic 12 workers',
        'Accelerate: limit 1 requested','Accelerate: default policy']
SHAPES=[(256,256,256),(512,512,512),(1024,1024,1024),(255,513,257),(16,1024,512)]


def main():
    runs=[]
    metas=[]
    for run in ('primary','reverse'):
        path=ROOT/('results/raw/final-'+run+'.csv')
        rows=list(csv.DictReader(path.open()))
        meta=json.loads(path.with_suffix('.metadata.json').read_text())
        assert meta['status']=='complete' and len(rows)==50 and len(meta['cases'])==50
        data={}
        for row in rows:
            shape=tuple(int(row[k]) for k in ('M','N','K'))
            key=(shape,row['case'])
            assert key not in data and shape in SHAPES and row['case'] in NAMES
            assert row['repetitions']=='7' and row['warmups']=='1' and row['seed_A']=='42' and row['seed_B']=='43'
            value=float(row['gflops']); milliseconds=float(row['time_ms'])
            assert value>0 and math.isfinite(value) and math.isfinite(float(row['checksum']))
            assert math.isclose(value,2*math.prod(shape)/milliseconds/1e6,rel_tol=1e-9)
            if row['implementation']=='accelerate': assert row['threads']=='0'
            data[key]=row
        assert set(data)=={(s,n) for s in SHAPES for n in NAMES}
        runs.append(data);metas.append(meta)
    assert metas[0]['binary_sha256']==metas[1]['binary_sha256']
    assert metas[0]['source_sha256']==metas[1]['source_sha256']
    # BENCHMARK-IMPORTANT: Ratios use baselines from the same sweep/shape.
    # The two sweep medians form an observed range, not a confidence interval.
    report=[]
    for shape in SHAPES:
        cases={}
        for name in NAMES:
            values=[float(r[(shape,name)]['gflops']) for r in runs]
            cases[name]=dict(gflops=values,
                speedup_over_naive=[v/float(r[(shape,'naive')]['gflops']) for v,r in zip(values,runs)],
                percent_accelerate_default=[100*v/float(r[(shape,'accelerate_default')]['gflops']) for v,r in zip(values,runs)],
                percent_accelerate_limit1=[100*v/float(r[(shape,'accelerate_limit1')]['gflops']) for v,r in zip(values,runs)])
        report.append(dict(shape=shape,cases=cases))
    (ROOT/'results/final-summary.json').write_text(json.dumps(dict(
        note='All ranges are two observed sweep medians. Accelerate workers unknown. Parallel path is blocked, not NEON.',
        csv_sha256={r:hashlib.sha256((ROOT/('results/raw/final-'+r+'.csv')).read_bytes()).hexdigest() for r in ('primary','reverse')},
        results=report),indent=2)+'\n')
    fig,axes=plt.subplots(1,2,figsize=(14,7),sharey=True)
    colors=['#778899']*5+['#249775','#426bb2','#426bb2','#9b649f','#9b649f']
    for ax,shape in zip(axes,[(512,512,512),(1024,1024,1024)]):
        for index,run in enumerate(runs):
            values=[float(run[(shape,n)]['gflops']) for n in NAMES]
            ys=[i+(-.17 if index==0 else .17) for i in range(len(NAMES))]
            ax.barh(ys,values,height=.3,color=colors,alpha=1 if index==0 else .5,
                    label='Primary sweep' if index==0 else 'Reverse sweep')
            for y,v in zip(ys,values):ax.text(v*1.04,y,f'{v:.1f}',va='center',fontsize=7)
        ax.set_xscale('log');ax.set_xlim(.9,10000)
        ax.set_title(f'{shape[0]}³, float C = AB');ax.set_xlabel('GFLOP/s — logarithmic scale')
        ax.grid(axis='x',alpha=.2);ax.set_axisbelow(True)
        ax.axhline(5.5,color='gray',linewidth=.7);ax.axhline(7.5,color='gray',linewidth=.7)
    axes[0].set_yticks(range(len(NAMES)),LABELS);axes[0].invert_yaxis()
    axes[0].legend(loc='upper right',fontsize=8)
    fig.suptitle('Final GEMM evaluation — Apple M2 Pro\nExisting kernels, separate multicore branch, and vendor BLAS; seven calls per median')
    fig.text(.5,.015,'No NEON + multithreading combination. Accelerate limit is a request; its actual worker counts are unknown.',ha='center',fontsize=9)
    fig.tight_layout(rect=(0,.045,1,.91));fig.savefig(ROOT/'results/plots/final-progression.png',dpi=150)
    # Companion plot exposes shape dependence rather than just a chosen headline size.
    fig,ax=plt.subplots(figsize=(11,5))
    for color,(name,label) in zip(['#249775','#426bb2','#ad7431','#9b649f'], [('neon4','NEON 4×4'),('dynamic12','Blocked dynamic (up to 12)'),('accelerate_limit1','Accelerate limit 1 requested'),('accelerate_default','Accelerate default')]):
        for idx,run in enumerate(runs):
            ax.plot(range(len(SHAPES)),[float(run[(s,name)]['gflops']) for s in SHAPES],
                    marker='o',color=color,linestyle='-' if idx==0 else '--',label=label+(' primary' if idx==0 else ' reverse'))
    ax.set_yscale('log');ax.set_ylabel('GFLOP/s — logarithmic scale')
    ax.set_xticks(range(len(SHAPES)),['256³','512³','1024³','255×513×257','16×1024×512'])
    ax.set_title('Shape dependence: same build, inputs and timing contract\nDynamic worker caps: 8, 12, 12, 8, 1')
    ax.grid(alpha=.2);ax.legend(ncol=2,fontsize=8,loc='upper center',bbox_to_anchor=(.5,-.12))
    fig.tight_layout();fig.savefig(ROOT/'results/plots/final-shapes.png',dpi=150,bbox_inches='tight')
    for row in report:
        print(row['shape'])
        for name,c in row['cases'].items():
            print(name, 'GF',*[round(v,2) for v in c['gflops']], 'xnaive',*[round(v,2) for v in c['speedup_over_naive']], '%BLASdefault',*[round(v,2) for v in c['percent_accelerate_default']])


if __name__=='__main__':main()
