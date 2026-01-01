// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppNotification {
  String get id => throw _privateConstructorUsedError;
  AppNotificationType get type => throw _privateConstructorUsedError;
  NotificationSeverity get severity => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;
  String? get topic => throw _privateConstructorUsedError;
  String? get actionLabel => throw _privateConstructorUsedError;
  String? get actionUrl => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  Map<String, dynamic>? get payload => throw _privateConstructorUsedError;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppNotificationCopyWith<AppNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppNotificationCopyWith<$Res> {
  factory $AppNotificationCopyWith(
          AppNotification value, $Res Function(AppNotification) then) =
      _$AppNotificationCopyWithImpl<$Res, AppNotification>;
  @useResult
  $Res call(
      {String id,
      AppNotificationType type,
      NotificationSeverity severity,
      String title,
      String body,
      DateTime createdAt,
      DateTime? readAt,
      String? topic,
      String? actionLabel,
      String? actionUrl,
      Map<String, dynamic>? metadata,
      Map<String, dynamic>? payload});
}

/// @nodoc
class _$AppNotificationCopyWithImpl<$Res, $Val extends AppNotification>
    implements $AppNotificationCopyWith<$Res> {
  _$AppNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? severity = null,
    Object? title = null,
    Object? body = null,
    Object? createdAt = null,
    Object? readAt = freezed,
    Object? topic = freezed,
    Object? actionLabel = freezed,
    Object? actionUrl = freezed,
    Object? metadata = freezed,
    Object? payload = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AppNotificationType,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as NotificationSeverity,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      topic: freezed == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String?,
      actionLabel: freezed == actionLabel
          ? _value.actionLabel
          : actionLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      actionUrl: freezed == actionUrl
          ? _value.actionUrl
          : actionUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      payload: freezed == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppNotificationImplCopyWith<$Res>
    implements $AppNotificationCopyWith<$Res> {
  factory _$$AppNotificationImplCopyWith(_$AppNotificationImpl value,
          $Res Function(_$AppNotificationImpl) then) =
      __$$AppNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      AppNotificationType type,
      NotificationSeverity severity,
      String title,
      String body,
      DateTime createdAt,
      DateTime? readAt,
      String? topic,
      String? actionLabel,
      String? actionUrl,
      Map<String, dynamic>? metadata,
      Map<String, dynamic>? payload});
}

