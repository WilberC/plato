# Phase 08: Add the OPDS-First Product Slice

## Phase metadata

- Status: planned
- Depends on: Phase 07
- Target: OPDS client, catalog navigation, download/cache integration, and local reading entry point

## Outcome

The product can connect to an OPDS 1.2 catalog, browse entries, download a supported book, cache it locally, and open it in the validated reading pipeline.

## Scope

- In: OPDS 1.2 discovery/navigation/download flow, local cache, offline opening, supported EPUB/PDF/CBZ/CBR entry points.
- Out: broad OPDS version coverage, social/library features, and unrelated reader configuration expansion.

## Tool ownership

| Operation | Project command | Output ownership | Outputs |
| --- | --- | --- | --- |
| Build | Repository build/distribution commands | Reproducible tool-owned | Build artifacts |
| OPDS protocol tests | Focused test runner introduced with the client | Reproducible tool-owned | Test reports/fixtures |
| Device flow validation | Instrumented device runner | Intentional manual exception | Compatibility results |

## Tasks

- [ ] P08-T01 Define the minimal OPDS 1.2 catalog, acquisition, authentication, and download contracts needed by the product.
  - Files: OPDS client modules and protocol fixtures
  - Verify: V08-01
- [ ] P08-T02 Implement catalog browsing, download, bounded local caching, and offline book opening without bypassing the validated reading pipeline.
  - Files: OPDS, cache, navigation, and integration modules
  - Verify: V08-01
- [ ] P08-T03 Validate the complete connect-to-read flow and confirm that OPDS work does not regress page-turn performance or startup behavior.
  - Files: integration tests and device benchmark results
  - Verify: V08-02

## Validation milestones

- `V08-01` Run protocol fixtures for valid, paginated, authenticated, malformed, and unavailable acquisition feeds.
- `V08-02` Complete a physical Libra H₂O flow from catalog connection to offline reading and compare performance with the pre-OPDS baseline.

## Parallelization

- Protocol fixtures and cache contract can proceed in parallel; device integration depends on both.

## Risks and mitigations

- Remote catalogs vary in metadata and authentication behavior: keep the first contract small, explicit, and fixture-tested.
- Network work can block reading: downloads and cache writes must be isolated from the page-turn path.

## Completion criteria

- [ ] A supported OPDS 1.2 server can deliver a book into the local cache.
- [ ] Cached books open offline through the validated reader pipeline.
- [ ] Page-turn and startup regressions are measured and rejected.

## Execution notes

- None yet.
