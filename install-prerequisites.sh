#!/bin/sh

set -eu

color=1
[ -t 1 ] || color=0
[ -n "${NO_COLOR:-}" ] && color=0
[ "${TERM:-}" = dumb ] && color=0

if [ "$color" -eq 1 ]; then
    green='\033[32m'
    cyan='\033[36m'
    yellow='\033[33m'
    red='\033[31m'
    reset='\033[0m'
else
    green=''
    cyan=''
    yellow=''
    red=''
    reset=''
fi

info() { printf '%b→%b %s\n' "$cyan" "$reset" "$*"; }
ok() { printf '%b✓%b %s\n' "$green" "$reset" "$*"; }
die() { printf '%b✗%b %s\n' "$red" "$reset" "$*" >&2; exit 1; }

if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
    cat <<'HELP'
Usage: ./install-prerequisites.sh

Install the Debian packages and Rust target required to build Plato, run the
headless emulator, and prepare the Kobo installation workflow.

The script asks sudo for your password in the terminal. Never pass the
password as an argument or commit it to a file.
HELP
    exit 0
fi

[ "$(id -u)" -ne 0 ] || die "Run this script as your normal user, not with sudo."
command -v sudo >/dev/null 2>&1 || die "sudo is required."
command -v apt-get >/dev/null 2>&1 || die "This script requires an apt-based system."
command -v mise >/dev/null 2>&1 || die "mise is required for the Rust toolchain."

packages='build-essential
 gcc-arm-linux-gnueabihf
 g++-arm-linux-gnueabihf
 binutils-arm-linux-gnueabihf
 cmake
 curl
 git
 jq
 patchelf
 pkg-config
 rsync
 tar
 unzip
 wget
 zip
 libsdl2-dev
 libbz2-dev
 libdjvulibre-dev
 libfreetype-dev
 libgumbo-dev
 libharfbuzz-dev
 libjbig2dec0-dev
 libjpeg62-turbo-dev
 libglu1-mesa-dev
 libmupdf-dev
 libopenjp2-7-dev
 libpng-dev
 zlib1g-dev
 xvfb
 xauth'

info "Requesting sudo access."
sudo -v

info "Updating Debian package metadata."
sudo apt-get update

info "Installing build, emulator, and headless-device prerequisites."
# shellcheck disable=SC2086
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y $packages

info "Installing the Rust ARM target through mise."
mise exec -- rustc --version >/dev/null
mise exec -- cargo --version >/dev/null
mise exec -- rustup target add arm-unknown-linux-gnueabihf

info "Verifying required commands."
for command in \
    arm-linux-gnueabihf-gcc \
    arm-linux-gnueabihf-g++ \
    arm-linux-gnueabihf-ar \
    arm-linux-gnueabihf-strip \
    cmake patchelf pkg-config xvfb-run rsync; do
    command -v "$command" >/dev/null 2>&1 || die "Missing command after installation: $command"
done

pkg-config --exists sdl2 || die "SDL2 is not visible through pkg-config."
mise exec -- rustup target list --installed | grep -Fx arm-unknown-linux-gnueabihf >/dev/null \
    || die "The Rust ARM target is not installed."

ok "All Plato build and headless installation prerequisites are ready."
printf '\nNext steps:\n'
printf '  1. mise exec -- ./build.sh\n'
printf '  2. mise exec -- ./dist.sh\n'
printf '  3. xvfb-run -a mise exec -- ./run-emulator.sh\n'
printf '  4. Review dist/ before copying it to the Kobo.\n'
