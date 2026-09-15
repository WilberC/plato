#!/bin/sh

set -eu

DEVICE=${1:-}
MOUNTPOINT=${2:-/mnt/kobo}

error() {
	printf '[ERROR] %s\n' "$1" >&2
	exit 1
}

detect_device() {
	lsblk -nrpo NAME,LABEL 2>/dev/null |
		awk '$2 == "KOBOeReader" { print $1; exit }'
}

DEVICE=${DEVICE:-$(detect_device)}
[ -n "$DEVICE" ] || error 'KOBOeReader was not detected. Connect the Kobo and try again.'

printf '%s\n' 'Plato Kobo uninstaller'
printf '%s\n' "[INFO] Device: $DEVICE"
printf '%s\n' "[INFO] Mountpoint: $MOUNTPOINT"

sudo -v
if mountpoint -q "$MOUNTPOINT"; then
	CURRENT_DEVICE=$(findmnt -no SOURCE "$MOUNTPOINT")
	[ "$CURRENT_DEVICE" = "$DEVICE" ] || error "${MOUNTPOINT} is mounted from ${CURRENT_DEVICE}, not ${DEVICE}."
	MOUNTED_BY_SCRIPT=0
else
	sudo mount -o rw "$DEVICE" "$MOUNTPOINT"
	MOUNTED_BY_SCRIPT=1
fi

cleanup() {
	if [ "$MOUNTED_BY_SCRIPT" -eq 1 ] && mountpoint -q "$MOUNTPOINT"; then
		sync
		sudo umount "$MOUNTPOINT"
	fi
}
trap cleanup EXIT HUP INT TERM

mount_options=$(findmnt -no OPTIONS "$MOUNTPOINT")
printf '%s\n' "$mount_options" | grep -q 'rw' || error 'Kobo did not mount read-write.'
[ -d "$MOUNTPOINT/.adds/nm" ] || error 'Existing NickelMenu directory was not found.'
[ -d "$MOUNTPOINT/.adds/koreader" ] || error 'KOReader directory was not found; refusing to continue.'

printf '%s\n' '[INFO] Removing only the Plato installation and menu entries.'
sudo rm -rf \
	"$MOUNTPOINT/.adds/plato" \
	"$MOUNTPOINT/.adds/nm/plato" \
	"$MOUNTPOINT/.adds/nm/plato-benchmark"

[ ! -e "$MOUNTPOINT/.adds/plato" ] || error 'Plato directory was not removed.'
[ ! -e "$MOUNTPOINT/.adds/nm/plato" ] || error 'Plato NickelMenu entry was not removed.'
[ ! -e "$MOUNTPOINT/.adds/nm/plato-benchmark" ] || error 'Benchmark NickelMenu entry was not removed.'

printf '%s\n' '[OK] Plato was removed; KOReader and Test-Books were preserved.'
