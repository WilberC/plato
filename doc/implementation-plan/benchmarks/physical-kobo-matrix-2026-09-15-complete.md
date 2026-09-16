# Physical Kobo Benchmark Matrix: 2026-09-15 (Complete Corpus)

## Run metadata

- Device: `Kobo Libra H₂O`
- Repository commit: `a3ffc5fb617594e9fa5bd809b7712c1ec9fa4eee`
- Capture mode: `Plato benchmark` via NickelMenu and physical page buttons
- Raw result: `benchmarks/results/kobo-libra-h2o-2026-09-15-matrix-02.jsonl`

## Results by book

| File | Title | Format | Samples | P50 submission | P95 submission | Max submission |
| --- | --- | --- | ---: | ---: | ---: | ---: |
| `Test-Books/01-simple.epub` | *Alice's Adventures in Wonderland* | `epub` | 30 | 230.4 ms | 253.2 ms | 265.1 ms |
| `Test-Books/02-images.epub` | *The Project Gutenberg Encyclopedia, Volume 1 of 28* | `epub` | 35 | 230.6 ms | 238.7 ms | 249.1 ms |
| `Test-Books/03-large.epub` | *Les Misérables* | `epub` | 30 | 230.0 ms | 236.3 ms | 238.1 ms |
| `Test-Books/04-text.pdf` | *The Adventures of Sherlock Holmes* | `pdf` | 30 | 560.5 ms | 580.2 ms | 585.1 ms |
| `Test-Books/05-complex.pdf` | *Wonder Comics #1 — Will Eisner* | `pdf` | 20 | 713.8 ms | 12779.3 ms | 14001.6 ms |
| `Test-Books/06-comic.cbz` | *Wonder Comics #1 image sequence* | `cbz` | 32 | 230.0 ms | 310.5 ms | 709.0 ms |
| `Test-Books/08-optional.djvu` | *Dracula — Bram Stoker* | `djvu` | 30 | 211.9 ms | 223.3 ms | 224.3 ms |

## Overall capture

- Total records: **207**.
- Directions: `next` 100, `previous` 107.
- Update modes: `Partial` 185, `Full` 20.

## Coverage

- Complete supported corpus captured: simple EPUB, image-heavy EPUB, large EPUB, text PDF, complex PDF, CBZ, and DjVu.
- CBR remains explicitly unsupported and is excluded from timing runs.
- The raw records contain automatic file path, display title, and format. The report uses the canonical corpus titles where Plato metadata fell back to the filename.
- The JSONL schema does not yet encode `cold` versus `cached`; the run sequence follows the documented procedure but those labels are not machine-readable.
- `framebuffer_completion` and `visible_page_ready` remain unobservable and are recorded as `null`.

## Next step

Use this complete corpus capture as the Phase 02 physical baseline, investigate the complex-PDF outliers, and then begin evidence-based performance optimization.
