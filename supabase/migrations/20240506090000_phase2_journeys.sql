-- Phase 2 core schema for journeys, expenses, and settlements.

create extension if not exists "pgcrypto";

-- Journeys -------------------------------------------------------------------
create table if not exists public.journeys (
    id uuid primary key default gen_random_uuid(),
    org_id uuid not null,
    owner_id uuid not null references auth.users (id) on delete cascade,
    title text not null,
    description text,
    status text not null default 'planned'
        check (status in ('planned','active','settled','archived')),
    start_on date not null,
    end_on date,
    currency text not null default 'EGP',
    cover_image text,
    totals jsonb not null default '{}',
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_journeys_org_status
    on public.journeys (org_id, status);

-- Participants ----------------------------------------------------------------
create table if not exists public.journey_participants (
    journey_id uuid not null references public.journeys (id) on delete cascade,
    profile_id uuid not null references auth.users (id) on delete cascade,
    role text not null default 'viewer'
        check (role in ('owner','editor','viewer')),
    state text not null default 'invited'
        check (state in ('invited','confirmed','left')),
    amount_paid numeric(14,2) not null default 0,
    amount_owed numeric(14,2) not null default 0,
    net_balance numeric(14,2) not null default 0,
    settlement_status text not null default 'pending'
        check (settlement_status in ('pending','owe','owed','settled','disputed')),
    last_activity_at timestamptz,
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now()),
    primary key (journey_id, profile_id)
);

