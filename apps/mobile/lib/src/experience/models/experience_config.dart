import 'package:freezed_annotation/freezed_annotation.dart';

part 'experience_config.freezed.dart';
part 'experience_config.g.dart';

@freezed
class ExperienceConfig with _$ExperienceConfig {
  const factory ExperienceConfig({
    @Default(<FeatureFlag>[]) List<FeatureFlag> featureFlags,
    ThemeOverride? theme,
  }) = _ExperienceConfig;

  factory ExperienceConfig.fromJson(Map<String, dynamic> json) =>
      _$ExperienceConfigFromJson(json);
}

@freezed
class FeatureFlag with _$FeatureFlag {
  const factory FeatureFlag({
    required String key,
    @Default(false) bool enabled,
    @Default('control') String variant,
    @JsonKey(name: 'rollout') @Default(0) int rolloutPercentage,
    @Default(<String>[]) List<String> tags,
    String? description,
    @Default(<String, dynamic>{}) Map<String, dynamic> payload,
    DateTime? updatedAt,
  }) = _FeatureFlag;

  factory FeatureFlag.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagFromJson(json);
}

@freezed
class ThemeOverride with _$ThemeOverride {
  const factory ThemeOverride({
    required String slug,
    required ThemePalette light,
    required ThemePalette dark,
    double? cornerRadius,
  }) = _ThemeOverride;

  factory ThemeOverride.fromJson(Map<String, dynamic> json) =>
      _$ThemeOverrideFromJson(json);
}

@freezed
class ThemePalette with _$ThemePalette {
  const factory ThemePalette({
    String? primary,
    String? surface,
    String? background,
    String? textPrimary,
    String? textSecondary,
    String? accent,
    String? success,
    String? warning,
    String? error,
  }) = _ThemePalette;

  factory ThemePalette.fromJson(Map<String, dynamic> json) =>
      _$ThemePaletteFromJson(json);
}
