#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SOURCE=${1:-"$SCRIPT_DIR/benchmarks/corpus"}
MOUNTPOINT=${2:-/mnt/kobo}
TARGET="$MOUNTPOINT/Test-Books"

error() {
	printf '[ERROR] %s\n' "$1" >&2
	exit 1
}

if [ "${1:-}" = '--help' ] || [ "${1:-}" = '-h' ]; then
	cat <<'EOF'
Usage: ./copy-test-books.sh [SOURCE] [MOUNTPOINT]

Copy the versioned Phase 01 corpus to Test-Books/ on the Kobo.
EOF
	exit 0
fi

detect_device() {
	lsblk -nrpo NAME,LABEL 2>/dev/null |
		awk '$2 == "KOBOeReader" { print $1; exit }'
}

[ -d "$SOURCE" ] || error "Test-book directory is missing: $SOURCE"
DEVICE=$(detect_device)
[ -n "$DEVICE" ] || error 'KOBOeReader was not detected. Connect the Kobo and try again.'

printf '%s\n' 'Kobo test-book copier'
printf '%s\n' "[INFO] Device: $DEVICE"
printf '%s\n' "[INFO] Source: $SOURCE"

sudo -v
if mountpoint -q "$MOUNTPOINT"; then
	CURRENT_DEVICE=$(findmnt -no SOURCE "$MOUNTPOINT")
	[ "$CURRENT_DEVICE" = "$DEVICE" ] || error "${MOUNTPOINT} is mounted from ${CURRENT_DEVICE}, not ${DEVICE}."
	printf '%s\n' '[INFO] Using the existing Kobo mount.'
else
	sudo mount -o rw "$DEVICE" "$MOUNTPOINT"
fi

cleanup() {
	if mountpoint -q "$MOUNTPOINT"; then
		sync
		sudo umount "$MOUNTPOINT"
	fi
}
trap cleanup EXIT HUP INT TERM

mount_options=$(findmnt -no OPTIONS "$MOUNTPOINT")
printf '%s\n' "$mount_options" | grep -q 'rw' || error 'Kobo did not mount read-write.'

printf '%s\n' '[INFO] Copying test books.'
sudo mkdir -p "$TARGET"
sudo cp -r --no-preserve=ownership "$SOURCE"/. "$TARGET"/

EXPECTED=$(find "$SOURCE" -maxdepth 1 -type f | wc -l)
ACTUAL=$(find "$TARGET" -maxdepth 1 -type f | wc -l)
[ "$ACTUAL" -ge "$EXPECTED" ] || error "Expected at least $EXPECTED files, found $ACTUAL."
printf '%s\n' "[OK] Copied $ACTUAL test-book files to $TARGET."
