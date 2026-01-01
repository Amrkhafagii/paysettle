// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'experience_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExperienceConfig _$ExperienceConfigFromJson(Map<String, dynamic> json) {
  return _ExperienceConfig.fromJson(json);
}

/// @nodoc
mixin _$ExperienceConfig {
  List<FeatureFlag> get featureFlags => throw _privateConstructorUsedError;
  ThemeOverride? get theme => throw _privateConstructorUsedError;

  /// Serializes this ExperienceConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExperienceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExperienceConfigCopyWith<ExperienceConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperienceConfigCopyWith<$Res> {
  factory $ExperienceConfigCopyWith(
          ExperienceConfig value, $Res Function(ExperienceConfig) then) =
      _$ExperienceConfigCopyWithImpl<$Res, ExperienceConfig>;
  @useResult
  $Res call({List<FeatureFlag> featureFlags, ThemeOverride? theme});

  $ThemeOverrideCopyWith<$Res>? get theme;
}

/// @nodoc
class _$ExperienceConfigCopyWithImpl<$Res, $Val extends ExperienceConfig>
    implements $ExperienceConfigCopyWith<$Res> {
  _$ExperienceConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExperienceConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? featureFlags = null,
    Object? theme = freezed,
  }) {
    return _then(_value.copyWith(
      featureFlags: null == featureFlags
          ? _value.featureFlags
          : featureFlags // ignore: cast_nullable_to_non_nullable
              as List<FeatureFlag>,
      theme: freezed == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeOverride?,
    ) as $Val);
  }

  /// Create a copy of ExperienceConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThemeOverrideCopyWith<$Res>? get theme {
    if (_value.theme == null) {
      return null;
    }

    return $ThemeOverrideCopyWith<$Res>(_value.theme!, (value) {
      return _then(_value.copyWith(theme: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExperienceConfigImplCopyWith<$Res>
    implements $ExperienceConfigCopyWith<$Res> {
  factory _$$ExperienceConfigImplCopyWith(_$ExperienceConfigImpl value,
          $Res Function(_$ExperienceConfigImpl) then) =
      __$$ExperienceConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FeatureFlag> featureFlags, ThemeOverride? theme});

  @override
  $ThemeOverrideCopyWith<$Res>? get theme;
}

/// @nodoc
class __$$ExperienceConfigImplCopyWithImpl<$Res>
    extends _$ExperienceConfigCopyWithImpl<$Res, _$ExperienceConfigImpl>
    implements _$$ExperienceConfigImplCopyWith<$Res> {
  __$$ExperienceConfigImplCopyWithImpl(_$ExperienceConfigImpl _value,
      $Res Function(_$ExperienceConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExperienceConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? featureFlags = null,
    Object? theme = freezed,
  }) {
    return _then(_$ExperienceConfigImpl(
      featureFlags: null == featureFlags
          ? _value._featureFlags
          : featureFlags // ignore: cast_nullable_to_non_nullable
              as List<FeatureFlag>,
      theme: freezed == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeOverride?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExperienceConfigImpl implements _ExperienceConfig {
  const _$ExperienceConfigImpl(
      {final List<FeatureFlag> featureFlags = const <FeatureFlag>[],
      this.theme})
      : _featureFlags = featureFlags;

  factory _$ExperienceConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExperienceConfigImplFromJson(json);

  final List<FeatureFlag> _featureFlags;
  @override
  @JsonKey()
  List<FeatureFlag> get featureFlags {
    if (_featureFlags is EqualUnmodifiableListView) return _featureFlags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_featureFlags);
  }

  @override
  final ThemeOverride? theme;

  @override
  String toString() {
    return 'ExperienceConfig(featureFlags: $featureFlags, theme: $theme)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperienceConfigImpl &&
            const DeepCollectionEquality()
                .equals(other._featureFlags, _featureFlags) &&
            (identical(other.theme, theme) || other.theme == theme));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_featureFlags), theme);

  /// Create a copy of ExperienceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExperienceConfigImplCopyWith<_$ExperienceConfigImpl> get copyWith =>
      __$$ExperienceConfigImplCopyWithImpl<_$ExperienceConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperienceConfigImplToJson(
      this,
    );
  }
}

abstract class _ExperienceConfig implements ExperienceConfig {
  const factory _ExperienceConfig(
      {final List<FeatureFlag> featureFlags,
      final ThemeOverride? theme}) = _$ExperienceConfigImpl;

  factory _ExperienceConfig.fromJson(Map<String, dynamic> json) =
      _$ExperienceConfigImpl.fromJson;

  @override
  List<FeatureFlag> get featureFlags;
  @override
  ThemeOverride? get theme;

  /// Create a copy of ExperienceConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExperienceConfigImplCopyWith<_$ExperienceConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FeatureFlag _$FeatureFlagFromJson(Map<String, dynamic> json) {
  return _FeatureFlag.fromJson(json);
}

/// @nodoc
mixin _$FeatureFlag {
  String get key => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  String get variant => throw _privateConstructorUsedError;
  @JsonKey(name: 'rollout')
  int get rolloutPercentage => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Map<String, dynamic> get payload => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this FeatureFlag to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeatureFlag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeatureFlagCopyWith<FeatureFlag> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeatureFlagCopyWith<$Res> {
  factory $FeatureFlagCopyWith(
          FeatureFlag value, $Res Function(FeatureFlag) then) =
      _$FeatureFlagCopyWithImpl<$Res, FeatureFlag>;
  @useResult
  $Res call(
      {String key,
      bool enabled,
      String variant,
      @JsonKey(name: 'rollout') int rolloutPercentage,
      List<String> tags,
      String? description,
      Map<String, dynamic> payload,
      DateTime? updatedAt});
}

/// @nodoc
class _$FeatureFlagCopyWithImpl<$Res, $Val extends FeatureFlag>
    implements $FeatureFlagCopyWith<$Res> {
  _$FeatureFlagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeatureFlag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? enabled = null,
    Object? variant = null,
    Object? rolloutPercentage = null,
    Object? tags = null,
    Object? description = freezed,
    Object? payload = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      variant: null == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as String,
      rolloutPercentage: null == rolloutPercentage
          ? _value.rolloutPercentage
          : rolloutPercentage // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeatureFlagImplCopyWith<$Res>
    implements $FeatureFlagCopyWith<$Res> {
  factory _$$FeatureFlagImplCopyWith(
          _$FeatureFlagImpl value, $Res Function(_$FeatureFlagImpl) then) =
      __$$FeatureFlagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String key,
      bool enabled,
      String variant,
      @JsonKey(name: 'rollout') int rolloutPercentage,
      List<String> tags,
      String? description,
      Map<String, dynamic> payload,
      DateTime? updatedAt});
}

/// @nodoc
class __$$FeatureFlagImplCopyWithImpl<$Res>
    extends _$FeatureFlagCopyWithImpl<$Res, _$FeatureFlagImpl>
    implements _$$FeatureFlagImplCopyWith<$Res> {
  __$$FeatureFlagImplCopyWithImpl(
      _$FeatureFlagImpl _value, $Res Function(_$FeatureFlagImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeatureFlag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? enabled = null,
    Object? variant = null,
    Object? rolloutPercentage = null,
    Object? tags = null,
    Object? description = freezed,
    Object? payload = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$FeatureFlagImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      variant: null == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as String,
      rolloutPercentage: null == rolloutPercentage
          ? _value.rolloutPercentage
          : rolloutPercentage // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      payload: null == payload
          ? _value._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeatureFlagImpl implements _FeatureFlag {
  const _$FeatureFlagImpl(
      {required this.key,
      this.enabled = false,
      this.variant = 'control',
      @JsonKey(name: 'rollout') this.rolloutPercentage = 0,
      final List<String> tags = const <String>[],
      this.description,
      final Map<String, dynamic> payload = const <String, dynamic>{},
      this.updatedAt})
      : _tags = tags,
        _payload = payload;

  factory _$FeatureFlagImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeatureFlagImplFromJson(json);

  @override
  final String key;
  @override
  @JsonKey()
  final bool enabled;
  @override
  @JsonKey()
  final String variant;
  @override
  @JsonKey(name: 'rollout')
  final int rolloutPercentage;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String? description;
  final Map<String, dynamic> _payload;
  @override
  @JsonKey()
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'FeatureFlag(key: $key, enabled: $enabled, variant: $variant, rolloutPercentage: $rolloutPercentage, tags: $tags, description: $description, payload: $payload, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeatureFlagImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.rolloutPercentage, rolloutPercentage) ||
                other.rolloutPercentage == rolloutPercentage) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._payload, _payload) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      key,
      enabled,
      variant,
      rolloutPercentage,
      const DeepCollectionEquality().hash(_tags),
      description,
      const DeepCollectionEquality().hash(_payload),
      updatedAt);

  /// Create a copy of FeatureFlag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeatureFlagImplCopyWith<_$FeatureFlagImpl> get copyWith =>
      __$$FeatureFlagImplCopyWithImpl<_$FeatureFlagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeatureFlagImplToJson(
      this,
    );
  }
}

abstract class _FeatureFlag implements FeatureFlag {
  const factory _FeatureFlag(
      {required final String key,
      final bool enabled,
      final String variant,
      @JsonKey(name: 'rollout') final int rolloutPercentage,
      final List<String> tags,
      final String? description,
      final Map<String, dynamic> payload,
      final DateTime? updatedAt}) = _$FeatureFlagImpl;

  factory _FeatureFlag.fromJson(Map<String, dynamic> json) =
      _$FeatureFlagImpl.fromJson;

  @override
  String get key;
  @override
  bool get enabled;
  @override
  String get variant;
  @override
  @JsonKey(name: 'rollout')
  int get rolloutPercentage;
  @override
  List<String> get tags;
  @override
  String? get description;
  @override
  Map<String, dynamic> get payload;
  @override
  DateTime? get updatedAt;

  /// Create a copy of FeatureFlag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeatureFlagImplCopyWith<_$FeatureFlagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ThemeOverride _$ThemeOverrideFromJson(Map<String, dynamic> json) {
  return _ThemeOverride.fromJson(json);
}

/// @nodoc
mixin _$ThemeOverride {
  String get slug => throw _privateConstructorUsedError;
  ThemePalette get light => throw _privateConstructorUsedError;
  ThemePalette get dark => throw _privateConstructorUsedError;
  double? get cornerRadius => throw _privateConstructorUsedError;

  /// Serializes this ThemeOverride to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThemeOverride
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThemeOverrideCopyWith<ThemeOverride> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeOverrideCopyWith<$Res> {
  factory $ThemeOverrideCopyWith(
          ThemeOverride value, $Res Function(ThemeOverride) then) =
      _$ThemeOverrideCopyWithImpl<$Res, ThemeOverride>;
  @useResult
  $Res call(
      {String slug,
      ThemePalette light,
      ThemePalette dark,
      double? cornerRadius});

  $ThemePaletteCopyWith<$Res> get light;
  $ThemePaletteCopyWith<$Res> get dark;
}

/// @nodoc
class _$ThemeOverrideCopyWithImpl<$Res, $Val extends ThemeOverride>
    implements $ThemeOverrideCopyWith<$Res> {
  _$ThemeOverrideCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThemeOverride
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? light = null,
    Object? dark = null,
    Object? cornerRadius = freezed,
  }) {
    return _then(_value.copyWith(
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      light: null == light
          ? _value.light
          : light // ignore: cast_nullable_to_non_nullable
              as ThemePalette,
      dark: null == dark
          ? _value.dark
          : dark // ignore: cast_nullable_to_non_nullable
              as ThemePalette,
      cornerRadius: freezed == cornerRadius
          ? _value.cornerRadius
          : cornerRadius // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  /// Create a copy of ThemeOverride
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThemePaletteCopyWith<$Res> get light {
    return $ThemePaletteCopyWith<$Res>(_value.light, (value) {
      return _then(_value.copyWith(light: value) as $Val);
    });
  }

  /// Create a copy of ThemeOverride
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThemePaletteCopyWith<$Res> get dark {
    return $ThemePaletteCopyWith<$Res>(_value.dark, (value) {
      return _then(_value.copyWith(dark: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ThemeOverrideImplCopyWith<$Res>
    implements $ThemeOverrideCopyWith<$Res> {
  factory _$$ThemeOverrideImplCopyWith(
          _$ThemeOverrideImpl value, $Res Function(_$ThemeOverrideImpl) then) =
      __$$ThemeOverrideImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String slug,
      ThemePalette light,
      ThemePalette dark,
      double? cornerRadius});

  @override
  $ThemePaletteCopyWith<$Res> get light;
  @override
  $ThemePaletteCopyWith<$Res> get dark;
}

/// @nodoc
class __$$ThemeOverrideImplCopyWithImpl<$Res>
    extends _$ThemeOverrideCopyWithImpl<$Res, _$ThemeOverrideImpl>
    implements _$$ThemeOverrideImplCopyWith<$Res> {
  __$$ThemeOverrideImplCopyWithImpl(
      _$ThemeOverrideImpl _value, $Res Function(_$ThemeOverrideImpl) _then)
      : super(_value, _then);

  /// Create a copy of ThemeOverride
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? light = null,
    Object? dark = null,
    Object? cornerRadius = freezed,
  }) {
    return _then(_$ThemeOverrideImpl(
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      light: null == light
          ? _value.light
          : light // ignore: cast_nullable_to_non_nullable
              as ThemePalette,
      dark: null == dark
          ? _value.dark
          : dark // ignore: cast_nullable_to_non_nullable
              as ThemePalette,
      cornerRadius: freezed == cornerRadius
          ? _value.cornerRadius
          : cornerRadius // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThemeOverrideImpl implements _ThemeOverride {
  const _$ThemeOverrideImpl(
      {required this.slug,
      required this.light,
      required this.dark,
      this.cornerRadius});

  factory _$ThemeOverrideImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemeOverrideImplFromJson(json);

  @override
  final String slug;
  @override
  final ThemePalette light;
  @override
  final ThemePalette dark;
  @override
  final double? cornerRadius;

  @override
  String toString() {
    return 'ThemeOverride(slug: $slug, light: $light, dark: $dark, cornerRadius: $cornerRadius)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeOverrideImpl &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.light, light) || other.light == light) &&
            (identical(other.dark, dark) || other.dark == dark) &&
            (identical(other.cornerRadius, cornerRadius) ||
                other.cornerRadius == cornerRadius));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, slug, light, dark, cornerRadius);

  /// Create a copy of ThemeOverride
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemeOverrideImplCopyWith<_$ThemeOverrideImpl> get copyWith =>
      __$$ThemeOverrideImplCopyWithImpl<_$ThemeOverrideImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThemeOverrideImplToJson(
      this,
    );
  }
}

abstract class _ThemeOverride implements ThemeOverride {
  const factory _ThemeOverride(
      {required final String slug,
      required final ThemePalette light,
      required final ThemePalette dark,
      final double? cornerRadius}) = _$ThemeOverrideImpl;

  factory _ThemeOverride.fromJson(Map<String, dynamic> json) =
      _$ThemeOverrideImpl.fromJson;

  @override
  String get slug;
  @override
  ThemePalette get light;
  @override
  ThemePalette get dark;
  @override
  double? get cornerRadius;

  /// Create a copy of ThemeOverride
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThemeOverrideImplCopyWith<_$ThemeOverrideImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ThemePalette _$ThemePaletteFromJson(Map<String, dynamic> json) {
  return _ThemePalette.fromJson(json);
}

/// @nodoc
mixin _$ThemePalette {
  String? get primary => throw _privateConstructorUsedError;
  String? get surface => throw _privateConstructorUsedError;
  String? get background => throw _privateConstructorUsedError;
  String? get textPrimary => throw _privateConstructorUsedError;
  String? get textSecondary => throw _privateConstructorUsedError;
  String? get accent => throw _privateConstructorUsedError;
  String? get success => throw _privateConstructorUsedError;
  String? get warning => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this ThemePalette to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThemePalette
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThemePaletteCopyWith<ThemePalette> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemePaletteCopyWith<$Res> {
  factory $ThemePaletteCopyWith(
          ThemePalette value, $Res Function(ThemePalette) then) =
      _$ThemePaletteCopyWithImpl<$Res, ThemePalette>;
  @useResult
  $Res call(
      {String? primary,
      String? surface,
      String? background,
      String? textPrimary,
      String? textSecondary,
      String? accent,
      String? success,
      String? warning,
      String? error});
}

/// @nodoc
class _$ThemePaletteCopyWithImpl<$Res, $Val extends ThemePalette>
    implements $ThemePaletteCopyWith<$Res> {
  _$ThemePaletteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThemePalette
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = freezed,
    Object? surface = freezed,
    Object? background = freezed,
    Object? textPrimary = freezed,
    Object? textSecondary = freezed,
    Object? accent = freezed,
    Object? success = freezed,
    Object? warning = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      primary: freezed == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as String?,
      surface: freezed == surface
          ? _value.surface
          : surface // ignore: cast_nullable_to_non_nullable
              as String?,
      background: freezed == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as String?,
      textPrimary: freezed == textPrimary
          ? _value.textPrimary
          : textPrimary // ignore: cast_nullable_to_non_nullable
              as String?,
      textSecondary: freezed == textSecondary
          ? _value.textSecondary
          : textSecondary // ignore: cast_nullable_to_non_nullable
              as String?,
      accent: freezed == accent
          ? _value.accent
          : accent // ignore: cast_nullable_to_non_nullable
              as String?,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as String?,
      warning: freezed == warning
          ? _value.warning
          : warning // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ThemePaletteImplCopyWith<$Res>
    implements $ThemePaletteCopyWith<$Res> {
  factory _$$ThemePaletteImplCopyWith(
          _$ThemePaletteImpl value, $Res Function(_$ThemePaletteImpl) then) =
      __$$ThemePaletteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? primary,
      String? surface,
      String? background,
      String? textPrimary,
      String? textSecondary,
      String? accent,
      String? success,
      String? warning,
      String? error});
}

/// @nodoc
class __$$ThemePaletteImplCopyWithImpl<$Res>
    extends _$ThemePaletteCopyWithImpl<$Res, _$ThemePaletteImpl>
    implements _$$ThemePaletteImplCopyWith<$Res> {
  __$$ThemePaletteImplCopyWithImpl(
      _$ThemePaletteImpl _value, $Res Function(_$ThemePaletteImpl) _then)
      : super(_value, _then);

  /// Create a copy of ThemePalette
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = freezed,
    Object? surface = freezed,
    Object? background = freezed,
    Object? textPrimary = freezed,
    Object? textSecondary = freezed,
    Object? accent = freezed,
    Object? success = freezed,
    Object? warning = freezed,
    Object? error = freezed,
  }) {
    return _then(_$ThemePaletteImpl(
      primary: freezed == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as String?,
      surface: freezed == surface
          ? _value.surface
          : surface // ignore: cast_nullable_to_non_nullable
              as String?,
      background: freezed == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as String?,
      textPrimary: freezed == textPrimary
          ? _value.textPrimary
          : textPrimary // ignore: cast_nullable_to_non_nullable
              as String?,
      textSecondary: freezed == textSecondary
          ? _value.textSecondary
          : textSecondary // ignore: cast_nullable_to_non_nullable
              as String?,
      accent: freezed == accent
          ? _value.accent
          : accent // ignore: cast_nullable_to_non_nullable
              as String?,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as String?,
      warning: freezed == warning
          ? _value.warning
          : warning // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThemePaletteImpl implements _ThemePalette {
  const _$ThemePaletteImpl(
      {this.primary,
      this.surface,
      this.background,
      this.textPrimary,
      this.textSecondary,
      this.accent,
      this.success,
      this.warning,
      this.error});

  factory _$ThemePaletteImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemePaletteImplFromJson(json);

  @override
  final String? primary;
  @override
  final String? surface;
  @override
  final String? background;
  @override
  final String? textPrimary;
  @override
  final String? textSecondary;
  @override
  final String? accent;
  @override
  final String? success;
  @override
  final String? warning;
  @override
  final String? error;

  @override
  String toString() {
    return 'ThemePalette(primary: $primary, surface: $surface, background: $background, textPrimary: $textPrimary, textSecondary: $textSecondary, accent: $accent, success: $success, warning: $warning, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemePaletteImpl &&
            (identical(other.primary, primary) || other.primary == primary) &&
            (identical(other.surface, surface) || other.surface == surface) &&
            (identical(other.background, background) ||
                other.background == background) &&
            (identical(other.textPrimary, textPrimary) ||
                other.textPrimary == textPrimary) &&
            (identical(other.textSecondary, textSecondary) ||
                other.textSecondary == textSecondary) &&
            (identical(other.accent, accent) || other.accent == accent) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.warning, warning) || other.warning == warning) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, primary, surface, background,
      textPrimary, textSecondary, accent, success, warning, error);

  /// Create a copy of ThemePalette
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemePaletteImplCopyWith<_$ThemePaletteImpl> get copyWith =>
      __$$ThemePaletteImplCopyWithImpl<_$ThemePaletteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThemePaletteImplToJson(
      this,
    );
  }
}

abstract class _ThemePalette implements ThemePalette {
  const factory _ThemePalette(
      {final String? primary,
      final String? surface,
      final String? background,
      final String? textPrimary,
      final String? textSecondary,
      final String? accent,
      final String? success,
      final String? warning,
      final String? error}) = _$ThemePaletteImpl;

  factory _ThemePalette.fromJson(Map<String, dynamic> json) =
      _$ThemePaletteImpl.fromJson;

  @override
  String? get primary;
  @override
  String? get surface;
  @override
  String? get background;
  @override
  String? get textPrimary;
  @override
  String? get textSecondary;
  @override
  String? get accent;
  @override
  String? get success;
  @override
  String? get warning;
  @override
  String? get error;

  /// Create a copy of ThemePalette
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThemePaletteImplCopyWith<_$ThemePaletteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
