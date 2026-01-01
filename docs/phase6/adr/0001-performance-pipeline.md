# ADR 0001 – Unified Performance & Experience Config Pipeline

**Date:** 2024-06-20  
**Status:** Accepted  
**Context:** Phase 6 requires runtime performance profiling, lazy loading, and configuration-driven experiences without fragmenting the Flutter app.

## Decision

1. **Remote config via Supabase RPC** (`experience_config`)
   - Flags + theme tokens live in relational tables with JSON payloads.
   - The client fetches a single RPC to hydrate both features & theming, reducing cold start latency.
2. **Frame timings + lazy loading instrumentation**
   - `FrameTimingsMonitor` subscribes to the Flutter scheduler and emits aggregated metrics.
   - Shared `LazyDataController`/`LazyDataListView` coordinate pagination so each module does not reinvent infinite scroll.
3. **Isolate offloading**
   - Expensive settlement matrix building is executed via `compute()` helpers to prevent frame drops on budget/journey tables.
4. **Documentation requirements**
   - Every new feature flag or RPC must have a short entry inside `docs/phase6/api`.
   - Supabase migrations include runbook steps for apply/rollback.

## Consequences

- **Pros**
  - Centralized staging of experiments & theming; no duplicate HTTP calls.
  - Observable performance metrics (client + DB) for regressions.
  - Shared lazy list + isolate helpers reduce duplicated stateful widgets.
- **Cons**
  - RPC adds slight complexity to Supabase (requires service role to seed data).
  - Remote theming introduces rebuild churn when config streams in late; mitigated via caching.
  - Profiling data must be pruned; runbook covers TTL jobs.

## Alternatives Considered

- **Firebase Remote Config** – Rejected to avoid extra infra + SDK weight.
- **Per-module feature flags** – Dismissed because it fragments targeting logic and complicates Supabase auditing.
- **Only local theming overrides** – Would require app updates for any brand tweak, blocking staged rollouts.
