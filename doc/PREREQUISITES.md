# Plato Build and Headless Installation Prerequisites

This document describes the prerequisites for building the unchanged Plato
reader, generating an installation bundle, and installing it from a headless
Debian host on a Kobo Libra H₂O.

## Host assumptions

- Debian 13 (the verification environment).
- An x86_64 host with network access to crates.io, GitHub, and the Plato
  release assets.
- A physical Kobo device with a completed backup before the first write.
- A writable working copy of this repository.

The build and installation flow does not require a desktop environment. A
display server is only needed for a visual emulator session.

## Required host tools

Install the complete set with:

```sh
sudo apt update
sudo apt install \
    build-essential \
    gcc-arm-linux-gnueabihf \
    g++-arm-linux-gnueabihf \
    binutils-arm-linux-gnueabihf \
    cmake \
    curl \
    git \
    jq \
    patchelf \
    pkg-config \
    rsync \
    tar \
    unzip \
    wget \
    zip \
    libsdl2-dev \
    libbz2-dev \
    libdjvulibre-dev \
    libfreetype-dev \
    libgumbo-dev \
    libharfbuzz-dev \
    libjbig2dec0-dev \
    libjpeg62-turbo-dev \
    libglu1-mesa-dev \
    libmupdf-dev \
    libopenjp2-7-dev \
    libpng-dev \
    zlib1g-dev \
    xvfb \
    xauth
```

From the repository root, the same setup is available through the interactive helper:

```sh
./install-prerequisites.sh
```

It requests the sudo password directly from the terminal, installs the Debian packages, adds the Rust ARM target through `mise`, and verifies the resulting commands. Never pass a password as an argument or store it in the repository.

The repository scripts additionally rely on `make`, `gzip`, and `ar`; they are
provided by the packages above or by the standard Debian installation.

### Rust toolchain

Rust and Cargo are managed through `mise` in this environment. Verify the
required target with:

```sh
mise exec -- rustc --version
mise exec -- cargo --version
mise exec -- rustup target add arm-unknown-linux-gnueabihf
mise exec -- rustup target list --installed
```

The target must appear in the final list. Use the repository lockfile for
dependency resolution:

```sh
mise exec -- cargo metadata --locked --no-deps --format-version 1
```

### Build prerequisites

Verify the cross tools before building:

```sh
mise exec -- arm-linux-gnueabihf-gcc --version
mise exec -- arm-linux-gnueabihf-g++ --version
mise exec -- arm-linux-gnueabihf-ar --version
mise exec -- arm-linux-gnueabihf-strip --version
mise exec -- patchelf --version
```

`g++-arm-linux-gnueabihf` is required even though the application is Rust:
the final link includes `libstdc++`. `patchelf` is required by `dist.sh`.

## Build and package flow

Run these commands from the repository root:

```sh
mise exec -- ./build.sh
mise exec -- ./dist.sh
```

The default build downloads the release archive and required prebuilt Kobo
libraries. It writes ignored working artifacts to `libs/`, `bin/`,
`resources/`, `target/`, and `dist/`. Do not hand-edit those outputs.

For a complete source rebuild of third-party dependencies, the scripts use
`cmake` and the corresponding development tools:

```sh
mise exec -- ./build.sh slow
```

The build itself is headless-safe, but the complete Phase 01 validation flow
includes the emulator and therefore installs SDL2 and Xvfb as well.

## Emulator on a headless host

The emulator requires native Linux development libraries in addition to SDL2.
These are separate from the ARM libraries in `libs/`; ARM libraries cannot be
linked into the host emulator.

Run a non-visual smoke check with the SDL dummy driver when supported by the
host:

```sh
SDL_VIDEODRIVER=dummy mise exec -- ./run-emulator.sh
```

For a virtual display suitable for applications that require a normal SDL
window, use:

```sh
xvfb-run -a mise exec -- ./run-emulator.sh
```

The dummy/Xvfb modes can verify startup and process behavior but cannot replace
visual inspection of rendered pages.

## Kobo installation prerequisites

The repository's `bundle.sh` can use a NickelMenu archive to produce a zip
containing the `.adds` payload and `.kobo/KoboRoot.tgz`:

