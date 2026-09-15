FROM debian:13-slim@sha256:d7e12182ce18b85b93007c1dedf31f2d29e01ccf3182cc4017c709b6259bc132

ARG RUST_VERSION=1.85.1

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential ca-certificates curl git pkg-config unzip patchelf \
    gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf binutils-arm-linux-gnueabihf \
    dpkg-dev \
    && dpkg --add-architecture armhf \
    && printf 'deb [trusted=yes check-valid-until=no] http://snapshot.debian.org/archive/debian/20190301T000000Z jessie main\n' \
        > /etc/apt/sources.list.d/jessie.list \
    && apt-get -o Acquire::Check-Valid-Until=false update \
    && mkdir -p /opt/jessie \
    && cd /tmp \
    && apt-get download \
        libc6:armhf=2.19-18+deb8u10 \
        libc6-dev:armhf=2.19-18+deb8u10 \
        linux-libc-dev:armhf=3.16.56-1+deb8u1 \
        libstdc++6:armhf=4.9.2-10+deb8u1 \
        libstdc++-4.9-dev:armhf=4.9.2-10+deb8u1 \
        libgcc1:armhf=1:4.9.2-10+deb8u1 \
        libgcc-4.9-dev:armhf=4.9.2-10+deb8u1 \
    && for package in /tmp/*.deb; do dpkg-deb -x "$package" /opt/jessie; done \
    && for link in /opt/jessie/usr/lib/arm-linux-gnueabihf/*.so*; do \
        target=$(readlink "$link" || true); \
        case "$target" in /lib/*|/usr/lib/*) \
            ln -sfn "../../../${target#/}" "$link";; \
        esac; \
    done \
    && rm -f /opt/jessie/usr/lib/arm-linux-gnueabihf/libm.a \
    && cp /opt/jessie/lib/arm-linux-gnueabihf/libgcc_s.so.1 \
        /usr/arm-linux-gnueabihf/lib/libgcc_s.so.1 \
    && rm -rf /var/lib/apt/lists/* /tmp/*.deb

RUN cat > /usr/local/bin/arm-linux-gnueabihf-gcc-jessie <<'SH'
#!/bin/sh
exec /usr/bin/arm-linux-gnueabihf-gcc \
    --sysroot=/opt/jessie \
    -B/opt/jessie/usr/lib/gcc/arm-linux-gnueabihf/4.9 \
    -L/opt/jessie/usr/lib/arm-linux-gnueabihf "$@"
SH

RUN chmod +x /usr/local/bin/arm-linux-gnueabihf-gcc-jessie \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
        sh -s -- -y --default-toolchain "$RUST_VERSION" \
    && /root/.cargo/bin/rustup target add arm-unknown-linux-gnueabihf

ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /src
