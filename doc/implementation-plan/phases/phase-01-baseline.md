# Phase 01: Establish a Reproducible Plato Baseline

## Phase metadata

- Status: planned
- Depends on: None
- Target: `README.md`, `doc/BUILD.md`, benchmark metadata and external test data

## Outcome

An unmodified, pinned Plato build runs on the physical Kobo Libra H₂O and produces a repeatable baseline record for the agreed documents and page-turn scenarios.

## Scope

- In: hardware/firmware identification, pinned source revision, stable test corpus, launch workflow, baseline observations.
- Out: product code changes, OPDS, performance optimization, and KFMon-specific benchmarking.

## Tool ownership

| Operation | Project command | Output ownership | Outputs |
| --- | --- | --- | --- |
| Cross-compile | `./build.sh` | Reproducible tool-owned | Build artifacts outside the source plan |
| Package distribution | `./dist.sh` | Reproducible tool-owned | Distribution archive |
| Emulator smoke test | `./run-emulator.sh` | Reproducible tool-owned | None |
| Physical-device observations | Documented benchmark procedure | Intentional manual exception | Hardware and baseline records |

## Tasks

- [ ] P01-T01 Record the Libra H₂O model identifier, firmware version, resolution, storage/memory assumptions, refresh settings, source commit, and build toolchain versions.
  - Files: `doc/implementation-plan/` benchmark records or a future benchmark directory
  - Verify: V01-01
- [ ] P01-T02 Assemble a stable representative corpus covering simple EPUB, image-heavy EPUB, large EPUB, text PDF, complex PDF, CBZ, and CBR where supported by the current build.
  - Files: external or gitignored benchmark data plus manifest metadata
  - Verify: V01-01
- [ ] P01-T03 Run the untouched build through fixed forward, backward, cold, cached, and book-opening scenarios and record repeated observations without changing Plato behavior.
  - Files: baseline result record
  - Verify: V01-02

## Validation milestones

- `V01-01` Confirm `./build.sh`, `./dist.sh`, and `./run-emulator.sh` use the pinned revision successfully, and confirm the corpus manifest is stable.
- `V01-02` Confirm the same device, firmware, corpus, and scenario can be repeated and produces a baseline report with sample counts and P50/P95/P99 where available.

## Parallelization

- P01-T01 and P01-T02 may run in parallel; P01-T03 depends on both.

## Risks and mitigations

- Manual timing is imprecise: use it only as an initial baseline and replace internal stages with instrumentation in Phase 02.
- Unsupported or unavailable CBR behavior may invalidate a corpus case: record it as an explicit capability result rather than silently skipping it.

## Completion criteria

- [ ] The exact hardware, firmware, source revision, and corpus are recorded.
- [ ] An untouched Plato build runs on the Libra H₂O.
- [ ] Baseline scenarios and repeatability evidence exist.

## Execution notes

- None yet.
