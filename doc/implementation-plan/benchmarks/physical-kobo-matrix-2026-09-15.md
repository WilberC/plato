# Physical Kobo Benchmark Matrix: 2026-09-15

## Run metadata

- Device: `Kobo Libra H₂O`
- Repository commit: `6fc340d275c67a3b9fbb449ee65e9d18eff17bb1`
- Capture mode: `Plato benchmark` via NickelMenu and physical page buttons
- Raw result: `benchmarks/results/kobo-libra-h2o-2026-09-15-matrix-01.jsonl`

## Results by book

| File | Title | Format | Samples | P50 submission | P95 submission | Max submission |
| --- | --- | --- | ---: | ---: | ---: | ---: |
| `Test-Books/01-simple.epub` | *Alice's Adventures in Wonderland* | `epub` | 30 | 230.4 ms | 253.2 ms | 265.1 ms |
| `Test-Books/04-text.pdf` | *04-text* | `pdf` | 30 | 560.5 ms | 580.2 ms | 585.1 ms |
| `Test-Books/05-complex.pdf` | *Wonder Comics #1 (Wonder Man story only) Comic* | `pdf` | 20 | 713.8 ms | 12779.3 ms | 14001.6 ms |

## Direction counts

| Direction | Samples | P50 submission |
| --- | ---: | ---: |
| `next` | 40 | 530.7 ms |
| `previous` | 40 | 390.5 ms |

- Total records: **80**.
- Update modes: `Partial` 73, `Full` 7.
- Largest sample: **14001.6 ms** on `Test-Books/05-complex.pdf`.

## Scope and limitations

- Book path, title, and format were captured automatically for every record.
- This run covers only the three books listed above; the remaining corpus items still need measurement.
- The JSONL schema does not yet encode `cold` versus `cached`; the run sequence must be interpreted using the test procedure.
- `framebuffer_completion` and `visible_page_ready` remain unobservable and are recorded as `null`.

## Next step

Finish the remaining corpus items, then investigate the complex-PDF outlier before changing the rendering pipeline.
