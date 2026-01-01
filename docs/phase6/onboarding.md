# Phase 6 Onboarding – Performance & Remote Config

Use this checklist when a new contributor joins the project during/after Phase 6.

1. **Environment parity**
   - Flutter 3.22+, Dart 3.4+, melos, and supabase CLI installed.
   - Run `melos bootstrap` and `supabase link --project-ref <ref>`.
   - Copy `.env.deploy.example` → `.env.deploy` and request credentials for feature flag + theme RPC testing.
2. **Tooling overview**
   - `lib/src/experience` owns remote config/feature flags.
   - `lib/src/performance` contains profiler utilities, lazy list helpers, and isolate-based reducers.
   - Supabase migrations live under `supabase/migrations`. Phase 6 adds `20240620090000_phase6_performance_experience.sql`.
3. **Workflows**
   - Run `melos run build_runner` after touching Freezed models.
   - Use `melos run analyze` before pushing to ensure lint/format compliance.
   - For Supabase schema changes: update the SQL file, run `supabase db push`, then update the runbook if steps differ.
4. **Feature flag etiquette**
   - Add new flags to the SQL migration (or follow-up patch) with a clear owner + expiry date.
   - Document each flag under `docs/phase6/api/experience_config.md`.
   - Only gate UI toggles that genuinely need staged rollout; default off for risky changes.
5. **Performance profiling**
   - Enable the in-app dev overlay via flag `debug_performance_overlay` or run `flutter run --profile`.
   - Capture traces with `FrameTimingsMonitor` (logcat) when investigating jank.
   - For isolate-heavy operations, wrap conversions with `IsolatedMatrixBuilder.run(...)`.

When in doubt, open/update an ADR inside `docs/phase6/adr` so the rationale stays close to the code.
