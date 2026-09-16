# Phase 05: Characterize Framebuffer and E-Ink Trade-offs

## Phase metadata

- Status: planned
- Depends on: Phase 03
- Target: `crates/core/src/framebuffer/`, refresh configuration, benchmark analysis, visual validation

## Outcome

The project understands the measurable cost and visual quality of update modes, dirty regions, waits, and full versus partial refreshes on the Libra H₂O.

## Scope

- In: framebuffer submission/completion, dirty regions, update modes, ghosting observations, sampled optical validation.
- Out: platform backend rewrite and permanent refresh-policy changes without evidence.

## Tool ownership

| Operation | Project command | Output ownership | Outputs |
| --- | --- | --- | --- |
| Build | `./build.sh` | Reproducible tool-owned | Build artifacts |
| Device refresh experiments | Instrumented benchmark runner | Intentional manual exception | Timing and quality results |

## Tasks

- [ ] P05-T01 Map the existing Kobo framebuffer submission and wait paths to the instrumentation schema.
  - Files: `crates/core/src/framebuffer/kobo1.rs`, `crates/core/src/framebuffer/kobo2.rs`, related modules
  - Verify: V05-01
- [ ] P05-T02 Run controlled update-mode and region-size experiments while recording latency, ghosting, and visual quality observations.
  - Files: benchmark results and report
  - Verify: V05-02
- [ ] P05-T03 Select only refresh changes that improve perceived page turns without unacceptable ghosting, or record that the physical refresh dominates.
  - Files: implementation-plan execution notes and affected source if applicable
  - Verify: V05-02

## Validation milestones

- `V05-01` Verify every reported framebuffer boundary corresponds to a real submission or completion path in the Kobo implementation.
- `V05-02` Review paired timing and visual-quality results for each candidate update mode.

## Parallelization

- Phase 04 and P05-T01 may proceed independently after Phase 03; P05-T02 requires the instrumentation contract.

## Risks and mitigations

- Aggressive partial refresh can accumulate ghosting: include repeated-turn and full-refresh recovery scenarios.
- Driver behavior can vary by Kobo generation: constrain conclusions to the recorded Libra H₂O firmware unless reproduced elsewhere.

## Completion criteria

- [ ] Framebuffer and driver costs are separated from render costs.
- [ ] Visual-quality trade-offs are recorded alongside timing.
- [ ] Any refresh change has a reproducible rollback and comparison result.

## Execution notes

- None yet.
