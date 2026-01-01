# Runbook – Applying Phase 6 Supabase Changes

1. **Pre-flight**
   - Confirm Supabase CLI >= 1.153.0.
   - Ensure local `.env.deploy` contains `SUPABASE_ACCESS_TOKEN` with migration rights.
   - Backup production DB snapshot (`supabase db dump --db-url <url>`).
2. **Apply migration**
   ```bash
   cd supabase
   supabase db push --include 20240620090000_phase6_performance_experience.sql
   ```
3. **Seed defaults**
   ```sql
   insert into public.experience_themes (slug, name, is_active, payload)
   values ('mint_core', 'Mint Core', true, '{"light": {...}, "dark": {...}}')
   on conflict (slug) do nothing;

   insert into public.experience_feature_flags (key, description, enabled, rollout_percentage)
   values
     ('debug_performance_overlay', 'Show Flutter performance overlay in dev builds', true, 100),
     ('budget_csv_export', 'Enable CSV export from budgeting cards', false, 25);
   ```
4. **Post checks**
   - `select experience_config();` returns JSON with at least one flag and an active theme.
   - `select * from performance_sessions order by created_at desc limit 5;` is empty (expected) until clients report metrics.
5. **Rollback**
   - `supabase db reset --db-url <snapshot>` if the migration fails.
   - Or manually drop the created tables/RPCs listed in the SQL file.
6. **Secrets**
   - No new secrets, but ensure `SUPABASE_SERVICE_ROLE_KEY` is available for scheduled jobs that ingest performance logs.
