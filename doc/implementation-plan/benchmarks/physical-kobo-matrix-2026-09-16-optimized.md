# Plato Benchmark Bottleneck Report

- Source: `/home/wilber/forge-app/kobo-benchmark.jsonl`
- Records: **227**
- Units: milliseconds; percentiles use inclusive interpolation.

## Aggregation by book, direction, and update mode

| File | Title | Direction | Update | N | Prep P50/P95/P99 | Raster P50/P95/P99 | Submit P50/P95/P99 | Max submit |
| --- | --- | --- | --- | ---: | ---: | ---: | ---: | ---: |
| `Test-Books/01-simple.epub` | *Alice's Adventures in Wonderland* | `next` | `Full` | 2 | 0.4 / 0.4 / 0.4 | 229.8 / 230.4 / 230.5 | 230.0 / 230.6 / 230.6 | 230.6 ms |
| `Test-Books/01-simple.epub` | *Alice's Adventures in Wonderland* | `next` | `Partial` | 13 | 3.1 / 3.2 / 3.2 | 230.9 / 338.9 / 365.0 | 231.0 / 339.1 / 365.1 | 371.6 ms |
| `Test-Books/01-simple.epub` | *Alice's Adventures in Wonderland* | `previous` | `Full` | 1 | 3.1 / 3.1 / 3.1 | 231.8 / 231.8 / 231.8 | 231.9 / 231.9 / 231.9 | 231.9 ms |
| `Test-Books/01-simple.epub` | *Alice's Adventures in Wonderland* | `previous` | `Partial` | 14 | 3.2 / 3.4 / 3.6 | 232.2 / 238.0 / 238.2 | 232.4 / 238.2 / 238.3 | 238.3 ms |
| `Test-Books/02-images.epub` | *The Project Gutenberg Encyclopedia, Volume 1 of 28* | `next` | `Full` | 2 | 1.8 / 3.0 / 3.1 | 230.0 / 230.9 / 230.9 | 230.2 / 231.0 / 231.1 | 231.1 ms |
| `Test-Books/02-images.epub` | *The Project Gutenberg Encyclopedia, Volume 1 of 28* | `next` | `Partial` | 23 | 3.1 / 3.2 / 3.2 | 230.3 / 239.6 / 246.8 | 230.4 / 239.7 / 247.0 | 248.8 ms |
| `Test-Books/02-images.epub` | *The Project Gutenberg Encyclopedia, Volume 1 of 28* | `previous` | `Full` | 4 | 3.1 / 3.1 / 3.1 | 237.9 / 249.4 / 251.0 | 238.1 / 249.6 / 251.1 | 251.5 ms |
| `Test-Books/02-images.epub` | *The Project Gutenberg Encyclopedia, Volume 1 of 28* | `previous` | `Partial` | 26 | 3.1 / 3.2 / 3.2 | 230.4 / 256.4 / 296.8 | 230.5 / 256.6 / 297.0 | 309.6 ms |
| `Test-Books/03-large.epub` | *Les Misérables* | `next` | `Full` | 3 | 0.5 / 2.9 / 3.1 | 229.4 / 230.9 / 231.0 | 229.5 / 231.0 / 231.2 | 231.2 ms |
| `Test-Books/03-large.epub` | *Les Misérables* | `next` | `Partial` | 17 | 3.1 / 3.2 / 3.3 | 229.9 / 263.1 / 310.0 | 230.1 / 263.3 / 310.1 | 321.9 ms |
| `Test-Books/03-large.epub` | *Les Misérables* | `previous` | `Full` | 2 | 1.8 / 3.0 / 3.1 | 229.6 / 229.7 / 229.7 | 229.7 / 229.8 / 229.9 | 229.9 ms |
| `Test-Books/03-large.epub` | *Les Misérables* | `previous` | `Partial` | 18 | 3.1 / 3.3 / 3.3 | 230.5 / 281.7 / 413.0 | 230.7 / 281.8 / 413.2 | 446.0 ms |
| `Test-Books/04-text.pdf` | *04-text* | `next` | `Full` | 1 | 3.3 / 3.3 / 3.3 | 539.7 / 539.7 / 539.7 | 539.8 / 539.8 / 539.8 | 539.8 ms |
| `Test-Books/04-text.pdf` | *04-text* | `next` | `Partial` | 15 | 3.2 / 3.3 / 3.3 | 537.2 / 564.4 / 581.3 | 537.4 / 564.6 / 581.4 | 585.7 ms |
| `Test-Books/04-text.pdf` | *04-text* | `previous` | `Full` | 2 | 1.9 / 3.1 / 3.2 | 552.9 / 571.3 / 573.0 | 553.1 / 571.5 / 573.1 | 573.5 ms |
| `Test-Books/04-text.pdf` | *04-text* | `previous` | `Partial` | 13 | 3.2 / 3.3 / 3.3 | 537.9 / 658.5 / 727.6 | 538.1 / 658.6 / 727.7 | 745.0 ms |
| `Test-Books/05-complex.pdf` | *Wonder Comics #1 (Wonder Man story only) Comic* | `next` | `Partial` | 6 | 1.4 / 10555.9 / 13091.0 | 469.4 / 10795.8 / 13324.7 | 469.6 / 10796.0 / 13324.8 | 13957.1 ms |
| `Test-Books/05-complex.pdf` | *Wonder Comics #1 (Wonder Man story only) Comic* | `previous` | `Full` | 1 | 1056.4 / 1056.4 / 1056.4 | 1293.2 / 1293.2 / 1293.2 | 1293.4 / 1293.4 / 1293.4 | 1293.4 ms |
| `Test-Books/05-complex.pdf` | *Wonder Comics #1 (Wonder Man story only) Comic* | `previous` | `Partial` | 4 | 0.2 / 11185.4 / 12764.5 | 722.5 / 11473.0 / 12990.3 | 722.6 / 11473.1 / 12990.5 | 13369.8 ms |
| `Test-Books/06-comic.cbz` | *06-comic* | `next` | `Full` | 2 | 1.8 / 3.0 / 3.1 | 231.7 / 235.8 / 236.2 | 231.8 / 236.0 / 236.3 | 236.4 ms |
| `Test-Books/06-comic.cbz` | *06-comic* | `next` | `Partial` | 15 | 2.0 / 3.4 / 3.7 | 227.3 / 397.5 / 684.5 | 227.5 / 397.7 / 684.6 | 756.3 ms |
| `Test-Books/06-comic.cbz` | *06-comic* | `previous` | `Full` | 1 | 3.2 / 3.2 / 3.2 | 225.4 / 225.4 / 225.4 | 225.6 / 225.6 / 225.6 | 225.6 ms |
| `Test-Books/06-comic.cbz` | *06-comic* | `previous` | `Gui` | 1 | 1.3 / 1.3 / 1.3 | 24.2 / 24.2 / 24.2 | 24.4 / 24.4 / 24.4 | 24.4 ms |
| `Test-Books/06-comic.cbz` | *06-comic* | `previous` | `Partial` | 11 | 3.2 / 3.3 / 3.3 | 227.4 / 236.7 / 238.4 | 227.6 / 236.9 / 238.5 | 238.9 ms |
| `Test-Books/08-optional.djvu` | *08-optional* | `next` | `Full` | 1 | 0.7 / 0.7 / 0.7 | 247.6 / 247.6 / 247.6 | 247.8 / 247.8 / 247.8 | 247.8 ms |
| `Test-Books/08-optional.djvu` | *08-optional* | `next` | `Partial` | 14 | 0.7 / 2.8 / 2.9 | 208.6 / 247.3 / 248.0 | 208.7 / 247.5 / 248.2 | 248.3 ms |
| `Test-Books/08-optional.djvu` | *08-optional* | `previous` | `Full` | 2 | 0.4 / 0.4 / 0.4 | 212.8 / 214.7 / 214.9 | 212.9 / 214.8 / 215.0 | 215.1 ms |
| `Test-Books/08-optional.djvu` | *08-optional* | `previous` | `Partial` | 13 | 0.7 / 0.8 / 0.9 | 206.7 / 221.8 / 227.7 | 206.9 / 222.0 / 227.9 | 229.4 ms |

