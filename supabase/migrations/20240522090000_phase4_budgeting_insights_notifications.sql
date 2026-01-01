-- Phase 4 – Budgeting engine, insights caching, and notification center.

-- -----------------------------------------------------------------------------
-- Budget rules & alerts
-- -----------------------------------------------------------------------------
create table if not exists public.budget_rules (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid not null references auth.users (id) on delete cascade,
    org_id uuid,
    category_id uuid references public.categories (id) on delete set null,
    label text not null,
    currency text not null default 'EGP',
    amount numeric(14,2) not null check (amount >= 0),
    threshold_percent numeric(5,2) not null default 80
        check (threshold_percent >= 0 and threshold_percent <= 100),
    threshold_amount numeric(14,2),
    recurrence text not null default 'monthly'
        check (recurrence in ('weekly','monthly','quarterly','yearly','custom')),
    recurrence_rule text not null default 'RRULE:FREQ=MONTHLY',
    reset_day int,
    rollover boolean not null default true,
    is_archived boolean not null default false,
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_budget_rules_owner
    on public.budget_rules (owner_id, is_archived);

create table if not exists public.budget_alerts (
    id uuid primary key default gen_random_uuid(),
    budget_id uuid not null references public.budget_rules (id) on delete cascade,
    owner_id uuid not null references auth.users (id) on delete cascade,
    org_id uuid,
    period_start date not null default date_trunc('month', timezone('utc', now())::date),
    alert_type text not null
        check (alert_type in ('threshold','critical','reset')),
    status text not null default 'open'
        check (status in ('open','resolved','dismissed')),
    amount numeric(14,2),
    threshold_percent numeric(5,2),
    payload jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now()),
    resolved_at timestamptz,
    constraint budget_alert_period_unique unique (budget_id, period_start, alert_type)
);

create index if not exists idx_budget_alerts_owner
    on public.budget_alerts (owner_id, alert_type, status);

-- -----------------------------------------------------------------------------
-- Analytics snapshots cache
-- -----------------------------------------------------------------------------
create table if not exists public.analytics_snapshots (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid not null references auth.users (id) on delete cascade,
    org_id uuid,
    snapshot_type text not null,
    timeframe text not null,
    payload jsonb not null default '{}',
    computed_at timestamptz not null default timezone('utc', now()),
    expires_at timestamptz not null default timezone('utc', now()) + interval '5 minutes',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now()),
    constraint analytics_snapshots_owner_unique unique (owner_id, snapshot_type, timeframe)
);

-- -----------------------------------------------------------------------------
-- Notifications & device registry
-- -----------------------------------------------------------------------------
create table if not exists public.notifications (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid not null references auth.users (id) on delete cascade,
    org_id uuid,
    notification_type text not null default 'system'
        check (notification_type in ('budget','payment','reminder','insight','system')),
    severity text not null default 'info'
        check (severity in ('info','success','warning','critical')),
    title text not null,
    body text not null,
    topic text,
    source_table text,
    source_id uuid,
    action_url text,
    action_label text,
    cta_payload jsonb not null default '{}',
    group_key text,
    delivered_at timestamptz not null default timezone('utc', now()),
    read_at timestamptz,
    archived_at timestamptz,
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_notifications_owner
    on public.notifications (owner_id, read_at, created_at desc);

create table if not exists public.notification_devices (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid not null references auth.users (id) on delete cascade,
    token text not null,
    platform text,
    status text not null default 'active'
        check (status in ('active','revoked')),
    last_seen_at timestamptz,
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now()),
    constraint notification_devices_token_unique unique (token)
);

create index if not exists idx_notification_devices_owner
    on public.notification_devices (owner_id, status);

