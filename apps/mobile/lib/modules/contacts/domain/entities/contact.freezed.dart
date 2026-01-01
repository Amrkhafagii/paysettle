// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Contact {
  String get id => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  List<ContactLink> get links => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactCopyWith<Contact> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactCopyWith<$Res> {
  factory $ContactCopyWith(Contact value, $Res Function(Contact) then) =
      _$ContactCopyWithImpl<$Res, Contact>;
  @useResult
  $Res call(
      {String id,
      String displayName,
      String? email,
      String? phone,
      String? avatarUrl,
      List<String> tags,
      List<ContactLink> links,
      DateTime? createdAt});
}

/// @nodoc
class _$ContactCopyWithImpl<$Res, $Val extends Contact>
    implements $ContactCopyWith<$Res> {
  _$ContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? avatarUrl = freezed,
    Object? tags = null,
    Object? links = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      links: null == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as List<ContactLink>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactImplCopyWith<$Res> implements $ContactCopyWith<$Res> {
  factory _$$ContactImplCopyWith(
          _$ContactImpl value, $Res Function(_$ContactImpl) then) =
      __$$ContactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String displayName,
      String? email,
      String? phone,
      String? avatarUrl,
      List<String> tags,
      List<ContactLink> links,
      DateTime? createdAt});
}

/// @nodoc
class __$$ContactImplCopyWithImpl<$Res>
    extends _$ContactCopyWithImpl<$Res, _$ContactImpl>
    implements _$$ContactImplCopyWith<$Res> {
  __$$ContactImplCopyWithImpl(
      _$ContactImpl _value, $Res Function(_$ContactImpl) _then)
      : super(_value, _then);

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? avatarUrl = freezed,
    Object? tags = null,
    Object? links = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$ContactImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      links: null == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<ContactLink>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$ContactImpl implements _Contact {
  const _$ContactImpl(
      {required this.id,
      required this.displayName,
      this.email,
      this.phone,
      this.avatarUrl,
      final List<String> tags = const <String>[],
      final List<ContactLink> links = const <ContactLink>[],
      this.createdAt})
      : _tags = tags,
        _links = links;

  @override
  final String id;
  @override
  final String displayName;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? avatarUrl;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<ContactLink> _links;
  @override
  @JsonKey()
  List<ContactLink> get links {
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_links);
  }

  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Contact(id: $id, displayName: $displayName, email: $email, phone: $phone, avatarUrl: $avatarUrl, tags: $tags, links: $links, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      displayName,
      email,
      phone,
      avatarUrl,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_links),
      createdAt);

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactImplCopyWith<_$ContactImpl> get copyWith =>
      __$$ContactImplCopyWithImpl<_$ContactImpl>(this, _$identity);
}

abstract class _Contact implements Contact {
  const factory _Contact(
      {required final String id,
      required final String displayName,
      final String? email,
      final String? phone,
      final String? avatarUrl,
      final List<String> tags,
      final List<ContactLink> links,
      final DateTime? createdAt}) = _$ContactImpl;

  @override
  String get id;
  @override
  String get displayName;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get avatarUrl;
  @override
  List<String> get tags;
  @override
  List<ContactLink> get links;
  @override
  DateTime? get createdAt;

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactImplCopyWith<_$ContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ContactLink {
  String get resourceId => throw _privateConstructorUsedError;
  ContactLinkType get type => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;

  /// Create a copy of ContactLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactLinkCopyWith<ContactLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactLinkCopyWith<$Res> {
  factory $ContactLinkCopyWith(
          ContactLink value, $Res Function(ContactLink) then) =
      _$ContactLinkCopyWithImpl<$Res, ContactLink>;
  @useResult
  $Res call({String resourceId, ContactLinkType type, String? label});
}

/// @nodoc
class _$ContactLinkCopyWithImpl<$Res, $Val extends ContactLink>
    implements $ContactLinkCopyWith<$Res> {
  _$ContactLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resourceId = null,
    Object? type = null,
    Object? label = freezed,
  }) {
    return _then(_value.copyWith(
      resourceId: null == resourceId
          ? _value.resourceId
          : resourceId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContactLinkType,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactLinkImplCopyWith<$Res>
    implements $ContactLinkCopyWith<$Res> {
  factory _$$ContactLinkImplCopyWith(
          _$ContactLinkImpl value, $Res Function(_$ContactLinkImpl) then) =
      __$$ContactLinkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String resourceId, ContactLinkType type, String? label});
}

/// @nodoc
class __$$ContactLinkImplCopyWithImpl<$Res>
    extends _$ContactLinkCopyWithImpl<$Res, _$ContactLinkImpl>
    implements _$$ContactLinkImplCopyWith<$Res> {
  __$$ContactLinkImplCopyWithImpl(
      _$ContactLinkImpl _value, $Res Function(_$ContactLinkImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContactLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resourceId = null,
    Object? type = null,
    Object? label = freezed,
  }) {
    return _then(_$ContactLinkImpl(
      resourceId: null == resourceId
          ? _value.resourceId
          : resourceId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContactLinkType,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ContactLinkImpl implements _ContactLink {
  const _$ContactLinkImpl(
      {required this.resourceId, required this.type, this.label});

  @override
  final String resourceId;
  @override
  final ContactLinkType type;
  @override
  final String? label;

  @override
  String toString() {
    return 'ContactLink(resourceId: $resourceId, type: $type, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactLinkImpl &&
            (identical(other.resourceId, resourceId) ||
                other.resourceId == resourceId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.label, label) || other.label == label));
  }

  @override
  int get hashCode => Object.hash(runtimeType, resourceId, type, label);

  /// Create a copy of ContactLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactLinkImplCopyWith<_$ContactLinkImpl> get copyWith =>
      __$$ContactLinkImplCopyWithImpl<_$ContactLinkImpl>(this, _$identity);
}

abstract class _ContactLink implements ContactLink {
  const factory _ContactLink(
      {required final String resourceId,
      required final ContactLinkType type,
      final String? label}) = _$ContactLinkImpl;

  @override
  String get resourceId;
  @override
  ContactLinkType get type;
  @override
  String? get label;

  /// Create a copy of ContactLink
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactLinkImplCopyWith<_$ContactLinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
