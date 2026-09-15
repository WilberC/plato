# Phase 02: Add Opt-In Pipeline Instrumentation

## Phase metadata

- Status: in-progress
- Depends on: Phase 01
- Target: `crates/plato/src/app.rs`, `crates/core/src/input.rs`, `crates/core/src/framebuffer/`, benchmark output code and configuration

## Outcome

An opt-in benchmark build records machine-readable timestamps for page-turn stages without changing normal release behavior.

## Scope

- In: monotonic timestamps, page-turn correlation IDs, stage records, CSV/JSON output, build-time or runtime opt-in.
- Out: pre-rendering, cache policy, refresh tuning, and visual-quality changes.

## Tool ownership

| Operation | Project command | Output ownership | Outputs |
| --- | --- | --- | --- |
| Compile target | `./build.sh` | Reproducible tool-owned | Build artifacts |
| Emulator check | `./run-emulator.sh` | Reproducible tool-owned | None |
| Device result capture | Benchmark runner defined by the implementation | Intentional manual exception | CSV/JSON result files |

## Tasks

- [ ] P02-T01 Add an opt-in measurement contract covering input receipt, page preparation, layout, rasterization, framebuffer submission, framebuffer completion, and visible-page readiness where observable.
  - Files: `crates/plato/src/app.rs`, relevant core document/view/framebuffer modules
  - Verify: V02-01
- [ ] P02-T02 Emit stable machine-readable records with page identity, direction, cache state, update mode, and monotonic timestamps while keeping the default build path disabled.
  - Files: benchmark logging module and configuration path
  - Verify: V02-01
- [ ] P02-T03 Add a repeatable command or script to launch the benchmark build, collect results, and preserve the source/device metadata with each run.
  - Files: `scripts/` or benchmark tooling discovered during implementation
  - Verify: V02-02

## Validation milestones

- `V02-01` Run an instrumented emulator/device smoke test and verify stage ordering, non-negative durations, stable schema, and no benchmark output in default mode.
- `V02-02` Collect two runs from the same scenario and confirm they can be parsed and compared without manual transcription.

## Parallelization

- None; the event contract must be agreed before logging and collection are finalized.

## Risks and mitigations

- Timing calls can perturb short stages: use monotonic clocks, avoid allocations in hot paths, and compare enabled/disabled builds.
- Framebuffer completion may represent driver completion rather than optical completion: label the boundary precisely and keep visual validation separate.

## Completion criteria

- [ ] Instrumentation is disabled by default.
- [ ] Stage records are parseable and correlated to individual page turns.
- [ ] Enabled and disabled builds are both validated.

## Execution notes

- 2026-09-15: Added opt-in JSONL page-turn instrumentation in the application
  loop. It records page identity, direction, cache counts, update modes, and
  monotonic boundaries for input receipt, page preparation, rasterization, and
  framebuffer submission. Completion and optical readiness remain explicitly
  unobservable.
- 2026-09-15: Added `benchmarks/run-instrumented.sh` and `benchmarks/compare.py`
  for repeatable headless runs and metadata-preserving comparison. The
  device-compatible ARM builder is now available through
  `build-kobo-compatible.sh`; physical Kobo validation remains pending.
