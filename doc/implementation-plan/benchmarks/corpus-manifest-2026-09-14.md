# Baseline Corpus Manifest

Create one row for every file used in the baseline. Keep the files outside the
repository unless redistribution rights and repository size make committing
them appropriate.

| ID | Format | Description | Path or external reference | SHA-256 | Capability result |
| --- | --- | --- | --- | --- | --- |
| `epub-simple` | EPUB | Text-focused, short document | `~/forge-app/test-books/01-simple.epub` | `d6524a6b578de2fe63f9cf6e8be010158560ca32f05157e4fa58e6f210707d08` | `not-tested` |
| `epub-images` | EPUB | Image-heavy document | `~/forge-app/test-books/02-images.epub` | `36d5c23e55e85dbd90a0b3af20fbaebd99f5878af98c0d5156161bc546cd650e` | `not-tested` |
| `epub-large` | EPUB | Large document | `~/forge-app/test-books/03-large.epub` | `e6c571581c83d7be51a69e25968250828de0a88bcd8d33d59df6b788e34e144f` | `not-tested` |
| `pdf-text` | PDF | Text-focused document | `~/forge-app/test-books/04-text.pdf` | `2d7e903bc93f4cacba1489ebda89c8e670dbda2e570f019850222babdb00cfb6` | `not-tested` |
| `pdf-complex` | PDF | Complex layout document | `~/forge-app/test-books/05-complex.pdf` | `1b9aea5898b7777fd8527edf2647e27cb99766af04b0807756338a22aefaa299` | `not-tested` |
| `cbz-images` | CBZ | Image sequence | `~/forge-app/test-books/06-comic.cbz` | `35017b627d5863ed1be7ce4ec90ae818b7ec587a9471ed29b4b0848911c8d011` | `not-tested` |
| `cbr-images` | CBR | Image sequence | `~/forge-app/test-books/07-comic.cbr` | `e66fffc50310b8dc8a4af1d89a8491ce077416d87b87bf180e50a36be7760e4f` | `not-tested` |

Capability results must be one of `supported`, `unsupported`, or
`not-tested`, with a short reason when not supported. The CBR row is
intentional: current repository documentation does not confirm CBR support.

Optional format probe: `~/forge-app/test-books/08-optional.djvu` with SHA-256
`2d11563321653cacba420358d6e6d558e32dfe1ec439bdae74cfa02d36c9266f`.
