#!/bin/sh

WORKDIR=$(dirname "$0")
cd "$WORKDIR" || exit 1

export PLATO_BENCHMARK=1
export PLATO_BENCHMARK_OUTPUT=/mnt/onboard/.adds/plato/benchmark.jsonl

exec ./plato.sh
