# API Contract – `experience_config`

## Endpoint

Supabase RPC: `select * from experience_config(p_force_refresh => false)`

## Response Shape

```jsonc
{
  "featureFlags": [
    {
      "key": "budget_csv_export",
      "description": "Expose CSV exports inside Budgeting module",
      "variant": "control",
      "rollout": 50,
      "payload": {"ctaLabel": "Download CSV"},
      "enabled": true,
      "tags": ["budgeting", "beta"],
      "updatedAt": "2024-06-20T09:00:00Z"
    }
  ],
  "theme": {
    "slug": "mint_core",
    "light": {
      "primary": "#29A961",
      "surface": "#FFFFFF",
      "background": "#F9FBF8",
      "textPrimary": "#0F4D2A",
      "textSecondary": "#5E665E",
      "accent": "#0ACF83"
    },
    "dark": {
      "primary": "#6FCE90",
      "surface": "#111611",
      "background": "#0A371D",
      "textPrimary": "#F7F8F6",
      "textSecondary": "#C5CBC5",
      "accent": "#0ACF83"
    },
    "cornerRadius": 24.0
  }
}
```

Fields are optional; the client merges missing tokens with local defaults.

## Usage Guidelines

- Flags without `enabled: true` are ignored regardless of rollout %. Use `payload` for arbitrary structured data.
- The RPC auto-filters flags based on rollout rules (global %, org targeting, explicit overrides).
- Theme payloads can ship typography + spacing in the future. For now we only parse colors + corner radius.

## Error Modes

- `42501` – user not authenticated; client should fall back to cached config.
- `P0001` – invalid rollout definition; RPC logs to `experience_flag_audits` and returns defaults.

## Related RPCs

- `log_performance_session(p_metrics jsonb)` – receives the metrics blob emitted by `FrameTimingsMonitor` once per session or when the user explicitly exports diagnostics.
