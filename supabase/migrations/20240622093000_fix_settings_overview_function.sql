-- Ensure settings_overview can perform inserts when bootstrapping defaults
alter function public.settings_overview()
    volatile;
