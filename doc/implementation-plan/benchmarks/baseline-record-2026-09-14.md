# Plato Baseline Record: 2026-09-14

Last updated: 2026-09-15

## Device

- Model: `Kobo Libra H₂O`
- Model identifier: `N873`
- Firmware version: `4.38.23697`
- Screen resolution: `TBD`
- Available storage assumption: `6.8 GB total; 6.5 GB free at capture`
- Available memory assumption: `TBD`
- Refresh settings: `TBD`
- Power state: `TBD`
- Frontlight state: `TBD`
- Wi-Fi state: `TBD`

## Source and build

- Repository commit: `c121ae4fcca5693cfe4d8363825970b07080d467`
- Working tree: `Documentation changes present; reader source unchanged`
- Rust toolchain: `rustc 1.98.1 (mise)`
- Host OS: `Debian 13`
- Cross-compiler/toolchain version: `TBD`
- Build command: `./build.sh`
- Distribution command: `./dist.sh`
- Emulator command: `./run-emulator.sh`
- Build result: `cargo check --workspace --locked` and ARM build passed; the Debian 13 cross-linked executable was not Kobo-compatible because it required GLIBC versions through 2.39.
- Distribution result: `dist/` generated; `dist/plato` replaced with the compatible executable from `plato-0.9.45.zip` for physical validation.
- Emulator result: Started successfully under Xvfb; stopped by the expected smoke-test timeout (exit 124).

## Configuration and corpus

- Device config checksum: `b55a5a1a25f8cb922a30e1ea743dc8fbe0dc4acf6221e1b82705f8de74cfbc83` (`.kobo/Kobo/Kobo eReader.conf`)
- Corpus manifest: `corpus-manifest-2026-09-14.md`
- Corpus checksum: Per-file SHA-256 values are recorded in `corpus-manifest-2026-09-14.md`; files are stored outside the repository in `~/forge-app/test-books`.
- Installation method: Direct copy to `.adds/plato` with existing NickelMenu launcher at `.adds/nm/plato`; initial `Settings.toml` points to `/mnt/onboard`.
- Launch method: `TBD`

## Scenario observations

| Corpus item | Scenario | Samples | Min (ms) | Max (ms) | Notes |
| --- | --- | ---: | ---: | ---: | --- |
| `TBD` | Open book | 0 | `TBD` | `TBD` | `TBD` |
| `TBD` | Forward, cold | 0 | `TBD` | `TBD` | `TBD` |
| `TBD` | Backward, cold | 0 | `TBD` | `TBD` | `TBD` |
| `TBD` | Forward, cached | 0 | `TBD` | `TBD` | `TBD` |
| `TBD` | Backward, cached | 0 | `TBD` | `TBD` | `TBD` |

## Repeatability notes

- Date/time and timezone: `2026-09-14; America/Lima`
- Interruption or anomalous samples: `TBD`
- Reproduction instructions: `TBD`
- Baseline conclusion: `TBD`
