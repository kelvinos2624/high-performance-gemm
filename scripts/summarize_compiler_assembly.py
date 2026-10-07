#!/usr/bin/env python3
"""Static inventory of selected ARM64 functions, not dynamic instruction counts."""
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
ARTIFACTS = ROOT / "results/compiler"
FUNCTIONS = {
    "naive_ijk": ("gemm_naive.cpp.s", "9naive_ijk"),
    "ikj": ("gemm_loop_order.cpp.s", "3ikj"),
    "blocked": ("gemm_blocked.cpp.s", "7blocked"),
    "tile_4x4": ("microkernel_tiles.cpp.s", "8tile_4x4"),
}


def main():
    records = []
    for variant in ("O0", "O2", "O3", "O3-native", "O3-no-vector"):
        for name, (filename, symbol) in FUNCTIONS.items():
            path = ARTIFACTS / variant / filename
            lines = path.read_text().splitlines()
            start = next(i for i, line in enumerate(lines)
                         if line.startswith("__ZN") and symbol in line and ":" in line)
            end = next(i for i in range(start, len(lines)) if ".cfi_endproc" in lines[i])
            body = lines[start:end + 1]
            instructions = [line.split(";")[0].strip() for line in body
                            if re.match(r"^\t[a-z][a-z0-9.]*\s", line)]
            records.append({
                "build": variant, "function": name, "file": str(path.relative_to(ROOT)),
                "start_line": start + 1, "end_line": end + 1,
                "scalar_fmadd_sites": sum(line.startswith("fmadd\t") for line in instructions),
                "vector_fmla_sites": sum(line.startswith("fmla.") for line in instructions),
                "vector_fmul_sites": sum(line.startswith("fmul.") for line in instructions),
                "call_sites": [line for line in instructions if re.match(r"blr?\s", line)],
                "instruction_count": len(instructions),
                "instruction_text_sha256": hashlib.sha256("\n".join(instructions).encode()).hexdigest(),
            })
    output = {"scope": "Static function inventory includes specialized paths and cleanup; "
                        "not runtime counts. O0 tile wrapper calls a separate template body.",
              "functions": records}
    (ARTIFACTS / "assembly-summary.json").write_text(json.dumps(output, indent=2) + "\n")
    for row in records:
        print(row["build"], row["function"], "scalar/vector FMA sites:",
              row["scalar_fmadd_sites"], row["vector_fmla_sites"],
              "vector multiply sites:", row["vector_fmul_sites"])


if __name__ == "__main__":
    main()
