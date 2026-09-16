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

- Repository commit: `f61f00ccba1f143cfb944f0ea5b345a5bc68b10e` (Phase 01 installation baseline)
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
- Corpus checksum: Per-file SHA-256 values are recorded in `corpus-manifest-2026-09-14.md`; canonical files are versioned in `benchmarks/corpus/`.
- Installation method: Direct copy to `.adds/plato` with existing NickelMenu launcher at `.adds/nm/plato`; initial `Settings.toml` points to `/mnt/onboard`.
- Launch method: Existing NickelMenu entry at `.adds/nm/plato`; Plato starts from the Kobo launcher menu.

## Scenario observations

Qualitative physical observations from the first Kobo run (no stopwatch
measurements collected yet): EPUB simple/images/large, text PDF, CBZ, and DjVu
opened and navigated normally. The complex PDF opened extremely slowly and
was almost unusable to navigate. The CBR file did not appear in the library.

| Corpus item | Scenario | Samples | Min (ms) | Max (ms) | Notes |
| --- | --- | ---: | ---: | ---: | --- |
| `01-simple.epub`, `02-images.epub`, `03-large.epub`, `04-text.pdf`, `06-comic.cbz`, `08-optional.djvu` | Open and navigate | 1 each | `TBD` | `TBD` | Opened and navigated normally. |
| `05-complex.pdf` | Open and navigate | 1 | `TBD` | `TBD` | Opened very slowly; navigation was almost unusable. |
| `07-comic.cbr` | Library discovery | 1 | `TBD` | `TBD` | Not visible in the library. |
| `TBD` | Forward, cold | 0 | `TBD` | `TBD` | `TBD` |
| `TBD` | Backward, cold | 0 | `TBD` | `TBD` | `TBD` |
| `TBD` | Forward, cached | 0 | `TBD` | `TBD` | `TBD` |
| `TBD` | Backward, cached | 0 | `TBD` | `TBD` | `TBD` |

## Repeatability notes

- Date/time and timezone: `2026-09-14; America/Lima`
- Interruption or anomalous samples: `TBD`
- Reproduction instructions: `TBD`
- Baseline conclusion: `TBD`
