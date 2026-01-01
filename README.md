# PaySettle

Foundational mono-repo for the PaySettle journeys + wallet platform. Project setup follows the multi-phase plan shared in the brief. This repo currently covers **Phase 0** — documentation, navigation flows, design tokens, and the base Flutter skeleton with melos + Supabase directories.

## Structure

```
.
├── apps/mobile        # Flutter Material 3 app (flavors: dev/stg/prod)
├── design             # Shared tokens consumed by app + other surfaces
├── docs/phase0        # Scope, journeys, navigation flows
├── supabase           # SQL migrations + edge functions
├── melos.yaml         # Workspace automation
└── analysis_options   # Shared linting
```

## Getting Started

1. Install Flutter 3.22+ and Dart 3.4+.  
2. `dart pub global activate melos`  
3. `melos bootstrap` (installs dependencies for all packages).  
4. Choose a flavor entry point:
   - Dev: `melos run app:dev` → `flutter run -t lib/main_dev.dart`
   - Staging: `melos run app:stg`
   - Prod: `melos run app:prod`
5. Enable `pre-commit install` to enforce formatting/lints/tests before every commit.

See `docs/phase0` for the agreed scope before implementing Phase 1 modules.

## Phase 1 – Core Platform Setup

Phase 1 brings the repo to an executable baseline. Highlights:

- 🔐 Supabase auth wiring (email/password + OAuth template points), token refresh, password reset, and biometric quick-login powered by `local_auth`.
- 🎨 Design foundation with generated tokens, typography stacks, responsive helpers, and localization scaffolding driven by ARB files.
- 🌐 Core infrastructure for network access (Supabase client + REST wrapper), Hive-based caching, error reporting via Sentry, and Riverpod-powered bottom navigation shell guards.

Run `../../tooling/flutter/bin/dart run build_runner build --delete-conflicting-outputs` inside `apps/mobile` when model changes are introduced to regenerate the Freezed code.

## Phase 2 – Journeys & Expense Management

- 📘 Documentation + UI contracts live in [`docs/phase2/README.md`](docs/phase2/README.md).
- 🗃️ Supabase schema, triggers, and RLS policies are defined via `supabase/migrations/20240506090000_phase2_journeys.sql`. Apply with `supabase db push`.
- 🔁 The `journey_reconcile` edge function (`supabase/functions/journey-reconcile`) powers Spending/Settlement matrix data + CSV/PDF export jobs surfaced in the Journeys screens.
- 🔑 Secrets for the edge function can be managed via `.env.deploy` (see `.env.deploy.example`) and applied with `supabase secrets set --env-file .env.deploy --project-ref <ref>`.

## Phase 3 – Wallet & Settlements

- 📘 Scope recap lives in [`docs/phase3/README.md`](docs/phase3/README.md).
- 💳 Migration `20240515090000_phase3_wallets.sql` bootstraps wallet contacts, payment methods, ledger tables, settlement events, and RPC helpers (`wallet_overview`, `wallet_transaction_history`).
- 📱 Flutter wallet module renders overview cards, timeframe selector, counterparty lists, and settlement log while sharing cache/network layers with journeys.

## Phase 4 – Budgeting, Insights, Notifications

- 📘 Detailed scope + acceptance criteria in [`docs/phase4/README.md`](docs/phase4/README.md).
- 🧾 Migration `20240522090000_phase4_budgeting_insights_notifications.sql` adds budget tables, analytics cache, notification registry, triggers, and RPC helpers (`budget_progress`, `evaluate_budget_alerts`, `insights_dashboard`, `notification_feed`, etc.).
- 📊 Flutter modules:
  - `lib/modules/budgeting` exposes budget cards, add-budget sheet, and alert chips (wired to Supabase RPC + Hive cache).
  - `lib/modules/insights` renders trend + pie charts using `fl_chart` with cached analytics payloads.
  - `lib/modules/notifications` streams grouped feeds (New/Earlier), hooks into Supabase Realtime, and supports mark-as-read/device registration flows.
