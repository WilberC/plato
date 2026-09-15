#!/bin/sh

set -eu

OUTPUT=${1:-/home/wilber/forge-app/kobo-benchmark.jsonl}
MOUNTPOINT=${2:-/mnt/kobo}

error() {
	printf '[ERROR] %s\n' "$1" >&2
	exit 1
}

detect_device() {
	lsblk -nrpo NAME,LABEL 2>/dev/null |
		awk '$2 == "KOBOeReader" { print $1; exit }'
}

DEVICE=$(detect_device)
[ -n "$DEVICE" ] || error 'KOBOeReader was not detected. Connect the Kobo and try again.'

printf '%s\n' 'Kobo Plato benchmark collector'
printf '%s\n' "[INFO] Device: $DEVICE"

sudo -v
if mountpoint -q "$MOUNTPOINT"; then
	CURRENT_DEVICE=$(findmnt -no SOURCE "$MOUNTPOINT")
	[ "$CURRENT_DEVICE" = "$DEVICE" ] || error "${MOUNTPOINT} is mounted from ${CURRENT_DEVICE}, not ${DEVICE}."
	MOUNTED_BY_SCRIPT=0
else
	sudo mount -o ro "$DEVICE" "$MOUNTPOINT"
	MOUNTED_BY_SCRIPT=1
fi

cleanup() {
	if [ "$MOUNTED_BY_SCRIPT" -eq 1 ] && mountpoint -q "$MOUNTPOINT"; then
		sudo umount "$MOUNTPOINT"
	fi
}
trap cleanup EXIT HUP INT TERM

SOURCE="$MOUNTPOINT/.adds/plato/benchmark.jsonl"
[ -f "$SOURCE" ] || error "Benchmark output was not found at $SOURCE"
sudo cp --no-preserve=ownership "$SOURCE" "$OUTPUT"
sudo chown "$(id -u):$(id -g)" "$OUTPUT"
printf '%s\n' "[OK] Copied benchmark output to $OUTPUT"
