import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact.freezed.dart';

enum ContactLinkType { journey, settlement }

@freezed
class Contact with _$Contact {
  const factory Contact({
    required String id,
    required String displayName,
    String? email,
    String? phone,
    String? avatarUrl,
    @Default(<String>[]) List<String> tags,
    @Default(<ContactLink>[]) List<ContactLink> links,
    DateTime? createdAt,
  }) = _Contact;
}

@freezed
class ContactLink with _$ContactLink {
  const factory ContactLink({
    required String resourceId,
    required ContactLinkType type,
    String? label,
  }) = _ContactLink;
}
