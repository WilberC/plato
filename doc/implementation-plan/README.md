# Kobo OPDS Reader Implementation Plan

## Plan metadata

- Status: in-progress
- Scope: Plato-based Kobo reader investigation and staged OPDS product path
- Target: `doc/implementation-plan/`
- Last updated: 2026-09-14

## Source inventory

| Source | Contribution | Confidence |
| --- | --- | --- |
| `README.md` | Confirms Kobo device support, including Libra H₂O, supported formats, and current reader capabilities. | confirmed |
| `doc/BUILD.md` | Defines the cross-compilation, distribution, and SDL2 emulator workflow. | confirmed |
| `doc/GUIDE.md` | Defines current installation and configuration behavior. | confirmed |
| `crates/plato/src/app.rs` | Shows the application event loop, input device selection, framebuffer construction, and existing timing primitive. | confirmed |
| `crates/core/src/input.rs` | Shows Linux input event ingestion and button/touch translation. | confirmed |
| `crates/core/src/framebuffer/kobo1.rs` and `crates/core/src/framebuffer/kobo2.rs` | Show Kobo framebuffer update and wait paths that can be instrumented. | confirmed |
| `doc/TODO.md` | Records existing reader gaps, including EPUB RTL, metadata, and applications. | confirmed |
| User-provided technical plan | Defines the performance-first objective, baseline-first sequencing, target formats, OPDS scope, and architecture decision gate. | confirmed |

## Objectives

- Establish a reproducible Plato baseline on a physical Kobo Libra H₂O before changing product behavior.
- Measure page-turn latency as a distribution, including cached and uncached forward/backward turns.
- Separate input, preparation, layout, rendering, framebuffer, and e-ink completion costs where the platform exposes them.
- Evaluate pre-rendering and bounded page caching against memory, CPU, ghosting, and energy trade-offs.
- Decide with measurements whether the fork should remain Plato-based or transition to a smaller architecture that reuses proven components.
- Add OPDS 1.2 only after the reading pipeline and performance decision are stable.

## Non-goals

- Rewriting EPUB, PDF, CBZ, or CBR engines before a measured limitation justifies it.
- Building a new Kobo backend before evaluating the existing framebuffer and input paths.
- Treating KFMon as part of the reader performance pipeline; it is only a launch/deployment option.
- Designing the complete final UI before the reading latency work is understood.
- Adding formats beyond EPUB, PDF, CBZ, and CBR without a product decision.

## Current-state summary

Plato already supports Kobo devices including Libra H₂O, provides an SDL2 emulator workflow, has a Rust workspace with separate core, emulator, and device application crates, and contains explicit Kobo input and framebuffer implementations. The repository does not yet contain this project's benchmark dataset, performance instrumentation, OPDS client, or a product-specific implementation plan. The exact Kobo firmware, hardware measurements, refresh configuration, and end-to-end optical latency are unknown.

## Proposed approach

Keep the first changes documentation and measurement-oriented. Pin the upstream commit and device configuration, run the unmodified reader, then add opt-in instrumentation that produces machine-readable measurements. Use the emulator for deterministic render and preparation benchmarks, but reserve physical-device tests for Kobo-specific input, framebuffer, refresh, memory, and energy behavior. Introduce optimizations only after a bottleneck is evidenced. Gate the fork-versus-rewrite decision on measured overhead rather than code cleanliness.

## Phase map

| Phase | Outcome | Depends on | Status |
| --- | --- | --- | --- |
| [Phase 01](phases/phase-01-baseline.md) | Reproducible unmodified Plato baseline on Libra H₂O | None | in-progress |
| [Phase 02](phases/phase-02-instrumentation.md) | Opt-in stage timing and benchmark output | Phase 01 | planned |
| [Phase 03](phases/phase-03-bottleneck-analysis.md) | Evidence-based bottleneck report | Phase 02 | planned |
| [Phase 04](phases/phase-04-page-turn-pipeline.md) | Measured page preparation and bounded pre-render/cache experiments | Phase 03 | planned |
| [Phase 05](phases/phase-05-framebuffer-eink.md) | Kobo refresh and visual-quality trade-off characterization | Phase 03 | planned |
| [Phase 06](phases/phase-06-simplification.md) | Reduced product scope based on measured value | Phases 04-05 | planned |
| [Phase 07](phases/phase-07-architecture-decision.md) | Fork-retention or component-reuse decision | Phase 06 | planned |
| [Phase 08](phases/phase-08-opds.md) | OPDS 1.2 catalog-to-offline-reading slice | Phase 07 | planned |

## Cross-cutting risks and decisions

- **Unknown physical limit:** The e-ink panel may dominate total latency; retain optical validation for representative runs.
- **Firmware variance:** Record the exact Libra H₂O firmware and repeat critical measurements after firmware changes.
- **Instrumentation distortion:** Keep instrumentation opt-in, lightweight, and separately comparable with release builds.
- **Memory pressure:** Bound cache size by measured available memory and document eviction behavior.
- **Refresh quality:** Evaluate ghosting and waveform choices together with latency, not as an isolated speed metric.
- **Architecture decision:** Do not migrate away from Plato without evidence that non-reusable overhead is materially larger than the physical display cost.

## Execution contract

- Execute phases in dependency order.
- Mark a checkbox complete only after its result and validation exist.
- Implement and test each coherent slice together.
- Use the repository's build, distribution, emulator, and test commands; never fabricate command results.
- Commit each coherent slice and its corresponding plan updates atomically.
- Preserve unrelated and pre-existing worktree changes.

Suggested invocation: `Implement phases 1 through 3`.
