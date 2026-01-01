import '../../domain/entities/contact.dart';

class ContactDto {
  ContactDto({
    required this.id,
    required this.displayName,
    this.email,
    this.phone,
    this.avatarUrl,
    required this.tags,
    required this.links,
    this.createdAt,
  });

  factory ContactDto.fromMap(Map<String, dynamic> map) {
    return ContactDto(
      id: '${map['id']}',
      displayName: '${map['display_name'] ?? map['displayName'] ?? ''}',
      email: map['email']?.toString(),
      phone: map['phone']?.toString(),
      avatarUrl: map['avatar_url']?.toString(),
      tags: (map['tags'] as List?)?.map((tag) => tag.toString()).toList(growable: false) ?? const [],
      links: _parseLinks(map['wallet_contact_links'] ?? map['links']),
      createdAt: map['created_at'] == null
          ? null
          : DateTime.tryParse(map['created_at'].toString()),
    );
  }

  final String id;
  final String displayName;
  final String? email;
  final String? phone;
  final String? avatarUrl;
  final List<String> tags;
  final List<ContactLink> links;
  final DateTime? createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'display_name': displayName,
      'email': email,
      'phone': phone,
      'avatar_url': avatarUrl,
      'tags': tags,
      'links': links
          .map((link) => {
                'resource_id': link.resourceId,
                'resource_type': link.type.name,
                'label': link.label,
              })
          .toList(growable: false),
      'created_at': createdAt?.toIso8601String(),
    };
  }

  Contact toDomain() {
    return Contact(
      id: id,
      displayName: displayName,
      email: email,
      phone: phone,
      avatarUrl: avatarUrl,
      tags: tags,
      links: links,
      createdAt: createdAt,
    );
  }

  static List<ContactLink> _parseLinks(dynamic raw) {
    if (raw is! List) {
      return const [];
    }
    return raw
        .whereType<Map>()
        .map((entry) => ContactLink(
              resourceId: '${entry['resource_id'] ?? entry['resourceId'] ?? ''}',
              type: _parseLinkType(entry['resource_type'] ?? entry['type']),
              label: entry['label']?.toString(),
            ))
        .toList(growable: false);
  }

  static ContactLinkType _parseLinkType(dynamic raw) {
    final value = '${raw ?? ''}'.toLowerCase();
    switch (value) {
      case 'settlement':
        return ContactLinkType.settlement;
      case 'journey':
      default:
        return ContactLinkType.journey;
    }
  }
}
