# Physical Kobo Benchmark Capture: 2026-09-15

## Run metadata

- Device: `Kobo Libra H₂O`
- Device model reported by Plato: `Libra H₂O`
- Host OS: `Debian 13`
- Repository commit: `c00894b2efcad0f08a2410f20fcb54dea555adf5` (`c00894b` hardware-button capture fix)
- Raw result: `benchmarks/results/kobo-libra-h2o-2026-09-15.jsonl`
- Capture mode: `Plato benchmark` via NickelMenu and physical page buttons

## Captured samples

| Direction | Samples | P50 framebuffer submission | Min | Max |
| --- | ---: | ---: | ---: | ---: |
| `next` | 21 | 527.4 ms | 230.5 ms | 744.7 ms |
| `previous` | 23 | 552.8 ms | 225.7 ms | 13953.7 ms |

- Total records: **44**.
- Update modes: `Partial` 39, `Full` 5.
- Outlier: one `previous` sample measured **13,953.7 ms**; retain it for investigation rather than deleting it.

## Scope and limitations

- This is the first successful physical instrumentation capture after fixing hardware-button events.
- It is not yet the complete Phase 01 matrix: the run does not preserve the book filename in each JSONL record, and repeated cold/cached scenarios still need explicit collection.
- `framebuffer_completion` and `visible_page_ready` remain unobservable and are recorded as `null`.

## Next step

Use this capture as the physical instrumentation baseline, then collect the remaining fixed scenarios with book identity recorded externally before making performance changes.
