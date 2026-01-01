-- Phase 3 wallet, contacts, and settlement extensions.

create table if not exists public.wallet_contacts (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid not null references auth.users (id) on delete cascade,
    org_id uuid,
    display_name text not null,
    email text,
    phone text,
    avatar_url text,
    search_name text generated always as (regexp_replace(lower(display_name), '[[:space:]]+', ' ', 'g')) stored,
    tags text[] not null default '{}',
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_wallet_contacts_owner on public.wallet_contacts (owner_id, search_name);

create table if not exists public.wallet_contact_links (
    contact_id uuid not null references public.wallet_contacts (id) on delete cascade,
    resource_type text not null check (resource_type in ('journey','settlement')),
    resource_id uuid not null,
    label text,
    created_at timestamptz not null default timezone('utc', now()),
    primary key (contact_id, resource_type, resource_id)
);

create table if not exists public.wallet_payment_methods (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid not null references auth.users (id) on delete cascade,
    label text not null,
    provider text not null,
    method_type text not null check (method_type in ('vodafone_cash','instapay','bank','other')),
    account_number text,
    instructions text,
    is_primary boolean not null default false,
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_wallet_payment_methods_owner on public.wallet_payment_methods (owner_id, is_primary desc);

create table if not exists public.wallet_transactions (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid not null references auth.users (id) on delete cascade,
    contact_id uuid references public.wallet_contacts (id) on delete set null,
    journey_id uuid references public.journeys (id) on delete set null,
    direction text not null check (direction in ('collect','pay')),
    amount numeric(14,2) not null check (amount >= 0),
    currency text not null default 'EGP',
    status text not null default 'open'
        check (status in ('open','due','pending','settled','disputed')),
    issue_date date not null default timezone('utc', now())::date,
    due_date date,
    reminder_channel text,
    memo text,
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_wallet_transactions_owner on public.wallet_transactions (owner_id, direction, status);

create table if not exists public.wallet_settlement_events (
    id uuid primary key default gen_random_uuid(),
    transaction_id uuid not null references public.wallet_transactions (id) on delete cascade,
    owner_id uuid not null references auth.users (id) on delete cascade,
    event_type text not null check (event_type in ('request','reminder','payment','note')),
    amount numeric(14,2),
    payload jsonb not null default '{}',
    occurred_at timestamptz not null default timezone('utc', now()),
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create or replace function public.wallet_contact_accessible(target_contact uuid)
returns boolean
language sql
security definer
set search_path = public
stable
as $$
    select exists (
        select 1 from public.wallet_contacts c
        where c.id = target_contact and c.owner_id = auth.uid()
    );
$$;

grant execute on function public.wallet_contact_accessible(uuid) to authenticated;

grant execute on function public.wallet_contact_accessible(uuid) to service_role;

-- Timestamp triggers ----------------------------------------------------------
create trigger trg_wallet_contacts_updated
    before update on public.wallet_contacts
    for each row execute function public.handle_updated_at();

create trigger trg_wallet_payment_methods_updated
    before update on public.wallet_payment_methods
    for each row execute function public.handle_updated_at();

create trigger trg_wallet_transactions_updated
    before update on public.wallet_transactions
    for each row execute function public.handle_updated_at();

create trigger trg_wallet_settlement_events_updated
    before update on public.wallet_settlement_events
    for each row execute function public.handle_updated_at();

-- RLS -------------------------------------------------------------------------
alter table public.wallet_contacts enable row level security;
alter table public.wallet_contact_links enable row level security;
alter table public.wallet_payment_methods enable row level security;
alter table public.wallet_transactions enable row level security;
alter table public.wallet_settlement_events enable row level security;

create policy "Wallet contacts readable by owner"
    on public.wallet_contacts for select
    using (owner_id = auth.uid());

create policy "Wallet contacts manageable by owner"
    on public.wallet_contacts for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

create policy "Wallet contact links readable by owner"
    on public.wallet_contact_links for select
    using (public.wallet_contact_accessible(contact_id));

create policy "Wallet contact links manageable by owner"
    on public.wallet_contact_links for all
    using (public.wallet_contact_accessible(contact_id))
    with check (public.wallet_contact_accessible(contact_id));

create policy "Wallet payment methods readable by owner"
    on public.wallet_payment_methods for select
    using (owner_id = auth.uid());

create policy "Wallet payment methods manageable by owner"
    on public.wallet_payment_methods for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

create policy "Wallet transactions readable by owner"
    on public.wallet_transactions for select
    using (owner_id = auth.uid());

create policy "Wallet transactions manageable by owner"
    on public.wallet_transactions for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

create policy "Wallet settlement events readable by owner"
    on public.wallet_settlement_events for select
    using (owner_id = auth.uid());

create policy "Wallet settlement events manageable by owner"
    on public.wallet_settlement_events for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

-- RPC helpers -----------------------------------------------------------------
create or replace function public.wallet_overview(p_timeframe text default 'month')
returns table (
    total_balance numeric,
    total_owed numeric,
    total_due numeric,
    net_value numeric,
    collect_from jsonb,
    pay_to jsonb,
    settlement_log jsonb,
    trend jsonb,
    payment_methods jsonb
)
language sql
security definer
set search_path = public
stable
as $$
    with params as (
        select case
            when p_timeframe = 'day' then timezone('utc', now()) - interval '1 day'
            when p_timeframe = 'week' then timezone('utc', now()) - interval '7 days'
            when p_timeframe = 'year' then timezone('utc', now()) - interval '365 days'
            else timezone('utc', now()) - interval '30 days'
        end as start_at
    ), base as (
        select * from public.wallet_transactions t
        where t.owner_id = auth.uid()
    ), range_base as (
        select b.* from base b, params
        where b.issue_date >= params.start_at::date
    ), totals as (
        select
            coalesce(sum(case when direction = 'collect' then amount else 0 end), 0) as total_owed,
            coalesce(sum(case when direction = 'pay' then amount else 0 end), 0) as total_due
        from base
        where status <> 'settled'
    )
    select
        (totals.total_owed - totals.total_due) as total_balance,
        totals.total_owed,
        totals.total_due,
        (totals.total_owed - totals.total_due) as net_value,
        coalesce((
            select jsonb_agg(jsonb_build_object(
                'transactionId', sub.id,
                'contactId', sub.contact_id,
                'name', sub.contact_name,
                'amount', sub.amount,
                'status', sub.status,
                'issueDate', sub.issue_date,
                'dueDate', sub.due_date,
                'journeyId', sub.journey_id
            ))
            from (
                select t.id, t.contact_id, coalesce(c.display_name, 'Unassigned') as contact_name,
                       t.amount, t.status, t.issue_date, t.due_date, t.journey_id
                from base t
                left join public.wallet_contacts c on c.id = t.contact_id
                where t.direction = 'collect' and t.status <> 'settled'
                order by coalesce(t.due_date, t.issue_date) asc, t.created_at desc
                limit 6
            ) sub
        ), '[]'::jsonb) as collect_from,
        coalesce((
            select jsonb_agg(jsonb_build_object(
                'transactionId', sub.id,
                'contactId', sub.contact_id,
                'name', sub.contact_name,
                'amount', sub.amount,
                'status', sub.status,
                'issueDate', sub.issue_date,
                'dueDate', sub.due_date,
                'journeyId', sub.journey_id
            ))
            from (
                select t.id, t.contact_id, coalesce(c.display_name, 'Unassigned') as contact_name,
                       t.amount, t.status, t.issue_date, t.due_date, t.journey_id
                from base t
                left join public.wallet_contacts c on c.id = t.contact_id
                where t.direction = 'pay' and t.status <> 'settled'
                order by coalesce(t.due_date, t.issue_date) asc, t.created_at desc
                limit 6
            ) sub
        ), '[]'::jsonb) as pay_to,
        coalesce((
            select jsonb_agg(jsonb_build_object(
                'eventId', e.id,
                'transactionId', e.transaction_id,
                'type', e.event_type,
                'amount', e.amount,
                'occurredAt', e.occurred_at,
                'status', t.status,
                'counterparty', coalesce(c.display_name, 'Unassigned')
            ))
            from (
                select e.*
                from public.wallet_settlement_events e
                where e.owner_id = auth.uid()
                order by e.occurred_at desc
                limit 10
            ) e
            join public.wallet_transactions t on t.id = e.transaction_id
            left join public.wallet_contacts c on c.id = t.contact_id
        ), '[]'::jsonb) as settlement_log,
        coalesce((
            select jsonb_agg(jsonb_build_object(
                'label', to_char(bucket, 'Mon DD'),
                'collect', collect_amount,
                'pay', pay_amount
            ) order by bucket)
            from (
                select rb.issue_date as bucket,
                       sum(case when rb.direction = 'collect' then rb.amount else 0 end) as collect_amount,
                       sum(case when rb.direction = 'pay' then rb.amount else 0 end) as pay_amount
                from range_base rb
                group by rb.issue_date
                order by rb.issue_date asc
            ) trend_data
        ), '[]'::jsonb) as trend,
        coalesce((
            select jsonb_agg(jsonb_build_object(
                'methodId', m.id,
                'label', m.label,
                'provider', m.provider,
                'type', m.method_type,
                'isPrimary', m.is_primary,
                'accountNumber', m.account_number,
                'instructions', m.instructions,
                'metadata', m.metadata
            ) order by m.is_primary desc, m.created_at asc)
            from public.wallet_payment_methods m
            where m.owner_id = auth.uid()
        ), '[]'::jsonb) as payment_methods
    from totals
    limit 1;
$$;

grant execute on function public.wallet_overview(text) to authenticated;

grant execute on function public.wallet_overview(text) to service_role;

create or replace function public.wallet_transaction_history(
    p_direction text default null,
    p_status text default null,
    p_limit int default 25,
    p_offset int default 0
)
returns table (
    transaction_id uuid,
    direction text,
    status text,
    amount numeric,
    currency text,
    issue_date date,
    due_date date,
    contact_id uuid,
    contact_name text,
    journey_id uuid,
    memo text
)
language sql
security definer
set search_path = public
stable
as $$
    select t.id,
           t.direction,
           t.status,
           t.amount,
           t.currency,
           t.issue_date,
           t.due_date,
           t.contact_id,
           coalesce(c.display_name, 'Unassigned') as contact_name,
           t.journey_id,
           t.memo
    from public.wallet_transactions t
    left join public.wallet_contacts c on c.id = t.contact_id
    where t.owner_id = auth.uid()
      and (p_direction is null or t.direction = p_direction)
      and (p_status is null or t.status = p_status)
    order by coalesce(t.due_date, t.issue_date) desc, t.created_at desc
    limit p_limit offset p_offset;
$$;

grant execute on function public.wallet_transaction_history(text, text, int, int) to authenticated;

grant execute on function public.wallet_transaction_history(text, text, int, int) to service_role;
