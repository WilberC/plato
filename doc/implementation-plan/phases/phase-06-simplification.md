# Phase 06: Simplify Around Measured Product Needs

## Phase metadata

- Status: planned
- Depends on: Phases 04-05
- Target: bounded reader surface, unused capabilities, and product-specific defaults

## Outcome

The fork has an explicit minimal product boundary based on measured performance value, without deleting reusable reader capabilities prematurely.

## Scope

- In: feature inventory, coupling review, safe disabling or decoupling experiments, regression validation.
- Out: a clean-slate rewrite and OPDS implementation.

## Tool ownership

| Operation | Project command | Output ownership | Outputs |
| --- | --- | --- | --- |
| Build and regression checks | Repository commands for affected crates | Reproducible tool-owned | Build/test artifacts |
| Feature comparison | Phase 02 benchmark runner | Intentional manual exception | Comparison report |

## Tasks

- [ ] P06-T01 Classify current Plato components as required, reusable, optional, or out of scope for the OPDS-first product.
  - Files: implementation-plan decision record and source inventory
  - Verify: V06-01
- [ ] P06-T02 Remove or isolate only low-value paths whose removal preserves supported reading behavior and improves a measured target.
  - Files: affected source modules and configuration
  - Verify: V06-02
- [ ] P06-T03 Re-run baseline and optimization scenarios to prove that simplification does not regress page-turn latency or supported formats.
  - Files: benchmark results
  - Verify: V06-02

## Validation milestones

- `V06-01` Review each proposed simplification against a named source dependency, measurement, and rollback path.
- `V06-02` Run build, focused tests, emulator smoke test, and representative Libra H₂O benchmark comparison.

## Parallelization

- Inventory and measurement review may proceed in parallel; source changes remain serial with regression validation.

## Risks and mitigations

- Removing an apparently unused path may break uncommon formats or device variants: preserve compatibility unless evidence and scope explicitly allow removal.

## Completion criteria

- [ ] Minimal product scope is documented.
- [ ] Simplification changes are individually reversible and benchmarked.
- [ ] Supported behavior retained by the product boundary is validated.

## Execution notes

- None yet.
