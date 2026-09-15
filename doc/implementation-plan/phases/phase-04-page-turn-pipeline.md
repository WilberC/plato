# Phase 04: Optimize Page Preparation and Caching

## Phase metadata

- Status: planned
- Depends on: Phase 03
- Target: reader page preparation, scheduling, cache ownership, and memory accounting

## Outcome

The reader can evaluate bounded N+1/N+2 pre-rendering and backward-page retention using measured latency and memory trade-offs.

## Scope

- In: scheduler experiments, direction-aware priorities, bounded cache, cold/cached comparisons, cancellation and stale-result handling.
- Out: framebuffer waveform redesign and final architecture migration.

## Tool ownership

| Operation | Project command | Output ownership | Outputs |
| --- | --- | --- | --- |
| Build/test | Repository build and test commands discovered from the affected crates | Reproducible tool-owned | Build/test artifacts |
| Device benchmark | Phase 02 runner | Intentional manual exception | Comparison results |

## Tasks

- [ ] P04-T01 Define the page-cache contract for current, previous, next, and speculative pages, including memory bounds and invalidation rules.
  - Files: reader/core modules identified from Phase 03
  - Verify: V04-01
- [ ] P04-T02 Implement one bounded pre-render experiment with direction-aware scheduling and cancellation for obsolete requests.
  - Files: reader/page-preparation and scheduler modules
  - Verify: V04-01
- [ ] P04-T03 Compare cold, cached, forward, and backward page turns against the Phase 03 baseline and document CPU/RAM impact.
  - Files: benchmark results and report
  - Verify: V04-02

## Validation milestones

- `V04-01` Run focused tests for cache eviction, direction changes, duplicate requests, and cancellation; run the affected project build.
- `V04-02` Demonstrate a statistically meaningful comparison on the Libra H₂O with no incorrect page display or unbounded memory growth.

## Parallelization

- None; cache semantics and scheduler behavior must be reviewed as one coherent change.

## Risks and mitigations

- Speculative rendering can starve visible work: reserve capacity for the requested page and cancel low-priority work.
- Cache memory may vary by document: enforce a hard budget and expose evictions in benchmark output.

## Completion criteria

- [ ] Pre-rendering has a measured benefit or a documented reason for rejection.
- [ ] Cache behavior is bounded, correct, and observable.
- [ ] The experiment has a rollback path that preserves the baseline behavior.

## Execution notes

- None yet.
