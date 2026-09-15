#!/bin/sh

set -eu

IMAGE=${PLATO_KOBO_BUILDER_IMAGE:-plato-kobo-builder:local}
TARGET_DIR=${PLATO_KOBO_TARGET_DIR:-target/kobo-compatible}

docker build \
    --build-arg RUST_VERSION=${PLATO_RUST_VERSION:-1.85.1} \
    -f docker/kobo-builder/Dockerfile \
    -t "$IMAGE" \
    .

docker run --rm \
    -v "$PWD:/src" \
    -v "${CARGO_HOME:-$HOME/.cargo}/registry:/root/.cargo/registry" \
    -v "${CARGO_HOME:-$HOME/.cargo}/git:/root/.cargo/git" \
    -e CARGO_TARGET_DIR="/src/$TARGET_DIR" \
    "$IMAGE" \
    sh -lc "if [ -e libs/libmupdf.so ]; then \
        PLATO_SKIP_CARGO=1 ./build.sh skip; \
    else \
        PLATO_SKIP_CARGO=1 ./build.sh fast; \
    fi && \
        CARGO_TARGET_ARM_UNKNOWN_LINUX_GNUEABIHF_LINKER=arm-linux-gnueabihf-gcc-jessie \
        cargo build --locked --release --target arm-unknown-linux-gnueabihf -p plato"

BINARY="$TARGET_DIR/arm-unknown-linux-gnueabihf/release/plato"
readelf -V "$BINARY" | grep -o 'GLIBC_[0-9.]*' | sort -Vu
printf '%s\n' "Kobo-compatible binary: $BINARY"
