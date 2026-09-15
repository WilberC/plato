# Baseline Corpus Manifest

Create one row for every file used in the baseline. The reproducible fixtures
are committed under `benchmarks/corpus/`; provenance and usage cautions are in
`benchmarks/corpus/LICENSES.md`.

| ID | Title | Format | Size | Path | SHA-256 | Capability result |
| --- | --- | --- | ---: | --- | --- | --- |
| `epub-simple` | *Alice's Adventures in Wonderland* — Lewis Carroll | EPUB | 136,519 B | `benchmarks/corpus/01-simple.epub` | `d6524a6b578de2fe63f9cf6e8be010158560ca32f05157e4fa58e6f210707d08` | `supported` |
| `epub-images` | *The Project Gutenberg Encyclopedia, Volume 1 of 28* | EPUB | 3,481,689 B | `benchmarks/corpus/02-images.epub` | `36d5c23e55e85dbd90a0b3af20fbaebd99f5878af98c0d5156161bc546cd650e` | `supported` |
| `epub-large` | *Les Misérables* — Victor Hugo | EPUB | 10,139,137 B | `benchmarks/corpus/03-large.epub` | `e6c571581c83d7be51a69e25968250828de0a88bcd8d33d59df6b788e34e144f` | `supported` |
| `pdf-text` | *The Adventures of Sherlock Holmes* | PDF, 193 pages | 2,240,627 B | `benchmarks/corpus/04-text.pdf` | `2d7e903bc93f4cacba1489ebda89c8e670dbda2e570f019850222babdb00cfb6` | `supported` |
| `pdf-complex` | *Wonder Comics #1* — Will Eisner | PDF, 16 pages | 7,797,875 B | `benchmarks/corpus/05-complex.pdf` | `1b9aea5898b7777fd8527edf2647e27cb99766af04b0807756338a22aefaa299` | `supported; very slow to open and navigate` |
| `cbz-images` | *Wonder Comics #1* image sequence | CBZ, 8 images | 11,356,301 B | `benchmarks/corpus/06-comic.cbz` | `35017b627d5863ed1be7ce4ec90ae818b7ec587a9471ed29b4b0848911c8d011` | `supported` |
| `cbr-images` | *Wonder Comics #1* image sequence | CBR | 33,450,434 B | `benchmarks/corpus/07-comic.cbr` | `e66fffc50310b8dc8a4af1d89a8491ce077416d87b87bf180e50a36be7760e4f` | `unsupported; excluded by current format list` |
| `djvu-optional` | *Dracula* — Bram Stoker | DjVu, 193 pages | 11,180,481 B | `benchmarks/corpus/08-optional.djvu` | `2d11563321653cacba420358d6e6d558e32dfe1ec439bdae74cfa02d36c9266f` | `supported` |

Capability results must be one of `supported`, `unsupported`, or
`not-tested`, with a short reason when not supported. The CBR row is
intentional: current repository documentation does not confirm CBR support.

The original exchange copies remain in `~/forge-app/test-books/` but are no
longer needed for benchmark setup.