```sh
mise exec -- ./bundle.sh /path/to/nickelmenu.zip
```

The NickelMenu archive is only needed when NickelMenu is not already installed.
This Kobo already contains `.adds/nm`, so the first installation can use the
existing menu installation and copy `contrib/NickelMenu/plato` directly into
`.adds/nm/plato`; no external archive is required for that path.

For this Kobo's existing NickelMenu installation, run the repository helper
from a terminal where sudo can prompt for the password:

```sh
./install-kobo.sh
```

It identifies the device by the `KOBOeReader` filesystem label and verifies the
expected backup, KOReader, and NickelMenu before mounting it read-write.
Optional arguments override the device and mountpoint:
`./install-kobo.sh /dev/sdX /mnt/kobo`.

If no `Settings.toml` exists yet, the installer creates a minimal onboard
library configuration so Plato can start on its first launch.

After Plato is installed, copy the prepared validation corpus with:

```sh
./copy-test-books.sh
```

The helper detects `KOBOeReader` by filesystem label, copies all files from
`/home/wilber/forge-app/test-books` into `Test-Books/`, and safely unmounts the
device. Optional arguments override the source and mountpoint.

After the bundle is reviewed and the backup is complete:

1. Close KOReader and select **Connect** on the Kobo.
2. Confirm the mounted device is the expected `KOBOeReader` volume.
3. Unmount the read-only copy and remount the same device read-write.
4. Copy `dist/` to `.adds/plato/` and copy `contrib/NickelMenu/plato` to
   `.adds/nm/plato`.
5. Run `sync`, safely unmount the device, and disconnect it.
6. Allow the Kobo to process `KoboRoot.tgz` before launching Plato through the
   installed NickelMenu entry.

Do not run an installation against `/dev/sdb` or another block device directly;
write only through the verified mounted Kobo volume. Preserve the backup until
Plato has launched and the original Kobo library remains intact.

## Headless device validation

The host does not need a display or SSH access to the Kobo. Physical validation
still requires operating the reader's touch/buttons and observing the display.
Record the following manually in the Phase 01 baseline record:

- Kobo model and firmware.
- Installation and launch method.
- Corpus item and checksum.
- Forward/backward, cold/cached, and book-opening observations.
- Any visual artifacts, failed formats, or recovery actions.

## Verified on 2026-09-14

| Requirement | Status | Evidence or note |
| --- | --- | --- |
| Debian host | available | Debian 13 |
| Rust/Cargo through mise | available | Rust/Cargo 1.98.1 |
| `arm-unknown-linux-gnueabihf` target | available | Installed with rustup through mise |
| ARM GCC/G++/binutils | available | Debian cross packages installed |
| `patchelf` | available | Version 0.18.0 |
| `wget`, `curl`, `git`, `pkg-config`, `unzip`, `jq`, `make`, `tar`, `gzip`, `zip` | available | Host checks passed |
| Native emulator development libraries | pending | MuPDF, DjVuLibre, FreeType, HarfBuzz, Gumbo, JPEG, PNG, OpenJPEG, JBIG2, bzip2, zlib, and OpenGL/GLU |
| `cmake` | pending | Needed for the complete source-dependency route |
| `libsdl2-dev` | pending | Needed to build the emulator |
| `xvfb` and `xauth` | pending | Needed for the headless virtual-display emulator run |
| NickelMenu archive | not required for first install | Existing `.adds/nm` detected on the Kobo |
| Physical Kobo backup | complete | Stored outside the repository |

## Known build caveat

The Debian linker emitted warnings about local symbols in the downloaded
`libs/libmupdf.so`. The fatal error in the first build attempt was missing
cross-compiled `libstdc++`; install `g++-arm-linux-gnueabihf` and retry before
investigating those warnings as a separate issue.

The Debian 13 ARM cross toolchain can also produce a binary requiring glibc
versions newer than the Kobo firmware provides. `dist.sh` checks the linked
versions and automatically selects the compatible binary from the matching
release archive when this occurs. Verify the resulting binary with
`readelf -V dist/plato` before installing.
