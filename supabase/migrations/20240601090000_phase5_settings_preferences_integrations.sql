-- Phase 5 – Settings, preferences, and integrations.

-- -----------------------------------------------------------------------------
-- Profile & linked account storage
-- -----------------------------------------------------------------------------
create table if not exists public.user_profiles (
    user_id uuid primary key references auth.users (id) on delete cascade,
    org_id uuid,
    full_name text not null default 'PaySettle Member',
    email text not null,
    phone text,
    avatar_url text,
    job_title text,
    country text,
    timezone text,
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_user_profiles_org on public.user_profiles (org_id);

create table if not exists public.linked_accounts (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid not null references auth.users (id) on delete cascade,
    org_id uuid,
    provider text not null,
    account_name text not null,
    account_number text,
    status text not null default 'connected'
        check (status in ('connected','pending','error','disconnected')),
    last_synced_at timestamptz,
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_linked_accounts_owner
    on public.linked_accounts (owner_id, provider);

-- -----------------------------------------------------------------------------
-- Subscription plans & assignments
-- -----------------------------------------------------------------------------
create table if not exists public.subscription_plans (
    id uuid primary key default gen_random_uuid(),
    slug text not null unique,
    name text not null,
    tier text not null,
    description text,
    price numeric(10,2),
    currency text not null default 'USD',
    billing_interval text not null default 'monthly'
        check (billing_interval in ('monthly','yearly','quarterly')),
    features text[] not null default '{}',
    is_active boolean not null default true,
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.user_subscriptions (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid not null references auth.users (id) on delete cascade,
    org_id uuid,
    plan_id uuid not null references public.subscription_plans (id) on delete restrict,
    status text not null default 'active'
        check (status in ('trial','active','past_due','canceled')),
    renews_on date,
    expires_on date,
    seats int not null default 1,
    usage jsonb not null default '{}',
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create unique index if not exists idx_user_subscriptions_owner_plan
    on public.user_subscriptions (owner_id, plan_id);

-- -----------------------------------------------------------------------------
-- Preferences & security controls
-- -----------------------------------------------------------------------------
create table if not exists public.app_preferences (
    owner_id uuid primary key references auth.users (id) on delete cascade,
    org_id uuid,
    preferred_currency text not null default 'EGP',
    dark_mode text not null default 'system'
        check (dark_mode in ('system','light','dark')),
    notifications_enabled boolean not null default true,
    face_id_enabled boolean not null default false,
    auto_export_format text not null default 'pdf'
        check (auto_export_format in ('pdf','csv')),
    feature_flags jsonb not null default '{}',
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.user_sessions (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid not null references auth.users (id) on delete cascade,
    org_id uuid,
    device_name text not null,
    platform text,
    ip_address text,
    location text,
    status text not null default 'active'
        check (status in ('active','revoked','expired')),
    is_current boolean not null default false,
    last_seen_at timestamptz not null default timezone('utc', now()),
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_user_sessions_owner
    on public.user_sessions (owner_id, last_seen_at desc);

-- -----------------------------------------------------------------------------
-- Audit logging & export jobs
-- -----------------------------------------------------------------------------
create table if not exists public.audit_log_entries (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid not null references auth.users (id) on delete cascade,
    org_id uuid,
    action text not null,
    target_type text,
    target_id uuid,
    severity text not null default 'info'
        check (severity in ('info','warning','critical','debug')),
    ip_address text,
    payload jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_audit_log_owner
    on public.audit_log_entries (owner_id, created_at desc);

create table if not exists public.data_exports (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid not null references auth.users (id) on delete cascade,
    org_id uuid,
    export_type text not null
        check (export_type in ('wallet','journeys','budgets','full','custom')),
    format text not null
        check (format in ('csv','pdf')),
    status text not null default 'queued'
        check (status in ('queued','processing','ready','failed')),
    requested_at timestamptz not null default timezone('utc', now()),
    completed_at timestamptz,
    expires_at timestamptz,
    download_url text,
    payload jsonb not null default '{}',
    error_message text,
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_data_exports_owner
    on public.data_exports (owner_id, requested_at desc);

-- -----------------------------------------------------------------------------
-- Accounting connectors & webhook placeholders
-- -----------------------------------------------------------------------------
create table if not exists public.accounting_connectors (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid not null references auth.users (id) on delete cascade,
    org_id uuid,
    provider text not null,
    status text not null default 'disconnected'
        check (status in ('disconnected','connecting','connected','error')),
    webhook_url text,
    last_sync_at timestamptz,
    credentials jsonb not null default '{}',
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now()),
    constraint accounting_connector_owner_provider_unique unique (owner_id, provider)
);

create index if not exists idx_accounting_connectors_owner
    on public.accounting_connectors (owner_id);

create table if not exists public.accounting_connector_events (
    id uuid primary key default gen_random_uuid(),
    connector_id uuid not null references public.accounting_connectors (id) on delete cascade,
    owner_id uuid not null references auth.users (id) on delete cascade,
    event_type text not null,
    status text not null default 'queued'
        check (status in ('queued','sent','failed')),
    payload jsonb not null default '{}',
    response jsonb,
    created_at timestamptz not null default timezone('utc', now()),
    processed_at timestamptz
);

create index if not exists idx_accounting_events_owner
    on public.accounting_connector_events (owner_id, created_at desc);

-- -----------------------------------------------------------------------------
-- Timestamp triggers
-- -----------------------------------------------------------------------------
create trigger trg_user_profiles_updated
    before update on public.user_profiles
    for each row execute function public.handle_updated_at();

create trigger trg_linked_accounts_updated
    before update on public.linked_accounts
    for each row execute function public.handle_updated_at();

create trigger trg_subscription_plans_updated
    before update on public.subscription_plans
    for each row execute function public.handle_updated_at();

create trigger trg_user_subscriptions_updated
    before update on public.user_subscriptions
    for each row execute function public.handle_updated_at();

create trigger trg_app_preferences_updated
    before update on public.app_preferences
    for each row execute function public.handle_updated_at();

create trigger trg_user_sessions_updated
    before update on public.user_sessions
    for each row execute function public.handle_updated_at();

create trigger trg_data_exports_updated
    before update on public.data_exports
    for each row execute function public.handle_updated_at();

create trigger trg_accounting_connectors_updated
    before update on public.accounting_connectors
    for each row execute function public.handle_updated_at();

-- -----------------------------------------------------------------------------
-- Row level security
-- -----------------------------------------------------------------------------
alter table public.user_profiles enable row level security;
alter table public.linked_accounts enable row level security;
alter table public.user_subscriptions enable row level security;
alter table public.app_preferences enable row level security;
alter table public.user_sessions enable row level security;
alter table public.audit_log_entries enable row level security;
alter table public.data_exports enable row level security;
alter table public.accounting_connectors enable row level security;
alter table public.accounting_connector_events enable row level security;

create policy "User profiles manageable by owner"
    on public.user_profiles for all
    using (user_id = auth.uid())
    with check (user_id = auth.uid());

create policy "Linked accounts manageable by owner"
    on public.linked_accounts for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

create policy "Subscriptions manageable by owner"
    on public.user_subscriptions for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

create policy "Preferences manageable by owner"
    on public.app_preferences for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

create policy "Sessions manageable by owner"
    on public.user_sessions for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

create policy "Audit log readable by owner"
    on public.audit_log_entries for select
    using (owner_id = auth.uid());

create policy "Data exports manageable by owner"
    on public.data_exports for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

create policy "Accounting connectors manageable by owner"
    on public.accounting_connectors for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

create policy "Connector events readable by owner"
    on public.accounting_connector_events for select
    using (owner_id = auth.uid());

create policy "Connector events insert by owner"
    on public.accounting_connector_events for insert
    with check (owner_id = auth.uid());

-- -----------------------------------------------------------------------------
-- Helper + RPC functions
-- -----------------------------------------------------------------------------
create or replace function public.log_audit_event(
    p_action text,
    p_target_type text default null,
    p_target_id uuid default null,
    p_severity text default 'info',
    p_payload jsonb default '{}'::jsonb
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
    owner_uuid uuid := auth.uid();
    target_org uuid;
begin
    if owner_uuid is null then
        return;
    end if;

    select org_id into target_org
    from public.user_profiles
    where user_id = owner_uuid
    limit 1;

    insert into public.audit_log_entries (
        owner_id,
        org_id,
        action,
        target_type,
        target_id,
        severity,
        payload
    ) values (
        owner_uuid,
        target_org,
        coalesce(p_action, 'event'),
        p_target_type,
        p_target_id,
        coalesce(p_severity, 'info'),
        coalesce(p_payload, '{}'::jsonb)
    );
end;
$$;

grant execute on function public.log_audit_event(text, text, uuid, text, jsonb) to authenticated;
grant execute on function public.log_audit_event(text, text, uuid, text, jsonb) to service_role;

create or replace function public.update_user_profile(
    p_full_name text,
    p_phone text default null,
    p_avatar_url text default null,
    p_job_title text default null,
    p_country text default null,
    p_timezone text default null
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
    owner_uuid uuid := auth.uid();
    owner_email text;
    updated_row user_profiles%rowtype;
begin
    if owner_uuid is null then
        raise exception 'Not authenticated';
    end if;

    select email into owner_email from auth.users where id = owner_uuid;

    insert into public.user_profiles (
        user_id,
        org_id,
        full_name,
        email,
        phone,
        avatar_url,
        job_title,
        country,
        timezone
    ) values (
        owner_uuid,
        null,
        coalesce(nullif(trim(p_full_name), ''), owner_email),
        owner_email,
        p_phone,
        p_avatar_url,
        p_job_title,
        p_country,
        p_timezone
    ) on conflict (user_id) do update set
        full_name = coalesce(nullif(trim(p_full_name), ''), public.user_profiles.full_name),
        phone = coalesce(p_phone, public.user_profiles.phone),
        avatar_url = coalesce(p_avatar_url, public.user_profiles.avatar_url),
        job_title = coalesce(p_job_title, public.user_profiles.job_title),
        country = coalesce(p_country, public.user_profiles.country),
        timezone = coalesce(p_timezone, public.user_profiles.timezone),
        updated_at = timezone('utc', now())
    returning * into updated_row;

    perform public.log_audit_event('profile_updated', 'profile', owner_uuid, 'info', jsonb_build_object('fullName', updated_row.full_name));

    return to_jsonb(updated_row);
end;
$$;

grant execute on function public.update_user_profile(text, text, text, text, text, text) to authenticated;
grant execute on function public.update_user_profile(text, text, text, text, text, text) to service_role;

create or replace function public.update_app_preferences(
    p_preferred_currency text default null,
    p_dark_mode text default null,
    p_notifications_enabled boolean default null,
    p_face_id_enabled boolean default null,
    p_feature_flags jsonb default null
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
    owner_uuid uuid := auth.uid();
    result_row app_preferences%rowtype;
begin
    if owner_uuid is null then
        raise exception 'Not authenticated';
    end if;

    insert into public.app_preferences (
        owner_id,
        preferred_currency,
        dark_mode,
        notifications_enabled,
        face_id_enabled,
        feature_flags
    ) values (
        owner_uuid,
        coalesce(p_preferred_currency, 'EGP'),
        coalesce(p_dark_mode, 'system'),
        coalesce(p_notifications_enabled, true),
        coalesce(p_face_id_enabled, false),
        coalesce(p_feature_flags, '{}'::jsonb)
    ) on conflict (owner_id) do update set
        preferred_currency = coalesce(p_preferred_currency, public.app_preferences.preferred_currency),
        dark_mode = coalesce(p_dark_mode, public.app_preferences.dark_mode),
        notifications_enabled = coalesce(p_notifications_enabled, public.app_preferences.notifications_enabled),
        face_id_enabled = coalesce(p_face_id_enabled, public.app_preferences.face_id_enabled),
        feature_flags = coalesce(p_feature_flags, public.app_preferences.feature_flags),
        updated_at = timezone('utc', now())
    returning * into result_row;

    perform public.log_audit_event('preferences_updated', 'preferences', owner_uuid, 'info', jsonb_build_object(
        'currency', result_row.preferred_currency,
        'darkMode', result_row.dark_mode,
        'notificationsEnabled', result_row.notifications_enabled
    ));

    return to_jsonb(result_row);
end;
$$;

grant execute on function public.update_app_preferences(text, text, boolean, boolean, jsonb) to authenticated;
grant execute on function public.update_app_preferences(text, text, boolean, boolean, jsonb) to service_role;

create or replace function public.request_data_export(
    p_export_type text,
    p_format text default 'pdf'
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
    owner_uuid uuid := auth.uid();
    org_uuid uuid;
    export_row data_exports%rowtype;
begin
    if owner_uuid is null then
        raise exception 'Not authenticated';
    end if;

    select org_id into org_uuid from public.user_profiles where user_id = owner_uuid limit 1;

    insert into public.data_exports (
        owner_id,
        org_id,
        export_type,
        format,
        status,
        requested_at,
        expires_at,
        payload
    ) values (
        owner_uuid,
        org_uuid,
        lower(p_export_type),
        lower(p_format),
        'queued',
        timezone('utc', now()),
        timezone('utc', now()) + interval '3 days',
        jsonb_build_object('requestedFrom', 'mobile')
    ) returning * into export_row;

    perform public.log_audit_event('data_export_requested', 'data_exports', export_row.id, 'info', jsonb_build_object('type', export_row.export_type, 'format', export_row.format));

    return to_jsonb(export_row);
end;
$$;

grant execute on function public.request_data_export(text, text) to authenticated;
grant execute on function public.request_data_export(text, text) to service_role;

create or replace function public.revoke_user_session(p_session_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
    owner_uuid uuid := auth.uid();
    session_row user_sessions%rowtype;
begin
    if owner_uuid is null then
        raise exception 'Not authenticated';
    end if;

    update public.user_sessions
    set status = 'revoked',
        updated_at = timezone('utc', now())
    where id = p_session_id
      and owner_id = owner_uuid
    returning * into session_row;

    if not found then
        return '{}'::jsonb;
    end if;

    perform public.log_audit_event('session_revoked', 'user_sessions', p_session_id, 'warning', jsonb_build_object('device', session_row.device_name));

    return to_jsonb(session_row);
end;
$$;

grant execute on function public.revoke_user_session(uuid) to authenticated;
grant execute on function public.revoke_user_session(uuid) to service_role;

create or replace function public.connect_accounting_provider(p_provider text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
    owner_uuid uuid := auth.uid();
    org_uuid uuid;
    connector_row accounting_connectors%rowtype;
begin
    if owner_uuid is null then
        raise exception 'Not authenticated';
    end if;

    select org_id into org_uuid from public.user_profiles where user_id = owner_uuid limit 1;

    insert into public.accounting_connectors (
        owner_id,
        org_id,
        provider,
        status,
        webhook_url,
        last_sync_at,
        credentials,
        metadata
    ) values (
        owner_uuid,
        org_uuid,
        lower(p_provider),
        'connected',
        concat('https://hooks.paysettle.app/', gen_random_uuid()),
        timezone('utc', now()),
        jsonb_build_object('scopes', array['ledger','invoices']),
        jsonb_build_object('connectedFrom', 'mobile')
    ) on conflict (owner_id, provider) do update set
        status = 'connected',
        last_sync_at = timezone('utc', now()),
        updated_at = timezone('utc', now())
    returning * into connector_row;

    perform public.log_audit_event('connector_connected', 'accounting_connectors', connector_row.id, 'info', jsonb_build_object('provider', connector_row.provider));

    return to_jsonb(connector_row);
end;
$$;

grant execute on function public.connect_accounting_provider(text) to authenticated;
grant execute on function public.connect_accounting_provider(text) to service_role;

create or replace function public.trigger_connector_webhook(
    p_connector_id uuid,
    p_event text,
    p_payload jsonb default '{}'::jsonb
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
    owner_uuid uuid := auth.uid();
    connector_row accounting_connectors%rowtype;
    event_row accounting_connector_events%rowtype;
begin
    if owner_uuid is null then
        raise exception 'Not authenticated';
    end if;

    select * into connector_row
    from public.accounting_connectors
    where id = p_connector_id
      and owner_id = owner_uuid
    limit 1;

    if connector_row.id is null then
        raise exception 'Connector not found';
    end if;

    insert into public.accounting_connector_events (
        connector_id,
        owner_id,
        event_type,
        status,
        payload
    ) values (
        connector_row.id,
        owner_uuid,
        coalesce(p_event, 'sync'),
        'queued',
        coalesce(p_payload, '{}'::jsonb)
    ) returning * into event_row;

    perform public.log_audit_event('connector_event', 'accounting_connector_events', event_row.id, 'debug', jsonb_build_object('event', event_row.event_type));

    return to_jsonb(event_row);
end;
$$;

grant execute on function public.trigger_connector_webhook(uuid, text, jsonb) to authenticated;
grant execute on function public.trigger_connector_webhook(uuid, text, jsonb) to service_role;

create or replace function public.settings_overview()
returns jsonb
language plpgsql
security definer
set search_path = public
stable
as $$
declare
    owner_uuid uuid := auth.uid();
    payload jsonb;
begin
    if owner_uuid is null then
        return '{}'::jsonb;
    end if;

    insert into public.user_profiles (user_id, full_name, email)
    select owner_uuid,
           coalesce(u.raw_user_meta_data ->> 'full_name', u.email),
           u.email
    from auth.users u
    where u.id = owner_uuid
    on conflict (user_id) do nothing;

    insert into public.app_preferences (owner_id)
    values (owner_uuid)
    on conflict (owner_id) do nothing;

    select jsonb_build_object(
        'profile', coalesce((
            select jsonb_build_object(
                'fullName', up.full_name,
                'email', up.email,
                'phone', up.phone,
                'avatarUrl', up.avatar_url,
                'jobTitle', up.job_title,
                'country', up.country,
                'timezone', up.timezone,
                'orgId', up.org_id,
                'metadata', up.metadata
            ) from public.user_profiles up
            where up.user_id = owner_uuid
        ), '{}'::jsonb),
        'preferences', coalesce((
            select jsonb_build_object(
                'preferredCurrency', ap.preferred_currency,
                'darkMode', ap.dark_mode,
                'notificationsEnabled', ap.notifications_enabled,
                'faceIdEnabled', ap.face_id_enabled,
                'autoExportFormat', ap.auto_export_format,
                'featureFlags', ap.feature_flags,
                'availableCurrencies', jsonb_build_array('EGP','USD','EUR','GBP','AED')
            ) from public.app_preferences ap
            where ap.owner_id = owner_uuid
        ), '{}'::jsonb),
        'subscription', coalesce((
            select jsonb_build_object(
                'planId', us.id,
                'planName', sp.name,
                'tier', sp.tier,
                'status', us.status,
                'renewsOn', us.renews_on,
                'expiresOn', us.expires_on,
                'seats', us.seats,
                'features', to_jsonb(sp.features)
            ) from public.user_subscriptions us
            join public.subscription_plans sp on sp.id = us.plan_id
            where us.owner_id = owner_uuid
            order by us.created_at desc
            limit 1
        ), jsonb_build_object(
            'planName', 'Starter',
            'tier', 'Free',
            'status', 'trial',
            'features', jsonb_build_array('Wallet','Budgeting','Notifications')
        )),
        'linkedAccounts', coalesce((
            select jsonb_agg(jsonb_build_object(
                'id', la.id,
                'provider', la.provider,
                'accountName', la.account_name,
                'status', la.status,
                'lastSyncedAt', la.last_synced_at,
                'metadata', la.metadata
            ) order by la.created_at desc)
            from public.linked_accounts la
            where la.owner_id = owner_uuid
        ), '[]'::jsonb),
        'sessions', coalesce((
            select jsonb_agg(entry) from (
                select jsonb_build_object(
                    'id', us.id,
                    'deviceName', us.device_name,
                    'platform', us.platform,
                    'location', coalesce(us.location, us.ip_address),
                    'status', us.status,
                    'isCurrent', us.is_current,
                    'lastSeenAt', us.last_seen_at
                ) as entry
                from public.user_sessions us
                where us.owner_id = owner_uuid
                order by us.last_seen_at desc
                limit 10
            ) session_entries
        ), '[]'::jsonb),
        'connectors', coalesce((
            select jsonb_agg(jsonb_build_object(
                'id', ac.id,
                'provider', ac.provider,
                'status', ac.status,
                'lastSyncAt', ac.last_sync_at,
                'webhookUrl', ac.webhook_url,
                'metadata', ac.metadata
            ))
            from public.accounting_connectors ac
            where ac.owner_id = owner_uuid
        ), '[]'::jsonb),
        'exports', coalesce((
            select jsonb_agg(entry) from (
                select jsonb_build_object(
                    'id', de.id,
                    'type', de.export_type,
                    'format', de.format,
                    'status', de.status,
                    'requestedAt', de.requested_at,
                    'completedAt', de.completed_at,
                    'downloadUrl', de.download_url
                ) as entry
                from public.data_exports de
                where de.owner_id = owner_uuid
                order by de.requested_at desc
                limit 5
            ) export_entries
        ), '[]'::jsonb),
        'auditLog', coalesce((
            select jsonb_agg(entry) from (
                select jsonb_build_object(
                    'id', al.id,
                    'action', al.action,
                    'targetType', al.target_type,
                    'severity', al.severity,
                    'createdAt', al.created_at,
                    'payload', al.payload
                ) as entry
                from public.audit_log_entries al
                where al.owner_id = owner_uuid
                order by al.created_at desc
                limit 5
            ) audit_entries
        ), '[]'::jsonb)
    ) into payload;

    return payload;
end;
$$;

grant execute on function public.settings_overview() to authenticated;
grant execute on function public.settings_overview() to service_role;

-- -----------------------------------------------------------------------------
-- Seed baseline plans
-- -----------------------------------------------------------------------------
insert into public.subscription_plans (slug, name, tier, description, price, currency, billing_interval, features)
values
    ('starter', 'Starter', 'Free', 'Core budgeting & wallet access', 0, 'USD', 'monthly', array['Wallet','Budgets','Notifications']),
    ('pro-active', 'Pro Active', 'Pro', 'Advanced analytics and exports', 19, 'USD', 'monthly', array['Wallet','Budgets','Analytics','Exports'])
on conflict (slug) do update set
    name = excluded.name,
    tier = excluded.tier,
    description = excluded.description,
    price = excluded.price,
    features = excluded.features,
    updated_at = timezone('utc', now());
