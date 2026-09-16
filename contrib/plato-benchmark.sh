#!/bin/sh

WORKDIR=$(dirname "$0")
cd "$WORKDIR" || exit 1

MARKER=/mnt/onboard/.adds/plato/benchmark.enabled
touch "$MARKER"
cleanup() {
	rm -f "$MARKER"
}
trap cleanup EXIT HUP INT TERM

./plato.sh
