import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postgrest/postgrest.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../src/core/network/supabase_client_provider.dart';
import '../../domain/value_objects/contact_sort.dart';
import '../dtos/contact_dto.dart';

class ContactsRemoteDataSource {
  ContactsRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<List<ContactDto>> fetchContacts({
    required String query,
    required ContactSort sort,
  }) async {
    try {
      var request = _client
          .from('wallet_contacts')
          .select(
            'id,display_name,email,phone,avatar_url,tags,created_at,wallet_contact_links(resource_type,resource_id,label)',
          );
      if (query.trim().isNotEmpty) {
        request = request.ilike('search_name', '%${query.toLowerCase()}%');
      }

      final ordered = switch (sort) {
        ContactSort.alphabetical =>
            request.order('search_name', ascending: true),
        ContactSort.recent => request.order('created_at', ascending: false),
      };

      final response = await ordered.limit(100);
      return response
          .whereType<Map<String, dynamic>>()
          .map(ContactDto.fromMap)
          .toList(growable: false);
    } on PostgrestException {
      rethrow;
    }
  }

  Future<ContactDto> upsertContact(ContactDto contact) async {
    try {
      final payload = {
        if (contact.id.isNotEmpty) 'id': contact.id,
        'display_name': contact.displayName,
        'email': contact.email,
        'phone': contact.phone,
        'avatar_url': contact.avatarUrl,
        'tags': contact.tags,
      };
      final response = await _client
          .from('wallet_contacts')
          .upsert(payload)
          .select()
          .maybeSingle();
      if (response == null) {
        return contact;
      }
      return ContactDto.fromMap(response);
    } on PostgrestException {
      rethrow;
    }
  }

  Future<void> deleteContact(String contactId) async {
    try {
      await _client.from('wallet_contacts').delete().eq('id', contactId);
    } on PostgrestException {
      rethrow;
    }
  }
}

final contactsRemoteDataSourceProvider = Provider<ContactsRemoteDataSource>((ref) {
  return ContactsRemoteDataSource(ref.watch(supabaseClientProvider));
});
