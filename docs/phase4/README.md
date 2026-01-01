# Phase 4 – Budgeting, Insights, Notifications

Phase 4 layers the budgeting experience, analytics dashboards, and realtime notification center on top of the journeys + wallet work completed earlier. This file documents the locked scope, data contracts, Supabase changes, and Flutter implementation notes that now live in the repo.

## 1. Scope & Goals

- **Budgeting engine** – Category-level budgets with thresholds, recurrence rules, alerting, and roll-up metrics. Users can create budgets per category, inspect progress cards, and review alerts for each cycle.
- **Insights & reports** – Visualize spending trends, category breakdowns, and recent transactions using cached analytics (via Supabase RPC + local Hive cache) and rendered with `fl_chart`.
- **Notifications hub** – Merge budget alerts, wallet settlement events, and manual reminders into a grouped (New/Earlier) notification center backed by Supabase Realtime.

## 2. Supabase Schema & Functions

Migration `20240522090000_phase4_budgeting_insights_notifications.sql` introduces the following:

| Table | Purpose |
| --- | --- |
| `budget_rules` | Owner-scoped category budgets with recurrence, thresholds, and metadata. |
| `budget_alerts` | Records per-period alerts (threshold/critical/reset) and links to notifications via trigger. |
| `analytics_snapshots` | Server-side cache for expensive analytics payloads (insights dashboard, future reports). |
| `notifications` | Unified notification feed with severity, topic, source, and CTA payloads (Realtime enabled). |
| `notification_devices` | Device/token registry used for Supabase Realtime + future FCM/Push tokens. |
| `notification_preferences` | Owner-level toggles for push/realtime channels and quiet hours. |

Key SQL helpers:

1. `budget_progress(p_month date)` – Aggregates spending per budget (from `expenses`) for the requested month, returning totals, thresholds, alert history, and trend points.
2. `evaluate_budget_alerts(p_month date)` – Iterates over `budget_progress` output to insert `budget_alerts` entries when thresholds are crossed. Alerts automatically spawn rows in `notifications` via trigger `handle_budget_alert_notification`.
3. `insights_dashboard(p_timeframe text, p_force_refresh bool)` – Builds a cached JSON payload with total spent, average daily spend, change vs previous period, trendline, category breakdown, and recent transactions. Results are saved to `analytics_snapshots` with TTL (~10 minutes).
4. `notification_feed(p_limit int)` – Returns grouped arrays (`new`, `earlier`) for the notification center UI. Companion helpers `notification_mark_read` and `register_notification_device` expose mutations for read state + device registry.
5. Wallet trigger `handle_wallet_event_notification` converts settlement reminders/payments into feed items so automation hooks budget + wallet surfaces.

All new tables have timestamp triggers (`handle_updated_at`), RLS policies scoped to `owner_id`, and `notifications` is added to the `supabase_realtime` publication.

## 3. Flutter Implementation Highlights

### Budgeting Module (`lib/modules/budgeting`)

- Domain uses Freezed (`BudgetSummary`, `BudgetOverview`, `BudgetAlert`, `BudgetCategoryOption`) with Riverpod use cases (`GetBudgetsUseCase`, `CreateBudgetUseCase`, etc.).
- `BudgetRepositoryImpl` fetches Supabase RPC output, caches payloads to Hive, and maps to rich UI models. A remote data source wraps `budget_progress`, `evaluate_budget_alerts`, and `budget_rules` inserts.
- `BudgetingPage` renders:
  - Range selector (Previous/Current/Next month) with `SegmentedButton`.
  - Overview hero cards (limit/spent/remaining + alert pills).
  - List of category budgets with progress bars, threshold/reset metadata, and alert chips.
  - `AddBudgetSheet` bottom sheet for creating budgets with form validation, recurrence selector, and category dropdown.

### Insights Module (`lib/modules/insights`)

- `InsightsRepositoryImpl` consumes `insights_dashboard`, caches responses by timeframe, and feeds `InsightsController`.
- `InsightsPage` presents hero numbers, a `fl_chart` line chart for trends, pie chart for category breakdown, and a recent activity list. Timeframes (7d/30d/90d/365d) are switchable through the segmented control with pull-to-refresh hooking into `p_force_refresh`.

### Notifications Module (`lib/modules/notifications`)

- Repository maps RPC feed JSON → `NotificationFeed` and caches offline. Graph includes use cases for fetching, marking read, and device registration.
- `NotificationsRealtimeService` subscribes to Supabase Realtime (`public:notifications`) and streams insert events into the controller so new alerts appear instantly.
- `NotificationsPage` groups feed items (“New” vs “Earlier”), differentiates unread cards, exposes “Mark read”, and displays severity/type with icons/colors matching the design tokens. Live indicator lights up once realtime connection receives events.

## 4. Caching, Performance, and Telemetry

- **Server cache** – `analytics_snapshots` prevents re-running heavy joins for every insights request. Budget alerts leverage RPC + trigger automation to avoid polling from the client.
- **Client cache** – Hive caches (see `CacheKeys`) hold budget overviews, categories, insights dashboard payloads, and notification feeds. Repositories transparently fall back to cached data when offline.
- **Charts** – `fl_chart` drives the trendline + pie chart; data is normalized to simple DTOs so alternative chart libs can be swapped later if needed.
- **Realtime** – Budget + wallet triggers push rows into `notifications`, and Supabase Realtime propagates inserts to the app. A lightweight device registration hits `register_notification_device` so server-side jobs can target channels beyond realtime (future FCM).

## 5. Next Steps / Phase 5 Dependencies

- **Settings & Integrations** – Phase 5 will extend notification preferences UI, expose CSV/PDF export toggles, and add connectors (accounting APIs) that can reuse `notification_devices`.
- **Security** – Phase 5 will introduce biometric toggles and additional audit logging that should piggyback on the notifications + analytics infrastructure laid here.
- **QA** – Widget/unit tests should expand around the new controllers and repositories; snapshot tests for charts/themes will be introduced when the design tokens stabilize.