## Findings

- Overall framebuffer submission P50/P95/P99: **230.6 / 582.0 / 1307.7 ms**.
- Slowest sample: **13957.1 ms** on `Test-Books/05-complex.pdf` (next, page 5 -> 6).
- `page_preparation_complete` is the dominant added cost on the complex PDF outliers; rasterization follows it closely.
- The normal EPUB, text PDF, CBZ, and DjVu samples are refresh-bound on this capture, with preparation remaining in the low-millisecond range.

## Confirmed, unknown, and next experiment

- Confirmed: complex-PDF latency is dominated by page preparation and subsequent rasterization, not input dispatch.
- Unknown: the exact MuPDF operation causing the multi-second preparation cost, optical visibility latency, and explicit cold/cached separation.
- Next experiment: add scoped timing around PDF page loading and pixmap generation, then compare the same complex-PDF pages before changing cache or rendering policy.

## Comparison with the previous baseline

| Metric | Baseline (2026-09-15, N=207) | Optimized (2026-09-16, N=227) |
| --- | ---: | ---: |
| Overall submission P50 | 230.4 ms | 230.6 ms |
| Overall submission P95 | 707.3 ms | 582.0 ms |
| Overall maximum | 14001.6 ms | 13957.1 ms |
| Complex PDF submission P50 | 713.8 ms | 725.2 ms |
| Complex PDF submission P95 | 12779.3 ms | 13663.4 ms |
| Complex PDF maximum | 14001.6 ms | 13957.1 ms |
| Complex PDF preparation maximum | 13791.6 ms | 13724.8 ms |

The optimized run reduces the overall P95 and maximum slightly, but the complex-PDF distribution is not an improvement: its P50 and P95 are within noisy variation or worse. The cache/text batch is therefore not accepted as a proven complex-PDF fix. The complex PDF remains the next profiling target; no further physical run is requested until a more targeted implementation batch is ready.