-- Categories ------------------------------------------------------------------
create table if not exists public.categories (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid references auth.users (id) on delete cascade,
    slug text unique,
    label text not null,
    icon text,
    color text,
    kind text not null default 'system'
        check (kind in ('system','custom')),
    is_active boolean not null default true,
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

-- Expenses --------------------------------------------------------------------
create table if not exists public.expenses (
    id uuid primary key default gen_random_uuid(),
    journey_id uuid not null references public.journeys (id) on delete cascade,
    payer_id uuid not null references auth.users (id) on delete cascade,
    category_id uuid references public.categories (id) on delete set null,
    amount numeric(14,2) not null check (amount >= 0),
    currency text not null,
    split_type text not null default 'equal'
        check (split_type in ('equal','exact','percentage','shares')),
    notes text,
    status text not null default 'posted'
        check (status in ('draft','posted','void','disputed')),
    receipt_url text,
    occurred_on date not null default timezone('utc', now())::date,
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_expenses_journey_date
    on public.expenses (journey_id, occurred_on desc);

-- Expense shares --------------------------------------------------------------
create table if not exists public.expense_shares (
    expense_id uuid not null references public.expenses (id) on delete cascade,
    journey_id uuid not null references public.journeys (id) on delete cascade,
    participant_id uuid not null references auth.users (id) on delete cascade,
    share_amount numeric(14,2) not null default 0 check (share_amount >= 0),
    share_percent numeric(7,4),
    is_payer boolean not null default false,
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now()),
    primary key (expense_id, participant_id),
    constraint expense_share_participant_fk
        foreign key (journey_id, participant_id)
        references public.journey_participants (journey_id, profile_id)
        on delete cascade
);

-- Settlement actions ----------------------------------------------------------
create table if not exists public.settlement_actions (
    id uuid primary key default gen_random_uuid(),
    journey_id uuid not null references public.journeys (id) on delete cascade,
    initiator_id uuid not null references auth.users (id) on delete cascade,
    target_id uuid references auth.users (id) on delete set null,
    action_type text not null
        check (action_type in ('request','pay','dispute','enquiry','note')),
    status text not null default 'open'
        check (status in ('open','processing','completed','rejected')),
    amount numeric(14,2) check (amount is null or amount >= 0),
    currency text not null,
    payload jsonb not null default '{}',
    proof_url text,
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_settlement_actions_journey
    on public.settlement_actions (journey_id, created_at desc);

-- Activity log ----------------------------------------------------------------
create table if not exists public.journey_activity_log (
    id uuid primary key default gen_random_uuid(),
    journey_id uuid not null references public.journeys (id) on delete cascade,
    actor_id uuid references auth.users (id) on delete set null,
    verb text not null,
    data jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now())
);

-- Timestamp trigger shared helper --------------------------------------------
create or replace function public.handle_updated_at()
returns trigger
language plpgsql
as $$
begin
    new.updated_at = timezone('utc', now());
    return new;
end;
$$;

create or replace function public.add_owner_as_participant()
returns trigger
language plpgsql
as $$
begin
    insert into public.journey_participants (journey_id, profile_id, role, state, settlement_status)
    values (new.id, new.owner_id, 'owner', 'confirmed', 'pending')
    on conflict (journey_id, profile_id) do nothing;
    return new;
end;
$$;

create or replace function public.recompute_journey_totals(target_journey_id uuid)
returns void
language plpgsql
as $$
declare
    aggregated jsonb;
begin
    if target_journey_id is null then
        return;
    end if;

    with payer_totals as (
        select payer_id as profile_id, sum(amount) as amount_paid
        from public.expenses
        where journey_id = target_journey_id and status = 'posted'
        group by payer_id
    ), owed_totals as (
        select participant_id as profile_id, sum(share_amount) as amount_owed
        from public.expense_shares
        where journey_id = target_journey_id
        group by participant_id
    ), combined as (
        select jp.journey_id,
               jp.profile_id,
               coalesce(pt.amount_paid, 0) as amount_paid,
               coalesce(ot.amount_owed, 0) as amount_owed
        from public.journey_participants jp
        left join payer_totals pt on pt.profile_id = jp.profile_id
        left join owed_totals ot on ot.profile_id = jp.profile_id
        where jp.journey_id = target_journey_id
    )
    update public.journey_participants jp
    set amount_paid = combined.amount_paid,
        amount_owed = combined.amount_owed,
        net_balance = combined.amount_paid - combined.amount_owed,
        updated_at = timezone('utc', now())
    from combined
    where jp.journey_id = combined.journey_id
      and jp.profile_id = combined.profile_id;

    aggregated := jsonb_build_object(
        'totalSpent', coalesce((select sum(amount) from public.expenses where journey_id = target_journey_id and status = 'posted'), 0),
        'categories', coalesce((
            select jsonb_agg(jsonb_build_object(
                'categoryId', cat_id,
                'label', cat_label,
                'amount', total
            ) order by total desc)
            from (
                select coalesce(e.category_id, '00000000-0000-0000-0000-000000000000') as cat_id,
                       coalesce((select label from public.categories c where c.id = e.category_id), 'Uncategorized') as cat_label,
                       sum(e.amount) as total
                from public.expenses e
                where e.journey_id = target_journey_id and e.status = 'posted'
                group by 1,2
            ) cat_totals
        ), '[]'::jsonb),
        'participants', coalesce((
            select jsonb_agg(jsonb_build_object(
                'profileId', jp.profile_id,
                'paid', jp.amount_paid,
                'owed', jp.amount_owed,
                'net', jp.net_balance,
                'settlementStatus', jp.settlement_status
            ) order by jp.net_balance desc)
            from public.journey_participants jp
            where jp.journey_id = target_journey_id
        ), '[]'::jsonb)
    );

    update public.journeys
    set totals = aggregated,
        updated_at = timezone('utc', now())
    where id = target_journey_id;
end;
$$;

create or replace function public.trigger_refresh_journey_totals()
returns trigger
language plpgsql
as $$
begin
    perform public.recompute_journey_totals(coalesce(new.journey_id, old.journey_id));
    return new;
end;
$$;

create or replace function public.trigger_update_settlement_state()
returns trigger
language plpgsql
as $$
declare
    target uuid;
begin
    target := coalesce(new.journey_id, old.journey_id);
    update public.journey_participants jp
    set settlement_status = case
        when exists (
            select 1
            from public.settlement_actions sa
            where sa.journey_id = target
              and sa.target_id = jp.profile_id
              and sa.action_type = 'dispute'
              and sa.status in ('open','processing')
        ) then 'disputed'
        when jp.net_balance between -0.01 and 0.01 then 'settled'
        when jp.net_balance > 0 then 'owed'
        else 'owe'
    end,
    updated_at = timezone('utc', now())
    where jp.journey_id = target;
    return new;
end;
$$;

-- Trigger wiring --------------------------------------------------------------
create trigger trg_journeys_owner_participant
    after insert on public.journeys
    for each row execute function public.add_owner_as_participant();

create trigger trg_journeys_updated
    before update on public.journeys
    for each row execute function public.handle_updated_at();

create trigger trg_participants_updated
    before update on public.journey_participants
    for each row execute function public.handle_updated_at();

create trigger trg_categories_updated
    before update on public.categories
    for each row execute function public.handle_updated_at();

create trigger trg_expenses_updated
    before update on public.expenses
    for each row execute function public.handle_updated_at();

create trigger trg_expense_shares_updated
    before update on public.expense_shares
    for each row execute function public.handle_updated_at();

create trigger trg_settlement_actions_updated
    before update on public.settlement_actions
    for each row execute function public.handle_updated_at();

create trigger trg_expenses_totals
    after insert or update or delete on public.expenses
    for each row execute function public.trigger_refresh_journey_totals();

create trigger trg_expense_shares_totals
    after insert or update or delete on public.expense_shares
    for each row execute function public.trigger_refresh_journey_totals();

create trigger trg_settlement_actions_status
    after insert or update or delete on public.settlement_actions
    for each row execute function public.trigger_update_settlement_state();

-- Access helpers --------------------------------------------------------------
create or replace function public.is_journey_member(target_journey uuid)
returns boolean
language sql
security definer
set search_path = public
stable
as $$
    select exists (
        select 1 from public.journey_participants jp
        where jp.journey_id = target_journey
          and jp.profile_id = auth.uid()
          and jp.state = 'confirmed'
    );
$$;

create or replace function public.has_journey_editor(target_journey uuid)
returns boolean
language sql
security definer
set search_path = public
stable
as $$
    select exists (
        select 1 from public.journey_participants jp
        where jp.journey_id = target_journey
          and jp.profile_id = auth.uid()
          and jp.role in ('owner','editor')
          and jp.state = 'confirmed'
    );
$$;

-- Row level security ----------------------------------------------------------
alter table public.journeys enable row level security;
alter table public.journey_participants enable row level security;
alter table public.categories enable row level security;
alter table public.expenses enable row level security;
alter table public.expense_shares enable row level security;
alter table public.settlement_actions enable row level security;
alter table public.journey_activity_log enable row level security;

create policy "Journeys are readable by members"
    on public.journeys for select
    using (public.is_journey_member(id));

create policy "Journeys can be inserted by owner"
    on public.journeys for insert
    with check (auth.uid() = owner_id);

create policy "Journeys can be updated by editors"
    on public.journeys for update
    using (public.has_journey_editor(id))
    with check (public.has_journey_editor(id));

create policy "Journeys can be deleted by editors"
    on public.journeys for delete
    using (public.has_journey_editor(id));

create policy "Participants readable by members"
    on public.journey_participants for select
    using (public.is_journey_member(journey_id));

create policy "Participants managed by editors"
    on public.journey_participants for all
    using (public.has_journey_editor(journey_id))
    with check (public.has_journey_editor(journey_id));

create policy "Categories readable"
    on public.categories for select
    using (kind = 'system' or owner_id = auth.uid() or owner_id is null);

create policy "Categories manageable by owner"
    on public.categories for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

create policy "Expenses readable by members"
    on public.expenses for select
    using (public.is_journey_member(journey_id));

create policy "Expenses managed by editors"
    on public.expenses for all
    using (public.has_journey_editor(journey_id))
    with check (public.has_journey_editor(journey_id));

create policy "Expense shares readable by members"
    on public.expense_shares for select
    using (public.is_journey_member(journey_id));

create policy "Expense shares managed by editors"
    on public.expense_shares for all
    using (public.has_journey_editor(journey_id))
    with check (public.has_journey_editor(journey_id));

create policy "Settlement actions readable by members"
    on public.settlement_actions for select
    using (public.is_journey_member(journey_id));

create policy "Settlement actions inserted by initiator"
    on public.settlement_actions for insert
    with check (public.is_journey_member(journey_id) and auth.uid() = initiator_id);

create policy "Settlement action status updated by editors"
    on public.settlement_actions for update
    using (public.has_journey_editor(journey_id) or auth.uid() = initiator_id)
    with check (public.has_journey_editor(journey_id) or auth.uid() = initiator_id);

create policy "Settlement actions deleted by editors"
    on public.settlement_actions for delete
    using (public.has_journey_editor(journey_id));

create policy "Activity log readable by members"
    on public.journey_activity_log for select
    using (public.is_journey_member(journey_id));

create policy "Activity log inserts by editors"
    on public.journey_activity_log for insert
    with check (public.is_journey_member(journey_id));

-- RPC helpers -----------------------------------------------------------------
create or replace function public.journey_dashboard(
    p_scope text default 'active',
    p_search text default null,
    p_limit int default 20,
    p_offset int default 0
)
returns table (
    journey_id uuid,
    title text,
    status text,
    start_on date,
    end_on date,
    total_spent numeric,
    participant_count integer,
    my_balance numeric,
    totals jsonb
)
language sql
security invoker
set search_path = public
stable
as $$
    with scoped as (
        select j.*
        from public.journeys j
        where public.is_journey_member(j.id)
          and (
            p_scope is null or
            (p_scope = 'active' and j.status in ('planned','active')) or
            (p_scope = 'past' and j.status in ('settled','archived')) or
            (p_scope = 'calendar')
          )
          and (p_search is null or j.title ilike ('%' || p_search || '%'))
    )
    select j.id,
           j.title,
           j.status,
           j.start_on,
           j.end_on,
           coalesce((j.totals ->> 'totalSpent')::numeric, 0) as total_spent,
           (select count(*) from public.journey_participants jp where jp.journey_id = j.id and jp.state = 'confirmed') as participant_count,
           coalesce((
               select jp.net_balance from public.journey_participants jp
               where jp.journey_id = j.id and jp.profile_id = auth.uid()
           ), 0) as my_balance,
           j.totals
    from scoped j
    order by j.start_on desc, j.created_at desc
    limit p_limit offset p_offset;
$$;

grant execute on function public.journey_dashboard(text, text, int, int) to authenticated;

grant execute on function public.journey_dashboard(text, text, int, int) to service_role;

create or replace function public.journey_expense_sheet(
    p_journey_id uuid,
    p_limit int default 100,
    p_offset int default 0
)
returns table (
    expense_id uuid,
    journey_id uuid,
    occurred_on date,
    payer_id uuid,
    category_id uuid,
    amount numeric,
    status text,
    split_type text,
    notes text,
    shares jsonb
)
language sql
security invoker
set search_path = public
stable
as $$
    select e.id,
           e.journey_id,
           e.occurred_on,
           e.payer_id,
           e.category_id,
           e.amount,
           e.status,
           e.split_type,
           e.notes,
           coalesce(jsonb_agg(jsonb_build_object(
               'participantId', es.participant_id,
               'amount', es.share_amount,
               'percent', es.share_percent,
               'isPayer', es.is_payer
           ) order by es.is_payer desc, es.share_amount desc) filter (where es.participant_id is not null), '[]'::jsonb) as shares
    from public.expenses e
    left join public.expense_shares es on es.expense_id = e.id
    where e.journey_id = p_journey_id
      and public.is_journey_member(e.journey_id)
    group by e.id
    order by e.occurred_on desc, e.created_at desc
    limit p_limit offset p_offset;
$$;

grant execute on function public.journey_expense_sheet(uuid, int, int) to authenticated;

grant execute on function public.journey_expense_sheet(uuid, int, int) to service_role;
