# Phase 2 – Journeys & Expense Management

Phase 2 turns the Phase 0/1 foundations into a working experience around shared journeys, expenses, and settlements. This document lists the now locked scope, data contracts, Supabase requirements, and Flutter implementation notes derived from the UI references that the team aligned on. Treat this file (together with the SQL/Edge artifacts checked in this phase) as the acceptance criteria before moving on to wallet/budgeting phases.

## 1. Scope & KPIs

- **Journeys lifecycle**: Create/manage journeys with Active/Past/Calendar filters, inspect collaborative ledgers, and run dispute/enquiry/export workflows.
- **Expense tooling**: Spreadsheet-like entry for each participant, Add/Edit form for transactional details, evidence uploads, and per-participant balances.
- **Settlement visibility**: Real-time matrix (Spending vs Settlement tabs) + CTA rail (Add/Edit, Inspect, Export, Dispute/Enquire) in every journey.
- **Data trust**: Optimistic edits, background refresh, pull-to-refresh, and full offline cache so on-device changes safely sync once connectivity returns.

## 2. Domain Model

| Entity | Purpose | Key Fields |
| --- | --- | --- |
| `journeys` | Top-level trip/event container. | `id`, `owner_id`, `org_id`, `title`, `status (planned/active/settled)`, `start_on`, `end_on`, `currency`, `cover_image`, `totals` JSON cache, `created_at`, `updated_at` |
| `journey_participants` | Membership + balances per participant. | `journey_id`, `profile_id`, `role (owner, editor, viewer)`, `state (invited/confirmed/left)`, `amount_paid`, `amount_owed`, `net_balance`, `settlement_status` |
| `categories` | Shared taxonomy for expenses (across journeys). | `id`, `slug`, `label`, `icon`, `color`, `type (system/custom)`, `owner_id?` |
| `expenses` | Individual ledger entry. | `id`, `journey_id`, `payer_id`, `category_id`, `amount`, `split_type (equal, exact, percentage, shares)`, `notes`, `status`, `receipt_url`, `occurred_on`, `created_at`, `updated_at` |
| `expense_shares` | Normalized split resolved to each participant and used for settlements. | `expense_id`, `participant_id`, `share_amount`, `share_percent`, `is_payer` |
| `settlement_actions` | Actions taken towards reconciliation (requests, payments, disputes, enquiries). | `id`, `journey_id`, `initiator_id`, `target_id`, `action_type`, `status`, `amount`, `payload`, `proof_url`, `created_at` |
| `journey_activity_log` | Auditable log for timeline feeds + dispute evidence. | `id`, `journey_id`, `actor_id`, `verb`, `data`, `created_at` |

Relationships: `journeys` ←→ `journey_participants` (many-to-many), `journeys` ←→ `expenses` (one-to-many), `expenses` ←→ `expense_shares` (one-to-many), `journeys` ←→ `settlement_actions` (one-to-many). `categories` is referenced by `expenses` but owned globally. All person references point to `profiles.id` (Phase 1) which in turn maps to `auth.users`.

## 3. Postgres Schema & Guards

The migration `supabase/migrations/20240506090000_phase2_journeys.sql` contains the concrete DDL. Highlights:

1. **Tables & constraints**: All PKs use `uuid` defaulting to `gen_random_uuid()`. Monetary fields use `numeric(14,2)` and we store `currency` on journeys + copy onto settlement actions for clarity.
2. **Computed JSON caches**: `journeys.totals` caches aggregate per-category + participant stats for quick list rendering. A trigger keeps it consistent (see below) while additional analytics come from RPC calls.
3. **Triggers**:
   - `set_timestamps()` runs on every table to update `updated_at` columns.
   - `recompute_journey_totals()` fires after insert/update/delete of `expenses` & `expense_shares` to keep `journeys.totals`, `journey_participants.amount_paid`, and `journey_participants.amount_owed` aligned.
   - `mark_settlement_state()` recalculates `journey_participants.settlement_status` when `settlement_actions` change status.
4. **RLS Policies**:
   - Tables inherit `ENABLE ROW LEVEL SECURITY`.
   - **Journeys**: owner/participants of the same `org_id` can `SELECT`; write operations restricted to `role` in `journey_participants` (`owner` or `editor`).
   - **Expenses & shares**: policy ensures both the journey membership check and `payer_id = auth.uid()` for destructive edits to avoid tampering.
   - **Settlement actions**: `initiator_id = auth.uid()` for inserts, plus target/owner can view.
5. **Indexes**: Partial indexes created on `journeys(status)` for filtering Active/Past, `expenses(journey_id, occurred_on DESC)`, and `settlement_actions(journey_id, created_at DESC)` to match UI queries.

## 4. Supabase Functions & Edge Handlers

