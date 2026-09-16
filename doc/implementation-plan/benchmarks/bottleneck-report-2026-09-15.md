# Plato Benchmark Bottleneck Report

- Source: `benchmarks/results/kobo-libra-h2o-2026-09-15-matrix-02.jsonl`
- Records: **207**
- Units: milliseconds; percentiles use inclusive interpolation.

## Aggregation by book, direction, and update mode

| File | Title | Direction | Update | N | Prep P50/P95/P99 | Raster P50/P95/P99 | Submit P50/P95/P99 | Max submit |
| --- | --- | --- | --- | ---: | ---: | ---: | ---: | ---: |
| `Test-Books/01-simple.epub` | *Alice's Adventures in Wonderland* | `next` | `Full` | 2 | 0.4 / 0.4 / 0.4 | 235.6 / 241.2 / 241.7 | 235.7 / 241.3 / 241.8 | 241.9 ms |
| `Test-Books/01-simple.epub` | *Alice's Adventures in Wonderland* | `next` | `Partial` | 13 | 3.0 / 3.2 / 3.2 | 230.0 / 256.6 / 263.3 | 230.1 / 256.7 / 263.4 | 265.1 ms |
| `Test-Books/01-simple.epub` | *Alice's Adventures in Wonderland* | `previous` | `Full` | 1 | 3.0 / 3.0 / 3.0 | 230.8 / 230.8 / 230.8 | 231.0 / 231.0 / 231.0 | 231.0 ms |
| `Test-Books/01-simple.epub` | *Alice's Adventures in Wonderland* | `previous` | `Partial` | 14 | 4.0 / 4.6 / 4.6 | 230.3 / 243.4 / 252.4 | 230.5 / 243.6 / 252.6 | 254.9 ms |
| `Test-Books/02-images.epub` | *The Project Gutenberg Encyclopedia, Volume 1 of 28* | `next` | `Full` | 2 | 0.5 / 0.5 / 0.5 | 229.6 / 229.9 / 229.9 | 229.8 / 230.1 / 230.1 | 230.1 ms |
| `Test-Books/02-images.epub` | *The Project Gutenberg Encyclopedia, Volume 1 of 28* | `next` | `Partial` | 13 | 3.3 / 3.4 / 3.4 | 230.4 / 242.3 / 247.6 | 230.5 / 242.4 / 247.8 | 249.1 ms |
| `Test-Books/02-images.epub` | *The Project Gutenberg Encyclopedia, Volume 1 of 28* | `previous` | `Full` | 2 | 3.3 / 3.4 / 3.4 | 234.4 / 238.0 / 238.4 | 234.5 / 238.2 / 238.5 | 238.6 ms |
| `Test-Books/02-images.epub` | *The Project Gutenberg Encyclopedia, Volume 1 of 28* | `previous` | `Partial` | 18 | 3.4 / 4.7 / 5.5 | 231.0 / 238.4 / 238.7 | 231.2 / 238.6 / 238.9 | 238.9 ms |
| `Test-Books/03-large.epub` | *Les Misérables* | `next` | `Full` | 2 | 0.4 / 0.4 / 0.4 | 231.1 / 232.7 / 232.9 | 231.3 / 232.9 / 233.0 | 233.0 ms |
| `Test-Books/03-large.epub` | *Les Misérables* | `next` | `Partial` | 13 | 3.4 / 3.5 / 3.5 | 229.7 / 230.6 / 231.1 | 229.8 / 230.8 / 231.2 | 231.3 ms |
| `Test-Books/03-large.epub` | *Les Misérables* | `previous` | `Full` | 1 | 3.4 / 3.4 / 3.4 | 237.9 / 237.9 / 237.9 | 238.1 / 238.1 / 238.1 | 238.1 ms |
| `Test-Books/03-large.epub` | *Les Misérables* | `previous` | `Partial` | 14 | 3.7 / 4.2 / 4.2 | 230.0 / 235.5 / 237.1 | 230.1 / 235.7 / 237.3 | 237.6 ms |
| `Test-Books/04-text.pdf` | *04-text* | `next` | `Full` | 2 | 0.5 / 0.5 / 0.5 | 518.7 / 520.7 / 520.8 | 518.8 / 520.8 / 521.0 | 521.0 ms |
| `Test-Books/04-text.pdf` | *04-text* | `next` | `Partial` | 13 | 3.2 / 3.2 / 3.2 | 561.1 / 566.6 / 569.5 | 561.3 / 566.8 / 569.6 | 570.3 ms |
| `Test-Books/04-text.pdf` | *04-text* | `previous` | `Full` | 1 | 3.1 / 3.1 / 3.1 | 552.4 / 552.4 / 552.4 | 552.5 / 552.5 / 552.5 | 552.5 ms |
| `Test-Books/04-text.pdf` | *04-text* | `previous` | `Partial` | 14 | 29.5 / 37.7 / 37.9 | 557.4 / 584.7 / 584.9 | 557.5 / 584.8 / 585.1 | 585.1 ms |
| `Test-Books/05-complex.pdf` | *Wonder Comics #1 (Wonder Man story only) Comic* | `next` | `Partial` | 10 | 0.5 / 10379.4 / 11830.8 | 724.3 / 10606.7 / 12063.0 | 724.4 / 10606.9 / 12063.2 | 12427.3 ms |
| `Test-Books/05-complex.pdf` | *Wonder Comics #1 (Wonder Man story only) Comic* | `previous` | `Full` | 1 | 0.2 / 0.2 / 0.2 | 696.6 / 696.6 / 696.6 | 696.8 / 696.8 / 696.8 | 696.8 ms |
| `Test-Books/05-complex.pdf` | *Wonder Comics #1 (Wonder Man story only) Comic* | `previous` | `Partial` | 9 | 6.6 / 13277.2 / 13688.7 | 236.0 / 13486.8 / 13898.5 | 236.2 / 13486.9 / 13898.7 | 14001.6 ms |
| `Test-Books/06-comic.cbz` | *06-comic* | `next` | `Full` | 1 | 3.4 / 3.4 / 3.4 | 227.9 / 227.9 / 227.9 | 228.1 / 228.1 / 228.1 | 228.1 ms |
| `Test-Books/06-comic.cbz` | *06-comic* | `next` | `Partial` | 14 | 45.5 / 55.9 / 60.4 | 269.1 / 458.8 / 658.8 | 269.3 / 458.9 / 659.0 | 709.0 ms |
| `Test-Books/06-comic.cbz` | *06-comic* | `previous` | `Full` | 2 | 0.4 / 0.4 / 0.4 | 227.9 / 228.8 / 228.9 | 228.0 / 229.0 / 229.0 | 229.1 ms |
| `Test-Books/06-comic.cbz` | *06-comic* | `previous` | `Gui` | 2 | 1.4 / 1.4 / 1.4 | 24.2 / 24.2 / 24.2 | 24.3 / 24.3 / 24.3 | 24.3 ms |
| `Test-Books/06-comic.cbz` | *06-comic* | `previous` | `Partial` | 13 | 3.4 / 4.1 / 4.8 | 227.7 / 235.6 / 237.4 | 227.8 / 235.8 / 237.6 | 238.0 ms |
| `Test-Books/08-optional.djvu` | *08-optional* | `next` | `Full` | 1 | 0.7 / 0.7 / 0.7 | 207.9 / 207.9 / 207.9 | 208.1 / 208.1 / 208.1 | 208.1 ms |
| `Test-Books/08-optional.djvu` | *08-optional* | `next` | `Partial` | 14 | 10.6 / 17.5 / 23.4 | 211.4 / 222.0 / 223.7 | 211.6 / 222.1 / 223.9 | 224.3 ms |
| `Test-Books/08-optional.djvu` | *08-optional* | `previous` | `Full` | 2 | 0.4 / 0.4 / 0.4 | 211.3 / 212.0 / 212.0 | 211.5 / 212.1 / 212.2 | 212.2 ms |
| `Test-Books/08-optional.djvu` | *08-optional* | `previous` | `Partial` | 13 | 2.9 / 3.0 / 3.0 | 213.5 / 222.8 / 223.8 | 213.7 / 223.0 / 224.0 | 224.2 ms |

## Findings

- Overall framebuffer submission P50/P95/P99: **230.4 / 707.3 / 12674.0 ms**.
- Slowest sample: **14001.6 ms** on `Test-Books/05-complex.pdf` (previous, page 7 -> 6).
- `page_preparation_complete` is the dominant added cost on the complex PDF outliers; rasterization follows it closely.
- The normal EPUB, text PDF, CBZ, and DjVu samples are refresh-bound on this capture, with preparation remaining in the low-millisecond range.

## Confirmed, unknown, and next experiment

- Confirmed: complex-PDF latency is dominated by page preparation and subsequent rasterization, not input dispatch.
- Unknown: the exact MuPDF operation causing the multi-second preparation cost, optical visibility latency, and explicit cold/cached separation.
- Next experiment: add scoped timing around PDF page loading and pixmap generation, then compare the same complex-PDF pages before changing cache or rendering policy.
