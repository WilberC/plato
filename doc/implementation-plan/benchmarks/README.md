# Plato Benchmarking

This directory stores source-controlled procedures, metadata templates, and
comparison tools for the performance-first plan. Device measurements and book
files are not committed by default; keep them in a gitignored location and
record their checksums in the manifest below.

## Phase 02 instrumentation

Instrumentation is disabled unless `PLATO_BENCHMARK=1`. The repeatable host
runner creates a JSON metadata sidecar and starts the headless emulator:

```sh
./benchmarks/run-instrumented.sh benchmarks/results/run-a.jsonl
./benchmarks/run-instrumented.sh benchmarks/results/run-b.jsonl
./benchmarks/compare.py benchmarks/results/run-a.jsonl benchmarks/results/run-b.jsonl
```

Each JSONL record contains a schema version, device model, book path, display
title, detected format, page identity before and after the turn, direction,
cache entry counts, requested update modes, and monotonic nanosecond stage
timestamps. `framebuffer_completion` and
`visible_page_ready` remain `null` because the current loop cannot observe those
boundaries reliably. The `*.meta.json` sidecar preserves the source commit,
host, and run start time.

The runner is POSIX shell and does not depend on Fish. It requires `python3`
and either an active `DISPLAY` or `xvfb-run`.

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

- Copy or link the committed files from `benchmarks/corpus/` into the emulator
  or Kobo test library. Do not use files with a different checksum.
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
