# Supabase Workspace

Phase 0 reserves this folder for:

- `migrations/`: SQL migration scripts (timestamped) for Postgres tables, RLS, triggers.  
- `functions/edge/`: TypeScript edge functions deployed to Supabase.  
- `functions/sql/`: Stored procedures used by Supabase RPC endpoints.

## Phase 1 Next Steps

1. Define baseline schema for Journeys, Expenses, Participants, Categories, SettlementAction.  
2. Draft RLS policies locking records per user/organization.  
3. Create RPC templates for wallet aggregates and budgeting insights.  
4. Configure Supabase CLI + secrets using environment-specific `.env` files (not checked in).

## Phase 3 snapshot

- Migration `20240515090000_phase3_wallets.sql` brings `wallet_contacts`, `wallet_payment_methods`, `wallet_transactions`, and `wallet_settlement_events` plus the helper RPC functions `wallet_overview` and `wallet_transaction_history`.
- `wallet_contact_accessible(contact_id)` guards link tables while still letting wallet modules fetch related journeys/settlements.
- Wallet RPCs are granted to `authenticated` + `service_role` and supply all data used by the Flutter wallet/profile screens.

## Phase 4 snapshot

- Migration `20240522090000_phase4_budgeting_insights_notifications.sql` provisions:
  - **Budgeting**: `budget_rules`, `budget_alerts`, and RPCs `budget_progress` + `evaluate_budget_alerts` to drive category budgets, recurrence, and alerting.
  - **Analytics cache**: `analytics_snapshots` with `insights_dashboard(p_timeframe, p_force_refresh)` for reporting payloads.
  - **Notifications**: `notifications`, `notification_devices`, `notification_preferences`, triggers that convert `budget_alerts` + `wallet_settlement_events` into feed rows, and helper RPCs `notification_feed`, `notification_mark_read`, `register_notification_device`.
- `notifications` table is added to the `supabase_realtime` publication so the Flutter app can stream inserts for live alerts. All new functions are granted to `authenticated` + `service_role`.
