-- Phase 6 – Performance, feature flags, and experience configuration.

-- -----------------------------------------------------------------------------
-- Feature flag + theme configuration tables
-- -----------------------------------------------------------------------------
create table if not exists public.experience_feature_flags (
    id uuid primary key default gen_random_uuid(),
    key text not null unique,
    description text,
    enabled boolean not null default false,
    rollout_percentage int not null default 0 check (rollout_percentage between 0 and 100),
    variant text not null default 'control',
    tags text[] not null default '{}',
    target_org uuid,
    target_user uuid,
    expires_at timestamptz,
    payload jsonb not null default '{}',
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_experience_feature_flags_target_org
    on public.experience_feature_flags (target_org);
create index if not exists idx_experience_feature_flags_target_user
    on public.experience_feature_flags (target_user);

create table if not exists public.experience_flag_audits (
    id uuid primary key default gen_random_uuid(),
    flag_id uuid not null references public.experience_feature_flags (id) on delete cascade,
    actor_id uuid,
    action text not null,
    details jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_experience_flag_audits_flag
    on public.experience_flag_audits (flag_id, created_at desc);

create table if not exists public.experience_themes (
    id uuid primary key default gen_random_uuid(),
    slug text not null unique,
    name text not null,
    is_active boolean not null default false,
    payload jsonb not null default '{}',
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.experience_theme_assignments (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid references auth.users (id) on delete cascade,
    org_id uuid,
    theme_id uuid not null references public.experience_themes (id) on delete cascade,
    status text not null default 'active' check (status in ('active','disabled')),
    metadata jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now()),
    constraint experience_theme_assignment_owner_unique unique (owner_id),
    constraint experience_theme_assignment_org_unique unique (org_id)
);

-- -----------------------------------------------------------------------------
-- Performance telemetry tables
-- -----------------------------------------------------------------------------
create table if not exists public.performance_sessions (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid not null references auth.users (id) on delete cascade,
    org_id uuid,
    device_id text,
    platform text,
    app_version text,
    session_started_at timestamptz not null default timezone('utc', now()),
    duration_ms int,
    metrics_summary jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now()),
    updated_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_performance_sessions_owner
    on public.performance_sessions (owner_id, created_at desc);

create table if not exists public.performance_samples (
    id uuid primary key default gen_random_uuid(),
    session_id uuid not null references public.performance_sessions (id) on delete cascade,
    sample_type text not null,
    frame_count int,
    dropped_frames int,
    avg_frame_time_ms numeric,
    max_frame_time_ms numeric,
    payload jsonb not null default '{}',
    created_at timestamptz not null default timezone('utc', now())
);

create index if not exists idx_performance_samples_session
    on public.performance_samples (session_id);

-- -----------------------------------------------------------------------------
-- Triggers
-- -----------------------------------------------------------------------------
create trigger trg_experience_feature_flags_updated
    before update on public.experience_feature_flags
    for each row execute function public.handle_updated_at();

create trigger trg_experience_themes_updated
    before update on public.experience_themes
    for each row execute function public.handle_updated_at();

create trigger trg_experience_theme_assignments_updated
    before update on public.experience_theme_assignments
    for each row execute function public.handle_updated_at();

create trigger trg_performance_sessions_updated
    before update on public.performance_sessions
    for each row execute function public.handle_updated_at();

-- -----------------------------------------------------------------------------
-- Row level security & policies
-- -----------------------------------------------------------------------------
alter table public.experience_feature_flags enable row level security;
alter table public.experience_flag_audits enable row level security;
alter table public.experience_themes enable row level security;
alter table public.experience_theme_assignments enable row level security;
alter table public.performance_sessions enable row level security;
alter table public.performance_samples enable row level security;

create policy "Feature flags readable"
    on public.experience_feature_flags for select
    using (true);

create policy "Feature flags managed by service role"
    on public.experience_feature_flags for all
    using (auth.role() = 'service_role')
    with check (auth.role() = 'service_role');

create policy "Flag audits readable by service role"
    on public.experience_flag_audits for select
    using (auth.role() = 'service_role');

create policy "Themes readable"
    on public.experience_themes for select
    using (true);

create policy "Themes managed by service role"
    on public.experience_themes for all
    using (auth.role() = 'service_role')
    with check (auth.role() = 'service_role');

create policy "Theme assignments readable"
    on public.experience_theme_assignments for select
    using ((owner_id is null or owner_id = auth.uid())
        and (org_id is null or org_id in (
            select org_id from public.user_profiles where user_id = auth.uid()
        )) or auth.role() = 'service_role');

create policy "Theme assignments managed by service role"
    on public.experience_theme_assignments for all
    using (auth.role() = 'service_role')
    with check (auth.role() = 'service_role');

create policy "Performance sessions owned"
    on public.performance_sessions for all
    using (owner_id = auth.uid())
    with check (owner_id = auth.uid());

create policy "Performance samples owned"
    on public.performance_samples for all
    using (session_id in (
        select id from public.performance_sessions where owner_id = auth.uid()
    ))
    with check (session_id in (
        select id from public.performance_sessions where owner_id = auth.uid()
    ));

-- -----------------------------------------------------------------------------
-- Helper functions & RPCs
-- -----------------------------------------------------------------------------
create or replace function public.experience_config(p_force_refresh boolean default false)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
    user_uuid uuid := auth.uid();
    org_uuid uuid;
    flags jsonb := '[]'::jsonb;
    theme jsonb := '{}'::jsonb;
    hash_bytes bytea;
    rollout_bucket int := 0;
begin
    if user_uuid is not null then
        select org_id into org_uuid from public.user_profiles where user_id = user_uuid limit 1;
        hash_bytes := digest(user_uuid::text, 'sha256');
        rollout_bucket := abs(((get_byte(hash_bytes, 0) << 24)
            + (get_byte(hash_bytes, 1) << 16)
            + (get_byte(hash_bytes, 2) << 8)
            + get_byte(hash_bytes, 3)) % 100);
    end if;

    select coalesce(jsonb_agg(jsonb_build_object(
            'key', key,
            'description', description,
            'variant', variant,
            'enabled', enabled,
            'rollout', rollout_percentage,
            'tags', tags,
            'payload', payload,
            'updatedAt', updated_at
        )), '[]'::jsonb)
    into flags
    from public.experience_feature_flags f
    where enabled
      and (
        user_uuid is null
        or rollout_percentage >= 100
        or (rollout_percentage > 0 and rollout_bucket < rollout_percentage)
        or (target_org is not null and target_org = org_uuid)
        or (target_user is not null and target_user = user_uuid)
      );

    select row_to_json(t)::jsonb
    into theme
    from public.experience_themes t
    where t.is_active
    order by t.updated_at desc
    limit 1;

    if user_uuid is not null then
        select row_to_json(et)::jsonb
        into theme
        from public.experience_theme_assignments eta
        join public.experience_themes et on et.id = eta.theme_id
        where (eta.owner_id is not null and eta.owner_id = user_uuid)
           or (eta.org_id is not null and eta.org_id = org_uuid)
        order by eta.owner_id desc, eta.updated_at desc
        limit 1;

        if theme is null then
            select row_to_json(t)::jsonb
            into theme
            from public.experience_themes t
            where t.is_active
            order by t.updated_at desc
            limit 1;
        end if;
    end if;

    return jsonb_build_object(
        'featureFlags', coalesce(flags, '[]'::jsonb),
        'theme', coalesce(theme, '{}'::jsonb)
    );
end;
$$;

comment on function public.experience_config is 'Returns active feature flags + effective theme payload for the current user/org.';

create or replace function public.log_performance_session(p_metrics jsonb)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
    owner_uuid uuid := auth.uid();
    org_uuid uuid;
    new_session_id uuid;
begin
    if owner_uuid is null then
        return null;
    end if;

    select org_id into org_uuid from public.user_profiles where user_id = owner_uuid limit 1;

    insert into public.performance_sessions (
        owner_id,
        org_id,
        device_id,
        platform,
        app_version,
        session_started_at,
        duration_ms,
        metrics_summary
    ) values (
        owner_uuid,
        org_uuid,
        coalesce(p_metrics->>'deviceId', 'unknown'),
        p_metrics->>'platform',
        p_metrics->>'appVersion',
        coalesce((p_metrics->>'startedAt')::timestamptz, timezone('utc', now())),
        (p_metrics->>'durationMs')::int,
        coalesce(p_metrics->'summary', '{}'::jsonb)
    ) returning id into new_session_id;

    if p_metrics ? 'samples' then
        insert into public.performance_samples (
            session_id,
            sample_type,
            frame_count,
            dropped_frames,
            avg_frame_time_ms,
            max_frame_time_ms,
            payload
        )
        select new_session_id,
            sample->>'type',
            (sample->>'frameCount')::int,
            (sample->>'droppedFrames')::int,
            (sample->>'avgFrameTimeMs')::numeric,
            (sample->>'maxFrameTimeMs')::numeric,
            sample - 'type' - 'frameCount' - 'droppedFrames' - 'avgFrameTimeMs' - 'maxFrameTimeMs'
        from jsonb_array_elements(p_metrics->'samples') as sample;
    end if;

    return new_session_id;
end;
$$;

comment on function public.log_performance_session is 'Stores client-side performance metrics + samples for later analysis.';