create table if not exists public.notification_preferences (
    owner_id uuid primary key references auth.users (id) on delete cascade,
    push_enabled boolean not null default true,
    realtime_enabled boolean not null default true,
    budget_alerts_enabled boolean not null default true,
    settlement_alerts_enabled boolean not null default true,
    quiet_hours jsonb not null default '{}',
    last_read_at timestamptz,
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

-- -----------------------------------------------------------------------------
-- Timestamp triggers
-- -----------------------------------------------------------------------------
create trigger trg_budget_rules_updated
    before update on public.budget_rules
    for each row execute function public.handle_updated_at();

create trigger trg_budget_alerts_updated
    before update on public.budget_alerts
    for each row execute function public.handle_updated_at();

create trigger trg_analytics_snapshots_updated
    before update on public.analytics_snapshots
    for each row execute function public.handle_updated_at();

create trigger trg_notifications_updated
    before update on public.notifications
    for each row execute function public.handle_updated_at();

create trigger trg_notification_devices_updated
    before update on public.notification_devices
    for each row execute function public.handle_updated_at();

create trigger trg_notification_preferences_updated
    before update on public.notification_preferences
    for each row execute function public.handle_updated_at();

-- -----------------------------------------------------------------------------
-- Row level security
-- -----------------------------------------------------------------------------
alter table public.budget_rules enable row level security;
alter table public.budget_alerts enable row level security;
alter table public.analytics_snapshots enable row level security;
alter table public.notifications enable row level security;
alter table public.notification_devices enable row level security;
alter table public.notification_preferences enable row level security;

create policy "Budget rules readable by owner"
    on public.budget_rules for select
    using (owner_id = auth.uid());

create policy "Budget rules manageable by owner"
    on public.budget_rules for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

create policy "Budget alerts readable by owner"
    on public.budget_alerts for select
    using (owner_id = auth.uid());

create policy "Budget alerts manageable by owner"
    on public.budget_alerts for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

create policy "Analytics snapshots readable by owner"
    on public.analytics_snapshots for select
    using (owner_id = auth.uid());

create policy "Analytics snapshots manageable by owner"
    on public.analytics_snapshots for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

create policy "Notifications readable by owner"
    on public.notifications for select
    using (owner_id = auth.uid());

create policy "Notifications manageable by owner"
    on public.notifications for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

create policy "Notification devices readable by owner"
    on public.notification_devices for select
    using (owner_id = auth.uid());

create policy "Notification devices manageable by owner"
    on public.notification_devices for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

create policy "Notification preferences readable by owner"
    on public.notification_preferences for select
    using (owner_id = auth.uid());

create policy "Notification preferences manageable by owner"
    on public.notification_preferences for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

-- -----------------------------------------------------------------------------
-- Budget progress RPC
-- -----------------------------------------------------------------------------
create or replace function public.budget_progress(p_month date default null)
returns table (
    budget_id uuid,
    label text,
    currency text,
    amount numeric,
    spent numeric,
    remaining numeric,
    progress numeric,
    threshold numeric,
    threshold_percent numeric,
    recurrence text,
    recurrence_rule text,
    period_start date,
    period_end date,
    reset_on date,
    status text,
    category_id uuid,
    category_label text,
    category_color text,
    alerts jsonb,
    trend jsonb,
    metadata jsonb
)
language sql
security definer
set search_path = public
stable
as $$
    with params as (
        select
            date_trunc('month', coalesce(p_month, timezone('utc', now())::date))::date as start_at,
            (date_trunc('month', coalesce(p_month, timezone('utc', now())::date)) + interval '1 month')::date as end_at
    ), budgets as (
        select br.*, c.label as cat_label, c.color as cat_color
        from public.budget_rules br
        left join public.categories c on c.id = br.category_id
        where br.owner_id = auth.uid()
          and br.is_archived = false
    ), expense_days as (
        select e.category_id, sum(e.amount) as amount, e.occurred_on::date as bucket
        from public.expenses e
        join params p on e.occurred_on >= p.start_at and e.occurred_on < p.end_at
        where e.status = 'posted'
          and e.payer_id = auth.uid()
        group by e.category_id, e.occurred_on::date
    ), totals as (
        select
            b.id,
            b.label,
            b.currency,
            b.amount,
            coalesce(sum(case when ed.category_id = b.category_id then ed.amount else 0 end), 0) as spent,
            b.threshold_percent,
            b.threshold_amount,
            b.recurrence,
            b.recurrence_rule,
            b.metadata,
            b.category_id,
            b.cat_label,
            b.cat_color
        from budgets b
        left join expense_days ed on ed.category_id = b.category_id
        group by b.id, b.label, b.currency, b.amount, b.threshold_percent, b.threshold_amount,
                 b.recurrence, b.recurrence_rule, b.metadata, b.category_id, b.cat_label, b.cat_color
    )
    select
        t.id as budget_id,
        t.label,
        t.currency,
        t.amount,
        t.spent,
        greatest(0, t.amount - t.spent) as remaining,
        case when t.amount > 0 then (t.spent / t.amount) * 100 else 0 end as progress,
        coalesce(nullif(t.threshold_amount, 0), t.amount * (t.threshold_percent / 100.0)) as threshold,
        t.threshold_percent,
        t.recurrence,
        t.recurrence_rule,
        p.start_at as period_start,
        p.end_at as period_end,
        (p.end_at - interval '1 day')::date as reset_on,
        case
            when t.spent >= t.amount then 'exceeded'
            when t.spent >= coalesce(nullif(t.threshold_amount, 0), t.amount * (t.threshold_percent / 100.0)) then 'warning'
            else 'ok'
        end as status,
        t.category_id,
        t.cat_label as category_label,
        t.cat_color as category_color,
        coalesce((
            select jsonb_agg(jsonb_build_object(
                'id', ba.id,
                'type', ba.alert_type,
                'status', ba.status,
                'amount', ba.amount,
                'thresholdPercent', ba.threshold_percent,
                'createdAt', ba.created_at,
                'resolvedAt', ba.resolved_at
            ) order by ba.created_at desc)
            from public.budget_alerts ba
            where ba.budget_id = t.id
              and ba.period_start = p.start_at
        ), '[]'::jsonb) as alerts,
        coalesce((
            select jsonb_agg(jsonb_build_object(
                'label', to_char(ed.bucket, 'Mon DD'),
                'value', ed.amount
            ) order by ed.bucket)
            from expense_days ed
            where ed.category_id = t.category_id
        ), '[]'::jsonb) as trend,
        t.metadata
    from totals t
    cross join params p
    order by t.label;
$$;

grant execute on function public.budget_progress(date) to authenticated;
grant execute on function public.budget_progress(date) to service_role;

-- -----------------------------------------------------------------------------
-- Budget alert evaluation helper
-- -----------------------------------------------------------------------------
create or replace function public.evaluate_budget_alerts(p_month date default null)
returns integer
language plpgsql
security definer
set search_path = public
as $$
declare
    owner_uuid uuid := auth.uid();
    target_period date;
    progress_row record;
    alert_kind text;
    inserted integer := 0;
begin
    if owner_uuid is null then
        return 0;
    end if;

    target_period := date_trunc('month', coalesce(p_month, timezone('utc', now())::date))::date;

    for progress_row in select * from public.budget_progress(target_period)
    loop
        if progress_row.status = 'ok' then
            continue;
        end if;

        alert_kind := case when progress_row.status = 'exceeded' then 'critical' else 'threshold' end;

        insert into public.budget_alerts (
            budget_id,
            owner_id,
            org_id,
            period_start,
            alert_type,
            amount,
            threshold_percent,
            payload
        )
        select
            progress_row.budget_id,
            owner_uuid,
            br.org_id,
            target_period,
            alert_kind,
            progress_row.spent,
            progress_row.threshold_percent,
            jsonb_build_object(
                'status', progress_row.status,
                'progress', progress_row.progress,
                'remaining', progress_row.remaining
            )
        from public.budget_rules br
        where br.id = progress_row.budget_id
        on conflict do nothing;

        if found then
            inserted := inserted + 1;
        end if;
    end loop;

    return inserted;
end;
$$;

grant execute on function public.evaluate_budget_alerts(date) to authenticated;
grant execute on function public.evaluate_budget_alerts(date) to service_role;

-- -----------------------------------------------------------------------------
-- Insights dashboard RPC with caching
-- -----------------------------------------------------------------------------
create or replace function public.insights_dashboard(p_timeframe text default '30d', p_force_refresh boolean default false)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
    owner_uuid uuid := auth.uid();
    window_interval interval;
    window_days integer;
    start_at date;
    end_at date;
    prev_start date;
    prev_end date;
    cached jsonb;
    payload jsonb;
begin
    if owner_uuid is null then
        return '{}'::jsonb;
    end if;

    window_interval := case p_timeframe
        when '7d' then interval '7 days'
        when '90d' then interval '90 days'
        when '365d' then interval '365 days'
        else interval '30 days'
    end;

    window_days := greatest(1, extract(day from window_interval)::int);
    end_at := timezone('utc', now())::date + 1;
    start_at := (end_at::timestamptz - window_interval)::date;
    prev_end := start_at;
    prev_start := (prev_end::timestamptz - window_interval)::date;

    if not p_force_refresh then
        select payload into cached
        from public.analytics_snapshots
        where owner_id = owner_uuid
          and snapshot_type = 'insights_dashboard'
          and timeframe = p_timeframe
          and expires_at > timezone('utc', now())
        order by computed_at desc
        limit 1;

        if cached is not null then
            return cached;
        end if;
    end if;

    with params as (
        select start_at as window_start, end_at as window_end,
               prev_start as previous_start, prev_end as previous_end
    ), base as (
        select e.*
        from public.expenses e, params p
        where e.status = 'posted'
          and e.payer_id = owner_uuid
          and e.occurred_on >= p.window_start
          and e.occurred_on < p.window_end
    ), totals as (
        select coalesce(sum(amount), 0) as total_spent,
               coalesce(max(currency), 'EGP') as currency
        from base
    ), previous as (
        select coalesce(sum(amount), 0) as total_spent
        from public.expenses e, params p
        where e.status = 'posted'
          and e.payer_id = owner_uuid
          and e.occurred_on >= p.previous_start
          and e.occurred_on < p.previous_end
    ), trend as (
        select e.occurred_on::date as bucket, sum(e.amount) as total
        from base e
        group by e.occurred_on::date
        order by bucket
    ), categories as (
        select
            coalesce(c.label, 'Uncategorized') as label,
            c.color,
            e.category_id,
            sum(e.amount) as total
        from base e
        left join public.categories c on c.id = e.category_id
        group by e.category_id, c.label, c.color
        order by total desc
    ), recents as (
        select e.id, e.amount, e.currency, e.occurred_on, e.notes,
               coalesce(c.label, 'Uncategorized') as category_label
        from base e
        left join public.categories c on c.id = e.category_id
        order by e.occurred_on desc, e.created_at desc
        limit 10
    )
    select jsonb_build_object(
        'timeframe', p_timeframe,
        'periodStart', start_at,
        'periodEnd', end_at - 1,
        'totalSpent', totals.total_spent,
        'currency', totals.currency,
        'averageDaily', case when window_days > 0 then totals.total_spent / window_days else totals.total_spent end,
        'changePercent', case
            when previous.total_spent > 0 then ((totals.total_spent - previous.total_spent) / previous.total_spent) * 100
            else null
        end,
        'trend', coalesce((
            select jsonb_agg(jsonb_build_object('label', to_char(bucket, 'Mon DD'), 'value', total))
            from trend
        ), '[]'::jsonb),
        'categoryBreakdown', coalesce((
            select jsonb_agg(jsonb_build_object(
                'categoryId', category_id,
                'label', label,
                'color', color,
                'value', total,
                'percent', case when totals.total_spent > 0 then (total / totals.total_spent) * 100 else 0 end
            ))
            from categories
        ), '[]'::jsonb),
        'recentActivities', coalesce((
            select jsonb_agg(jsonb_build_object(
                'id', id,
                'label', category_label,
                'amount', amount,
                'currency', currency,
                'occurredOn', occurred_on,
                'notes', notes
            ))
            from recents
        ), '[]'::jsonb)
    )
    into payload
    from totals, previous;

    insert into public.analytics_snapshots (
        owner_id,
        snapshot_type,
        timeframe,
        payload,
        computed_at,
        expires_at
    ) values (
        owner_uuid,
        'insights_dashboard',
        p_timeframe,
        payload,
        timezone('utc', now()),
        timezone('utc', now()) + interval '10 minutes'
    ) on conflict (owner_id, snapshot_type, timeframe)
      do update set payload = excluded.payload,
                    computed_at = excluded.computed_at,
                    expires_at = excluded.expires_at,
                    updated_at = timezone('utc', now());

    return payload;
end;
$$;

grant execute on function public.insights_dashboard(text, boolean) to authenticated;
grant execute on function public.insights_dashboard(text, boolean) to service_role;

-- -----------------------------------------------------------------------------
-- Notification feed helpers
-- -----------------------------------------------------------------------------
create or replace function public.notification_feed(p_limit int default 50)
returns jsonb
language sql
security definer
set search_path = public
stable
as $$
    with base as (
        select *
        from public.notifications
        where owner_id = auth.uid()
        order by coalesce(read_at, created_at) desc, created_at desc
        limit least(p_limit, 200)
    ), new_notifications as (
        select coalesce(jsonb_agg(jsonb_build_object(
            'id', b.id,
            'title', b.title,
            'body', b.body,
            'type', b.notification_type,
            'severity', b.severity,
            'topic', b.topic,
            'sourceTable', b.source_table,
            'sourceId', b.source_id,
            'actionLabel', b.action_label,
            'actionUrl', b.action_url,
            'ctaPayload', b.cta_payload,
            'createdAt', b.created_at,
            'readAt', b.read_at,
            'metadata', b.metadata
        ) order by b.created_at desc), '[]'::jsonb) as payload
        from base b
        where b.read_at is null
    ), earlier_notifications as (
        select coalesce(jsonb_agg(jsonb_build_object(
            'id', b.id,
            'title', b.title,
            'body', b.body,
            'type', b.notification_type,
            'severity', b.severity,
            'topic', b.topic,
            'sourceTable', b.source_table,
            'sourceId', b.source_id,
            'actionLabel', b.action_label,
            'actionUrl', b.action_url,
            'ctaPayload', b.cta_payload,
            'createdAt', b.created_at,
            'readAt', b.read_at,
            'metadata', b.metadata
        ) order by b.created_at desc), '[]'::jsonb) as payload
        from base b
        where b.read_at is not null
    )
    select jsonb_build_object(
        'new', coalesce((select payload from new_notifications), '[]'::jsonb),
        'earlier', coalesce((select payload from earlier_notifications), '[]'::jsonb)
    );
$$;

grant execute on function public.notification_feed(int) to authenticated;
grant execute on function public.notification_feed(int) to service_role;

create or replace function public.notification_mark_read(p_notification_id uuid)
returns boolean
language plpgsql
security definer
set search_path = public
as $$
declare
    affected integer;
begin
    update public.notifications
    set read_at = coalesce(read_at, timezone('utc', now()))
    where id = p_notification_id
      and owner_id = auth.uid();

    get diagnostics affected = row_count;
    return affected > 0;
end;
$$;

grant execute on function public.notification_mark_read(uuid) to authenticated;
grant execute on function public.notification_mark_read(uuid) to service_role;

create or replace function public.register_notification_device(
    p_token text,
    p_platform text default null,
    p_metadata jsonb default '{}'
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
    owner_uuid uuid := auth.uid();
    device_id uuid;
begin
    if owner_uuid is null or p_token is null then
        return null;
    end if;

    insert into public.notification_devices (
        owner_id,
        token,
        platform,
        status,
        last_seen_at,
        metadata
    ) values (
        owner_uuid,
        p_token,
        p_platform,
        'active',
        timezone('utc', now()),
        coalesce(p_metadata, '{}'::jsonb)
    ) on conflict (token)
      do update set owner_id = excluded.owner_id,
                    platform = excluded.platform,
                    status = 'active',
                    last_seen_at = timezone('utc', now()),
                    metadata = excluded.metadata,
                    updated_at = timezone('utc', now())
      returning id into device_id;

    return device_id;
end;
$$;

grant execute on function public.register_notification_device(text, text, jsonb) to authenticated;
grant execute on function public.register_notification_device(text, text, jsonb) to service_role;

-- -----------------------------------------------------------------------------
-- Triggers to funnel alerts into notifications
-- -----------------------------------------------------------------------------
create or replace function public.handle_budget_alert_notification()
returns trigger
language plpgsql
as $$
declare
    budget_label text := 'Budget alert';
begin
    select coalesce(label, budget_label) into budget_label
    from public.budget_rules
    where id = new.budget_id;

    insert into public.notifications (
        owner_id,
        org_id,
        notification_type,
        severity,
        title,
        body,
        topic,
        source_table,
        source_id,
        cta_payload
    ) values (
        new.owner_id,
        new.org_id,
        'budget',
        case when new.alert_type = 'critical' then 'critical' else 'warning' end,
        budget_label,
        case when new.alert_type = 'critical'
            then budget_label || ' exceeded its budget limit.'
            else budget_label || ' crossed ' || coalesce(new.threshold_percent::text, '0') || '% of the budget.'
        end,
        'budget',
        'budget_alerts',
        new.id,
        jsonb_build_object(
            'budgetId', new.budget_id,
            'periodStart', new.period_start,
            'alertType', new.alert_type
        )
    );

    return new;
end;
$$;

create trigger trg_budget_alerts_notify
    after insert on public.budget_alerts
    for each row execute function public.handle_budget_alert_notification();

create or replace function public.handle_wallet_event_notification()
returns trigger
language plpgsql
as $$
declare
    counterparty text := 'Wallet update';
begin
    if new.event_type not in ('payment','reminder') then
        return new;
    end if;

    select coalesce(c.display_name, 'Unassigned')
    into counterparty
    from public.wallet_transactions t
    left join public.wallet_contacts c on c.id = t.contact_id
    where t.id = new.transaction_id;

    insert into public.notifications (
        owner_id,
        notification_type,
        severity,
        title,
        body,
        topic,
        source_table,
        source_id,
        cta_payload
    ) values (
        new.owner_id,
        case when new.event_type = 'payment' then 'payment' else 'reminder' end,
        case when new.event_type = 'payment' then 'success' else 'info' end,
        case when new.event_type = 'payment' then 'Payment recorded' else 'Reminder sent' end,
        case when new.event_type = 'payment'
            then format('%s logged a payment of %s.', counterparty, coalesce(new.amount, 0))
            else format('Reminder scheduled for %s.', counterparty)
        end,
        'wallet',
        'wallet_settlement_events',
        new.id,
        jsonb_build_object('transactionId', new.transaction_id)
    );

    return new;
end;
$$;

create trigger trg_wallet_events_notify
    after insert on public.wallet_settlement_events
    for each row execute function public.handle_wallet_event_notification();

-- -----------------------------------------------------------------------------
-- Realtime publication
-- -----------------------------------------------------------------------------
do $$
begin
    if not exists (
        select 1 from pg_publication_tables
        where pubname = 'supabase_realtime'
          and schemaname = 'public'
          and tablename = 'notifications'
    ) then
        execute 'alter publication supabase_realtime add table public.notifications';
    end if;
end;
$$;