| Artifact | Location | Purpose |
| --- | --- | --- |
| `journey_reconcile` edge function | `supabase/functions/journey-reconcile/index.ts` | Serverless endpoint invoked from the app to compute the matrix shown on Spending/Settlement tabs. Accepts `journeyId`, queries the DB via service key, aggregates totals per category + per participant, and returns payload ready for charts, CTA badges, and PDF/CSV exports. Also enforces `org_id` membership before returning data. |
| `persistExport` helper (stub) | `supabase/functions/journey-reconcile/index.ts` | Uploads CSV (plus placeholder JSON payload for PDF) to Supabase Storage. Later phases can replace the stub with a proper PDF renderer or queue-driven job. |
| SQL helper `rpc.journey_dashboard` | defined inline inside the migration | Materialized view-like RPC used for the "My Journeys" dashboard; returns per-journey stats filtered by timeframe.
| SQL helper `rpc.journey_expense_sheet` | defined inline | Provides paginated expenses with `expense_shares` expanded for the spreadsheet grid and Add/Edit form hydration.

The edge function is written in TypeScript targeting Supabase's `deno` runtime and keeps logic minimal (delegating heavy lifting to SQL). It exposes `/journey-reconcile` via POST.

## 5. Flutter Journeys Module Implementation Notes

1. **Navigation Shell** – keep existing bottom navigation from Phase 1. The Journeys tab hosts a `NestedNavigator` with three stacks: Dashboard, JourneyDetail, ExpenseForm. Tabs (Active/Past/Calendar) are `SegmentedControlChip` widgets bound to `JourneysFilterController` (Riverpod).
2. **Dashboard Screen** – replicates the "Welcome Amr" screen:
   - `JourneySummaryCard` for hero tile (shows first active journey, CTA to resume last opened detail).
   - `JourneyGrid` (3 columns) for "New Journeys" quick launches. Items double as templates.
   - Use `SliverAnimatedList` with `RefreshIndicator` to give background + pull-to-refresh.
3. **Journey Detail** – `TabBarView` (Spending vs Settlement). Each tab reads from `journeyDetailProvider(journeyId)` which pulls from cache + network (see §6). Compose sections: totals hero, `ParticipantMatrixTable`, CTA grid (Add/Edit, Inspect, Extract Report, Dispute/Enquire). Wrap table rows with `SingleChildScrollView` to mimic horizontal spreadsheet with sticky headers.
4. **Add/Edit Expense** – form uses `FormBuilder` + `CurrencyTextField`, `CategoryPickerSheet`, `ParticipantSplitEditor` (equal/exact/percentage). Provide inline errors + preview of who owes what. The Save button triggers optimistic mutation (see below).
5. **Inspect / Dispute Workflow** – accessible via CTA rail. `InspectExpenseSheet` shows audit log, attached receipts (gallery + download). `DisputeExpenseSheet` posts a `settlement_action` with type `dispute`; flows can later escalate to chat/email.
6. **Exports** – `ExtractReport` CTA hits `/journey-reconcile` to seed a CSV/PDF export job, then polls Supabase Storage for completion; once stored, present share sheet (native). Files are saved under `journeys/{journeyId}/reports/{timestamp}.(csv|pdf)`.
7. **Design fidelity** – reuse tokens from `design/tokens.json` for colors, 24px radii, 56px buttons, etc. Chart widgets rely on `syncfusion_flutter_charts` later, but Phase 2 only needs placeholder `CustomPainter` arcs/bars until final libs land.

## 6. Data Flow, Sync, and Offline Strategy

- **Riverpod layers**: `journeysRepository` (Supabase + cache) → `journeysService` (use cases) → UI `AsyncNotifier`s. Expose `journeysDashboardProvider`, `journeyDetailProvider`, `expenseFormController`, `settlementActionsProvider`.
- **Optimistic updates**: on Add/Edit expense, update the cached `journeyDetail` + `journeysDashboard` state immediately, stage mutation into `PendingMutationQueue` (Hive box). Retries run via background isolate when connectivity returns.
- **Background refresh**: use `AppLifecycleObserver` + `PullToRefreshController`. When app resumes or the user pulls to refresh, call `journeyDetailProvider.refresh()` which fetches `/rpc/journey_dashboard` + `/rpc/journey_expense_sheet`. Diffing done using `collection` package to minimize rebuilds.
- **Offline cache**: Hive boxes `journeys_cache`, `expenses_cache`, `settlement_actions_cache`. Each entry stores payload + ETag/time-to-stale. Use `sqlite` for larger tables later if necessary.
- **Attachments**: when offline, store files in `pending_uploads` queue; once online, upload to Supabase Storage then patch `expenses.receipt_url` via patch mutation.

## 7. Acceptance Criteria

- Schema migration applies cleanly on Supabase and enforces all triggers/RLS detailed above.
- Edge function responds within 200 ms for journeys with ≤200 expenses (benchmark on staging data) and reuses SQL helpers.
- Flutter Journeys module skeleton produces the screens outlined in the mockups with real data from Supabase when available, falling back to cached data offline.
- PDF/CSV export commands hit Supabase Storage endpoints and surface success/failure states.
- Unit tests exist for repositories and state notifiers (Phase 3+ will add widget/integration tests).

Once these items pass review, we can promote Phase 2 as completed and proceed to Wallet & Settlements (Phase 3).
