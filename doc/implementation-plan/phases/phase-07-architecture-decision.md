# Phase 07: Decide Whether to Retain Plato

## Phase metadata

- Status: planned
- Depends on: Phase 06
- Target: architecture decision record and benchmark evidence

## Outcome

The project records a reversible fork-retention or component-reuse decision supported by measured page-turn and resource data.

## Scope

- In: overhead attribution, reusable-component inventory, migration trigger, decision record.
- Out: implementing a new architecture before the decision is accepted.

## Tool ownership

| Operation | Project command | Output ownership | Outputs |
| --- | --- | --- | --- |
| Evidence generation | Phase 02 benchmark and analysis tools | Reproducible tool-owned | Reports and plots |
| Decision record | Markdown review | Source-owned | Architecture decision record |

## Tasks

- [ ] P07-T01 Quantify the share of latency attributable to render, framebuffer, physical refresh, and non-reusable Plato overhead.
  - Files: benchmark report
  - Verify: V07-01
- [ ] P07-T02 Record the decision to continue the fork or extract a smaller application, including retained libraries, migration boundaries, and explicit trigger conditions.
  - Files: architecture decision record under `doc/implementation-plan/`
  - Verify: V07-01
- [ ] P07-T03 Update the phase map and subsequent implementation scope to match the accepted decision.
  - Files: `doc/implementation-plan/README.md`, affected phase files
  - Verify: V07-02

## Validation milestones

- `V07-01` Two reviewers can trace each decision claim to a recorded measurement or explicitly marked unknown.
- `V07-02` The next phase has one unambiguous architecture target and no contradictory fork/rewrite assumptions.

## Parallelization

- None; this is a decision gate.

## Risks and mitigations

- A clean architecture may look attractive without improving the physical bottleneck: require a quantified expected gain before migration.

## Completion criteria

- [ ] The fork-versus-new-architecture decision is documented.
- [ ] Reuse and migration boundaries are explicit.
- [ ] The plan is internally consistent with the decision.

## Execution notes

- None yet.
