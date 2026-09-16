#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
OUTPUT=${1:-"$ROOT/benchmarks/results/$(date -u +%Y%m%dT%H%M%SZ).jsonl"}
mkdir -p "$(dirname -- "$OUTPUT")"

COMMIT=$(git -C "$ROOT" rev-parse HEAD)
STARTED_AT=$(date -u +%Y-%m-%dT%H:%M:%SZ)
python3 - "$OUTPUT.meta.json" "$COMMIT" "$STARTED_AT" "$OUTPUT" <<'PY'
import json
import platform
import sys

path, commit, started_at, output = sys.argv[1:]
with open(path, "w", encoding="utf-8") as metadata:
    json.dump({
        "schema_version": 1,
        "source_commit": commit,
        "started_at_utc": started_at,
        "host": platform.platform(),
        "output": output,
    }, metadata, indent=2)
    metadata.write("\n")
PY

cd "$ROOT"
export PLATO_BENCHMARK=1
export PLATO_BENCHMARK_OUTPUT="$OUTPUT"
export LD_LIBRARY_PATH="$ROOT/thirdparty/mupdf/build/shared-release:$ROOT/target/mupdf_wrapper/Linux:$ROOT/libs${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

if [ -n "${DISPLAY:-}" ]; then

	exec mise exec -- ./run-emulator.sh
fi

if command -v xvfb-run >/dev/null 2>&1; then

	exec xvfb-run -a mise exec -- ./run-emulator.sh
fi

echo "No DISPLAY is available and xvfb-run is not installed." >&2
exit 1
