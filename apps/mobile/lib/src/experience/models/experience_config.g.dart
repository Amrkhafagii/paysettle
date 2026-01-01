// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExperienceConfigImpl _$$ExperienceConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ExperienceConfigImpl(
      featureFlags: (json['featureFlags'] as List<dynamic>?)
              ?.map((e) => FeatureFlag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FeatureFlag>[],
      theme: json['theme'] == null
          ? null
          : ThemeOverride.fromJson(json['theme'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ExperienceConfigImplToJson(
        _$ExperienceConfigImpl instance) =>
    <String, dynamic>{
      'featureFlags': instance.featureFlags,
      'theme': instance.theme,
    };

_$FeatureFlagImpl _$$FeatureFlagImplFromJson(Map<String, dynamic> json) =>
    _$FeatureFlagImpl(
      key: json['key'] as String,
      enabled: json['enabled'] as bool? ?? false,
      variant: json['variant'] as String? ?? 'control',
      rolloutPercentage: (json['rollout'] as num?)?.toInt() ?? 0,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      description: json['description'] as String?,
      payload:
          json['payload'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$FeatureFlagImplToJson(_$FeatureFlagImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'enabled': instance.enabled,
      'variant': instance.variant,
      'rollout': instance.rolloutPercentage,
      'tags': instance.tags,
      'description': instance.description,
      'payload': instance.payload,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$ThemeOverrideImpl _$$ThemeOverrideImplFromJson(Map<String, dynamic> json) =>
    _$ThemeOverrideImpl(
      slug: json['slug'] as String,
      light: ThemePalette.fromJson(json['light'] as Map<String, dynamic>),
      dark: ThemePalette.fromJson(json['dark'] as Map<String, dynamic>),
      cornerRadius: (json['cornerRadius'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ThemeOverrideImplToJson(_$ThemeOverrideImpl instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'light': instance.light,
      'dark': instance.dark,
      'cornerRadius': instance.cornerRadius,
    };

_$ThemePaletteImpl _$$ThemePaletteImplFromJson(Map<String, dynamic> json) =>
    _$ThemePaletteImpl(
      primary: json['primary'] as String?,
      surface: json['surface'] as String?,
      background: json['background'] as String?,
      textPrimary: json['textPrimary'] as String?,
      textSecondary: json['textSecondary'] as String?,
      accent: json['accent'] as String?,
      success: json['success'] as String?,
      warning: json['warning'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$ThemePaletteImplToJson(_$ThemePaletteImpl instance) =>
    <String, dynamic>{
      'primary': instance.primary,
      'surface': instance.surface,
      'background': instance.background,
      'textPrimary': instance.textPrimary,
      'textSecondary': instance.textSecondary,
      'accent': instance.accent,
      'success': instance.success,
      'warning': instance.warning,
      'error': instance.error,
    };
