#!/bin/sh

set -eu

detect_device() {
	lsblk -nrpo NAME,LABEL 2>/dev/null |
		awk '$2 == "KOBOeReader" { print $1; exit }'
}

DEVICE=${1:-$(detect_device)}
MOUNTPOINT=${2:-/mnt/kobo}
BACKUP_DIR=/home/wilber/Backups/plato-baseline/kobo-2026-09-14

error() {
	printf '[ERROR] %s\n' "$1" >&2
	exit 1
}

if [ "${1:-}" = '--help' ] || [ "${1:-}" = '-h' ]; then
	cat <<'EOF'
Usage: ./install-kobo.sh [DEVICE] [MOUNTPOINT]

Install the current Plato distribution on a Kobo with an existing NickelMenu.
When DEVICE is omitted, the KOBOeReader filesystem label is detected.
EOF
	exit 0
fi

printf '%s\n' 'Plato Kobo installer'
[ -n "$DEVICE" ] || error 'KOBOeReader was not detected. Connect the Kobo and try again.'
printf '%s\n' "[INFO] Device: $DEVICE"
printf '%s\n' "[INFO] Mountpoint: $MOUNTPOINT"

[ -d dist ] || error 'dist/ is missing; run dist.sh first.'
[ -x dist/plato ] || error 'dist/plato is not executable; rebuild the distribution.'
[ -f contrib/NickelMenu/plato ] || error 'NickelMenu launcher is missing.'
[ -d "$BACKUP_DIR/.adds/koreader" ] || error "Expected backup is missing: $BACKUP_DIR"

sudo -v

if mountpoint -q "$MOUNTPOINT"; then
	CURRENT_DEVICE=$(findmnt -no SOURCE "$MOUNTPOINT")
	[ "$CURRENT_DEVICE" = "$DEVICE" ] || error "${MOUNTPOINT} is mounted from ${CURRENT_DEVICE}, not ${DEVICE}."
	printf '%s\n' '[INFO] Unmounting the read-only Kobo volume.'
	sudo umount "$MOUNTPOINT"
fi

printf '%s\n' '[INFO] Mounting the verified Kobo volume read-write.'
sudo mount -o rw "$DEVICE" "$MOUNTPOINT"

cleanup() {
	if mountpoint -q "$MOUNTPOINT"; then
		sync
		sudo umount "$MOUNTPOINT"
	fi
}
trap cleanup EXIT HUP INT TERM

MOUNTED_DEVICE=$(findmnt -no SOURCE "$MOUNTPOINT")
[ "$MOUNTED_DEVICE" = "$DEVICE" ] || error "Mounted device is ${MOUNTED_DEVICE}, not ${DEVICE}."
mount_options=$(findmnt -no OPTIONS "$MOUNTPOINT")
printf '%s\n' "$mount_options" | grep -q 'rw' || error 'Kobo did not mount read-write.'
[ -d "$MOUNTPOINT/.adds/nm" ] || error 'Existing NickelMenu directory was not found.'
[ -d "$MOUNTPOINT/.adds/koreader" ] || error 'KOReader directory was not found; refusing to continue.'

printf '%s\n' '[INFO] Installing Plato files.'
sudo mkdir -p "$MOUNTPOINT/.adds/plato"
sudo cp -r --no-preserve=ownership dist/. "$MOUNTPOINT/.adds/plato/"
sudo cp --no-preserve=ownership contrib/NickelMenu/plato* "$MOUNTPOINT/.adds/nm/"
sudo chmod +x "$MOUNTPOINT/.adds/plato/plato.sh" "$MOUNTPOINT/.adds/plato/plato-benchmark.sh"
sudo rm -f "$MOUNTPOINT/.adds/plato/info.log" "$MOUNTPOINT/.adds/plato/benchmark.jsonl"

if [ ! -e "$MOUNTPOINT/.adds/plato/Settings.toml" ]; then
	printf '%s\n' '[INFO] Creating the initial onboard library settings.'
	printf '%s\n' \
		'selected-library = 0' \
		'[[libraries]]' \
		'name = "On Board"' \
		'path = "/mnt/onboard"' \
		'mode = "database"' |
		sudo tee "$MOUNTPOINT/.adds/plato/Settings.toml" >/dev/null
fi

[ -x "$MOUNTPOINT/.adds/plato/plato" ] || error 'Installed Plato binary is not executable.'
[ -x "$MOUNTPOINT/.adds/plato/plato.sh" ] || error 'Installed launcher is not executable.'
[ -x "$MOUNTPOINT/.adds/plato/plato-benchmark.sh" ] || error 'Benchmark launcher is not executable.'
[ -f "$MOUNTPOINT/.adds/nm/plato" ] || error 'NickelMenu entry was not installed.'
[ -f "$MOUNTPOINT/.adds/nm/plato-benchmark" ] || error 'NickelMenu benchmark entry was not installed.'
[ -f "$MOUNTPOINT/.adds/plato/Settings.toml" ] || error 'Plato settings were not installed.'

printf 'Installed files: '
find "$MOUNTPOINT/.adds/plato" -type f | wc -l
printf '%s\n' '[OK] Plato and the NickelMenu launcher were installed.'
printf '%s\n' '[INFO] The Kobo will be unmounted safely before this script exits.'