/// @nodoc
class __$$AppNotificationImplCopyWithImpl<$Res>
    extends _$AppNotificationCopyWithImpl<$Res, _$AppNotificationImpl>
    implements _$$AppNotificationImplCopyWith<$Res> {
  __$$AppNotificationImplCopyWithImpl(
      _$AppNotificationImpl _value, $Res Function(_$AppNotificationImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? severity = null,
    Object? title = null,
    Object? body = null,
    Object? createdAt = null,
    Object? readAt = freezed,
    Object? topic = freezed,
    Object? actionLabel = freezed,
    Object? actionUrl = freezed,
    Object? metadata = freezed,
    Object? payload = freezed,
  }) {
    return _then(_$AppNotificationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AppNotificationType,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as NotificationSeverity,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      topic: freezed == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String?,
      actionLabel: freezed == actionLabel
          ? _value.actionLabel
          : actionLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      actionUrl: freezed == actionUrl
          ? _value.actionUrl
          : actionUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      payload: freezed == payload
          ? _value._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$AppNotificationImpl implements _AppNotification {
  const _$AppNotificationImpl(
      {required this.id,
      required this.type,
      required this.severity,
      required this.title,
      required this.body,
      required this.createdAt,
      this.readAt,
      this.topic,
      this.actionLabel,
      this.actionUrl,
      final Map<String, dynamic>? metadata,
      final Map<String, dynamic>? payload})
      : _metadata = metadata,
        _payload = payload;

  @override
  final String id;
  @override
  final AppNotificationType type;
  @override
  final NotificationSeverity severity;
  @override
  final String title;
  @override
  final String body;
  @override
  final DateTime createdAt;
  @override
  final DateTime? readAt;
  @override
  final String? topic;
  @override
  final String? actionLabel;
  @override
  final String? actionUrl;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _payload;
  @override
  Map<String, dynamic>? get payload {
    final value = _payload;
    if (value == null) return null;
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AppNotification(id: $id, type: $type, severity: $severity, title: $title, body: $body, createdAt: $createdAt, readAt: $readAt, topic: $topic, actionLabel: $actionLabel, actionUrl: $actionUrl, metadata: $metadata, payload: $payload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.actionLabel, actionLabel) ||
                other.actionLabel == actionLabel) &&
            (identical(other.actionUrl, actionUrl) ||
                other.actionUrl == actionUrl) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            const DeepCollectionEquality().equals(other._payload, _payload));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      severity,
      title,
      body,
      createdAt,
      readAt,
      topic,
      actionLabel,
      actionUrl,
      const DeepCollectionEquality().hash(_metadata),
      const DeepCollectionEquality().hash(_payload));

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppNotificationImplCopyWith<_$AppNotificationImpl> get copyWith =>
      __$$AppNotificationImplCopyWithImpl<_$AppNotificationImpl>(
          this, _$identity);
}

abstract class _AppNotification implements AppNotification {
  const factory _AppNotification(
      {required final String id,
      required final AppNotificationType type,
      required final NotificationSeverity severity,
      required final String title,
      required final String body,
      required final DateTime createdAt,
      final DateTime? readAt,
      final String? topic,
      final String? actionLabel,
      final String? actionUrl,
      final Map<String, dynamic>? metadata,
      final Map<String, dynamic>? payload}) = _$AppNotificationImpl;

  @override
  String get id;
  @override
  AppNotificationType get type;
  @override
  NotificationSeverity get severity;
  @override
  String get title;
  @override
  String get body;
  @override
  DateTime get createdAt;
  @override
  DateTime? get readAt;
  @override
  String? get topic;
  @override
  String? get actionLabel;
  @override
  String? get actionUrl;
  @override
  Map<String, dynamic>? get metadata;
  @override
  Map<String, dynamic>? get payload;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppNotificationImplCopyWith<_$AppNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NotificationFeed {
  List<AppNotification> get newItems => throw _privateConstructorUsedError;
  List<AppNotification> get earlierItems => throw _privateConstructorUsedError;

  /// Create a copy of NotificationFeed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationFeedCopyWith<NotificationFeed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationFeedCopyWith<$Res> {
  factory $NotificationFeedCopyWith(
          NotificationFeed value, $Res Function(NotificationFeed) then) =
      _$NotificationFeedCopyWithImpl<$Res, NotificationFeed>;
  @useResult
  $Res call(
      {List<AppNotification> newItems, List<AppNotification> earlierItems});
}

/// @nodoc
class _$NotificationFeedCopyWithImpl<$Res, $Val extends NotificationFeed>
    implements $NotificationFeedCopyWith<$Res> {
  _$NotificationFeedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationFeed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newItems = null,
    Object? earlierItems = null,
  }) {
    return _then(_value.copyWith(
      newItems: null == newItems
          ? _value.newItems
          : newItems // ignore: cast_nullable_to_non_nullable
              as List<AppNotification>,
      earlierItems: null == earlierItems
          ? _value.earlierItems
          : earlierItems // ignore: cast_nullable_to_non_nullable
              as List<AppNotification>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationFeedImplCopyWith<$Res>
    implements $NotificationFeedCopyWith<$Res> {
  factory _$$NotificationFeedImplCopyWith(_$NotificationFeedImpl value,
          $Res Function(_$NotificationFeedImpl) then) =
      __$$NotificationFeedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<AppNotification> newItems, List<AppNotification> earlierItems});
}

/// @nodoc
class __$$NotificationFeedImplCopyWithImpl<$Res>
    extends _$NotificationFeedCopyWithImpl<$Res, _$NotificationFeedImpl>
    implements _$$NotificationFeedImplCopyWith<$Res> {
  __$$NotificationFeedImplCopyWithImpl(_$NotificationFeedImpl _value,
      $Res Function(_$NotificationFeedImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationFeed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newItems = null,
    Object? earlierItems = null,
  }) {
    return _then(_$NotificationFeedImpl(
      newItems: null == newItems
          ? _value._newItems
          : newItems // ignore: cast_nullable_to_non_nullable
              as List<AppNotification>,
      earlierItems: null == earlierItems
          ? _value._earlierItems
          : earlierItems // ignore: cast_nullable_to_non_nullable
              as List<AppNotification>,
    ));
  }
}

/// @nodoc

class _$NotificationFeedImpl extends _NotificationFeed {
  const _$NotificationFeedImpl(
      {required final List<AppNotification> newItems,
      required final List<AppNotification> earlierItems})
      : _newItems = newItems,
        _earlierItems = earlierItems,
        super._();

  final List<AppNotification> _newItems;
  @override
  List<AppNotification> get newItems {
    if (_newItems is EqualUnmodifiableListView) return _newItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newItems);
  }

  final List<AppNotification> _earlierItems;
  @override
  List<AppNotification> get earlierItems {
    if (_earlierItems is EqualUnmodifiableListView) return _earlierItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_earlierItems);
  }

  @override
  String toString() {
    return 'NotificationFeed(newItems: $newItems, earlierItems: $earlierItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationFeedImpl &&
            const DeepCollectionEquality().equals(other._newItems, _newItems) &&
            const DeepCollectionEquality()
                .equals(other._earlierItems, _earlierItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_newItems),
      const DeepCollectionEquality().hash(_earlierItems));

  /// Create a copy of NotificationFeed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationFeedImplCopyWith<_$NotificationFeedImpl> get copyWith =>
      __$$NotificationFeedImplCopyWithImpl<_$NotificationFeedImpl>(
          this, _$identity);
}

abstract class _NotificationFeed extends NotificationFeed {
  const factory _NotificationFeed(
          {required final List<AppNotification> newItems,
          required final List<AppNotification> earlierItems}) =
      _$NotificationFeedImpl;
  const _NotificationFeed._() : super._();

  @override
  List<AppNotification> get newItems;
  @override
  List<AppNotification> get earlierItems;

  /// Create a copy of NotificationFeed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationFeedImplCopyWith<_$NotificationFeedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
