# Benchmark Corpus: Provenance and Usage

These files are committed only as reproducible, non-commercial test fixtures
for Plato development. They are not part of the Plato application or its
runtime distribution.

## Public-domain and Project Gutenberg works

- `01-simple.epub`: *Alice's Adventures in Wonderland*, Lewis Carroll,
  Project Gutenberg eBook 11.
- `02-images.epub`: *The Project Gutenberg Encyclopedia, Volume 1 of 28*,
  Project Gutenberg eBook 200.
- `03-large.epub`: *Les Misérables*, Victor Hugo, Project Gutenberg eBook 135.
- `04-text.pdf`: *The Adventures of Sherlock Holmes*, Project Gutenberg text
  edition.
- `08-optional.djvu`: *Dracula*, Bram Stoker, public-domain source.

The Project Gutenberg works must retain their Project Gutenberg attribution and
license terms. Sources: <https://www.gutenberg.org/ebooks/11>,
<https://www.gutenberg.org/ebooks/200>, and
<https://www.gutenberg.org/ebooks/135>. The Sherlock Holmes source should be
replaced with a manifest entry containing its exact Gutenberg identifier if the
original download URL is recovered.

## Comic fixtures

- `05-complex.pdf`: *Wonder Comics #1 (Wonder Man story only)*, Will Eisner.
- `06-comic.cbz`: CBZ image-sequence derivative of the comic PDF.
- `07-comic.cbr`: CBR archive of the same comic workload.

These three files are included to reproduce the observed complex-PDF, CBZ, and
CBR behavior. Their exact redistribution status was not embedded in the
downloaded files, so they are marked **test-only / provenance to verify** and
must not be redistributed outside this repository until a public-domain or
permissive source is documented. This caution does not affect benchmark use in
this private development repository.

The benchmark corpus is separate from the Plato license; adding these fixtures
does not grant any additional rights to the application.
