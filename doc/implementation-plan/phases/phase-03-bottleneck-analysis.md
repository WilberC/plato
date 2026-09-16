# Phase 03: Produce an Evidence-Based Bottleneck Report

## Phase metadata

- Status: in-progress
- Depends on: Phase 02
- Target: benchmark analysis tooling and result documentation

## Outcome

The project can attribute representative page-turn latency to input, preparation, rendering, framebuffer, driver completion, and the remaining physical-display interval.

## Scope

- In: repeated runs, distributions, cold/cached comparison, forward/backward comparison, resource observations, bottleneck report.
- Out: optimization changes.

## Tool ownership

| Operation | Project command | Output ownership | Outputs |
| --- | --- | --- | --- |
| Result parsing | Benchmark analysis command created in this phase | Reproducible tool-owned | Tables/plots generated from results |
| Device profiling | Existing platform tools plus documented commands | Intentional manual exception | CPU/RAM observations |
| Optical validation | Fixed camera/sensor procedure for sampled runs | Intentional manual exception | Optical latency evidence |

## Tasks

- [x] P03-T01 Implement aggregation for P50, P95, P99, sample count, and outlier visibility by document, direction, and refresh mode.
  - Files: benchmark analysis tooling
  - Verify: V03-01
- [ ] P03-T02 Run the complete baseline matrix on the Libra H₂O and correlate internal timestamps with resource observations and sampled optical measurements.
  - Files: result records and report
  - Verify: V03-02
- [x] P03-T03 Publish a bottleneck report that explicitly identifies confirmed costs, unknown costs, and the next experiment justified by each finding.
  - Files: implementation-plan execution notes or benchmark report
  - Verify: V03-02

## Validation milestones

- `V03-01` Feed known fixture data into the aggregator and verify exact percentile grouping and unit conversions.
- `V03-02` Review a real report containing all required scenarios and a conclusion supported by recorded measurements.

## Parallelization

- P03-T01 can proceed while the device matrix is prepared; P03-T02 and P03-T03 remain dependent on real results.

## Risks and mitigations

- Percentiles from too few samples are misleading: record sample counts and repeat until the report can distinguish noise from a stable difference.
- Optical measurements may be unavailable in every run: use them as periodic validation, not as the only performance signal.

## Completion criteria

- [ ] A reproducible report identifies the dominant costs for each representative scenario.
- [ ] The next optimization experiment is selected from evidence rather than intuition.
- [ ] No optimization is accepted without a before/after comparison plan.

## Execution notes

- 2026-09-15: Added `benchmarks/analyze.py` for reproducible P50/P95/P99 aggregation by book, direction, and update mode, with explicit outlier visibility.
- 2026-09-15: Analyzed the complete 207-record Libra H₂O capture. The complex PDF is the confirmed bottleneck: page preparation reaches 13.8 seconds on the slowest sample and rasterization/submission follows closely. Resource and optical measurements remain pending.
- 2026-09-16: Started the first bounded optimization experiment. MuPDF's internal resource cache is 64 MiB, and reader text extraction is now lazy with a three-location working-set bound. These changes require one complete before/after physical matrix before acceptance.

- 2026-09-16: Collected the optimized 227-record matrix. Overall P95 improved from 707.3 ms to 582.0 ms, but complex-PDF P50/P95 did not improve (725.2/13663.4 ms versus 713.8/12779.3 ms baseline), so the cache/text batch is not accepted as the complex-PDF fix.
