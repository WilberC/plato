# Plato Baseline Benchmark

This directory stores source-controlled procedures and metadata templates for
the Phase 01 baseline. Device measurements and book files are not committed by
default; keep them in a gitignored location and record their checksums in the
manifest below.

## Run order

1. Copy `baseline-record-template.md` to a dated record file.
2. Fill in the device, firmware, source, toolchain, build, and configuration
   fields before collecting timings.
3. Prepare the corpus described in `corpus-manifest-template.md` and record a
   SHA-256 checksum for every file.
4. Build the untouched checkout with `./build.sh`, package it with `./dist.sh`,
   and run `./run-emulator.sh` as the local smoke check.
5. Install the resulting distribution on the recorded Libra H₂O and run the
   fixed scenarios in the record template.
6. Preserve raw observations with the record; do not replace repeated samples
   with a single average.

## Fixed scenarios

- Open each corpus item from the library.
- Turn forward five times after the page is ready.
- Turn backward five times after the page is ready.
- Repeat one forward and one backward turn after revisiting the same pages
  (cached case).
- Repeat the first forward and backward turns after reopening the book (cold
  case).

Record unsupported formats explicitly as `unsupported`, including the reason;
do not silently omit them.

## Timing guidance

Use the device clock or a single external timing method consistently within a
run. For manual observations, record sample count and the observed range. Do
not present manual timings as internal pipeline timings; those are introduced
in Phase 02.
