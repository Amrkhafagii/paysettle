# Phase 6 – Performance & Experience Configuration

Phase 6 focuses on hardening the PaySettle mobile client for production-scale usage. The main pillars are runtime performance profiling, lazy data delivery, remote-controlled feature rollout, and the documentation loop required to keep the repo maintainable for the long term.

## 1. Scope & Goals

- **Performance-first UX** – Profile frame times & animation jank, lazy load long lists (wallet, contacts, journeys), and move expensive table reductions into background isolates.
- **Experience configuration** – Drive feature availability, theming, and experiments off Supabase tables/RPC so we can stage rollouts per cohort without extra releases.
- **Documentation & operations** – Capture ADRs, API contracts, onboarding guides, and Supabase migration runbooks so every phase stays auditable.

The reference UI comes from the Phase 6 design set (see `/design/phase6` or the screenshots in the issue brief). The components already implemented in earlier phases inherit their visuals but now respect dynamic tokens supplied by the remote theming system.

## 2. Supabase Schema & Functions

Migration `20240620090000_phase6_performance_experience.sql` introduces:

| Artifact | Purpose |
| --- | --- |
| `experience_feature_flags` | Stores flag metadata, rollout percentages, targeting rules, and payloads used by the client to gate functionality. |
| `experience_themes` | JSON payloads describing brand + neutral palettes, typography tweaks, and component radius tokens per variant. |
| `experience_theme_assignments` | Maps a user/org to the theme variant they should receive. Defaults fall back to the active theme. |
| `experience_flag_audits` | Append-only audit of flag changes + user targeting decisions for compliance. |
| `performance_sessions` & `performance_samples` | Persist client-side profiling results aggregated by session so the ops team can investigate regressions.
| `experience_config()` | RPC returning feature flags + effective theme in a single payload.
| `log_performance_session()` | RPC for the mobile app to push the profiled metrics blob (frame times, dropped frames, isolate cost, etc.).

Every table is protected with RLS; flag/theme reads are `using (true)` so authenticated clients can pull but inserts/updates require service role/admin API.

## 3. Flutter Implementation Highlights

### Remote Experience Module (`lib/src/experience`)

- `ExperienceConfigRepository` fetches `experience_config` RPC results, caches them in Hive (`CacheBox.runtime`), and exposes `ExperienceConfig`/`FeatureFlag` models (Freezed) to the app.
- `experienceConfigProvider` keeps the latest config in Riverpod. `FeatureFlagService` offers helpers (`isEnabled`, `variant`, `payload<T>`) so UIs can lazily read gates.
- `ThemeOverrideProvider` pipes the remote palette into the Material theme builders. Primary/secondary/surface colors update on the fly once a config lands.

### Performance Toolkit (`lib/src/performance`)

- `FrameTimingsMonitor` listens to `SchedulerBinding.instance.addTimingsCallback`, aggregates metrics (avg frame duration, worst jank) and exposes them for analytics + logging.
- `LazyDataListView` widget + `LazyDataController` manage batched fetching with `ScrollController` thresholds, powering contacts/wallet feeds.
- `IsolatedMatrixBuilder` uses `compute()` to transform large journey settlement matrices without blocking UI.

### Module Touch Points

- Contacts, Wallet, Journeys, Notifications now optionally request more rows via the shared lazy controller.
- `JourneysTable` uses `IsolatedMatrixBuilder` when shaping large per-person/per-category tables.
- `NotificationsPage` surfaces remote flag-driven CTAs (example: enabling CSV exports once the flag is toggled).

## 4. Performance Observability

- Frame timings + dropped frames stored locally and shipped with `log_performance_session()` on background syncs.
- `PerformanceOverlayBanner` (dev builds) can be toggled via the new `debug_performance_overlay` feature flag.
- Cache hit rate + lazy load telemetry logged through `logging` package, enabling Sentry breadcrumb correlation.

## 5. Documentation & Operational Artifacts

- ADR: [`docs/phase6/adr/0001-performance-pipeline.md`](adr/0001-performance-pipeline.md)
- API Contract: [`docs/phase6/api/experience_config.md`](api/experience_config.md)
- Supabase Runbook: [`docs/phase6/runbooks/supabase_phase6.md`](runbooks/supabase_phase6.md)
- Onboarding Guide: [`docs/phase6/onboarding.md`](onboarding.md)

These documents cover why we chose the current architecture, how the payloads are shaped, and the exact commands to migrate/apply secrets in new environments.

## 6. Next Steps

- Expand `performance_samples` aggregation into scheduled Supabase jobs for trend dashboards.
- Fold the remote config payload into the settings UI so admins can preview theme variants before publishing.
- Add widget tests for `LazyDataListView` and instrumentation tests for the performance banner toggle once CI devices are wired.
