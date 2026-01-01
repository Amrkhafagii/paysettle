# Phase 3 – Wallet & Settlements

Phase 3 builds on the journeys/expenses work from Phase 2 and unlocks individual wallet views, settlement workflows, and a richer contacts book. This document captures the scope that is now code-complete inside this repo.

## 1. Scope & Goals

- **Wallet command center** – Totals owed/owing, net balance, and per-counterparty CTAs rendered from Supabase RPC output. Includes chart trendlines and a settlement history feed.
- **Payment method rail** – Manage Vodafone Cash, Instapay, and bank placeholders with metadata for share sheets.
- **Messaging hooks** – Wallet CTAs surface share/deep-link payloads so requests can be kicked off via the platform share sheet.
- **Contacts workspace** – CRUD with search/sort, plus linkage metadata so contacts can be attached to journeys/settlements.

## 2. Postgres Schema Additions

Migration `20240515090000_phase3_wallets.sql` introduces new wallet-centric tables:

| Table | Purpose |
| --- | --- |
| `wallet_contacts` | Owner-scoped contact book with tagging + generated search key. |
| `wallet_contact_links` | Junction to journeys/settlements for traceability. |
| `wallet_payment_methods` | Stores placeholders for payment rails + metadata. |
| `wallet_transactions` | Normalized ledger of amounts to collect or pay. |
| `wallet_settlement_events` | Timeline of reminders, payments, and notes per transaction. |

All tables ship with timestamp triggers plus RLS policies locking rows to `owner_id`. Helper function `wallet_contact_accessible(contact_id uuid)` ensures link rows inherit the parent contact’s visibility.

## 3. RPC Services

Two RPC helpers power the mobile wallet module:

1. `wallet_overview(p_timeframe text)` – Returns a single row with totals, counterparty summaries, settlement log entries, chart data, and the owner’s payment methods. The function filters the chart window by timeframe (day/week/month/year) and only surfaces unsettled ledger entries in the collect/pay arrays.
2. `wallet_transaction_history(p_direction text, p_status text, p_limit int, p_offset int)` – Paginated feed for detail drawers and logs.

Both functions run as `security definer`, use `auth.uid()` for scoping, and are granted to `authenticated` + `service_role` roles.

## 4. Flutter Implementation Notes

- Module path: `lib/modules/wallet`. Domain models use Freezed. `WalletController` drives the overview UI via Riverpod and merges cached/demo data with RPC output.
- UI replicates the specs shared in the reference mocks: hero card, timeframe selector, sparkline chart, counterparty lists (Collect From / Pay To), settlement log chips, CTA buttons, and payment-method carousel.
- Share sheet integration uses `share_plus`. Wallet CTAs build a message payload from the RPC response and invoke the platform share dialog.
- Contacts module reads from `wallet_contacts` using the new repository. CRUD is stubbed locally but ready for Supabase integration through the shared data source.

## 5. Pending Work (Future Phases)

- Replace stub/demo wallet entries with live Supabase data once staging datasets are seeded.
- Phase 4+ extends the RPC layer for budgeting/insights and wires FCM realtime alerts.
- Integrations (CSV/PDF exporters, accounting connectors) will reuse the wallet tables introduced here.
