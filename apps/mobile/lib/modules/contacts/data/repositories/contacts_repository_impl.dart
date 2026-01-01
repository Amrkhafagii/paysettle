import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/core/cache/cache_box.dart';
import '../../../../src/core/cache/cache_service.dart';
import '../../domain/entities/contact.dart';
import '../../domain/repositories/contacts_repository.dart';
import '../../domain/value_objects/contact_sort.dart';
import '../datasources/contacts_remote_data_source.dart';
import '../dtos/contact_dto.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  ContactsRepositoryImpl({
    required ContactsRemoteDataSource remoteDataSource,
    required CacheService cacheService,
  })  : _remoteDataSource = remoteDataSource,
        _cacheService = cacheService;

  final ContactsRemoteDataSource _remoteDataSource;
  final CacheService _cacheService;

  static const _cacheKey = 'wallet_contacts_cache_v1';

  @override
  Future<List<Contact>> fetchContacts({
    String query = '',
    ContactSort sort = ContactSort.alphabetical,
    int offset = 0,
    int limit = 25,
  }) async {
    try {
      final dtos = await _remoteDataSource.fetchContacts(
        query: query,
        sort: sort,
        offset: offset,
        limit: limit,
      );
      if (query.isEmpty && offset == 0) {
        await _cacheService.write(
          CacheBox.core,
          _cacheKey,
          dtos.map((dto) => dto.toJson()).toList(growable: false),
        );
      }
      if (dtos.isNotEmpty) {
        return dtos.map((dto) => dto.toDomain()).toList(growable: false);
      }
    } catch (_) {
      final cached =
          _cacheService.read<List<dynamic>>(CacheBox.core, _cacheKey);
      if (cached != null && query.isEmpty && offset == 0) {
        return cached
            .whereType<Map>()
            .map((entry) => ContactDto.fromMap(
                entry.map((key, value) => MapEntry(key.toString(), value))))
            .map((dto) => dto.toDomain())
            .toList(growable: false);
      }
    }
    final filtered = _demoContacts
        .where((contact) => query.isEmpty
            ? true
            : contact.displayName.toLowerCase().contains(query.toLowerCase()))
        .toList(growable: false);
    return filtered
        .skip(offset)
        .take(limit)
        .toList(growable: false);
  }

  @override
  Future<Contact> saveContact(Contact contact) async {
    final dto = ContactDto(
      id: contact.id,
      displayName: contact.displayName,
      email: contact.email,
      phone: contact.phone,
      avatarUrl: contact.avatarUrl,
      tags: contact.tags,
      links: contact.links,
      createdAt: contact.createdAt,
    );
    try {
      final updated = await _remoteDataSource.upsertContact(dto);
      await _invalidateCache();
      return updated.toDomain();
    } catch (_) {
      return contact;
    }
  }

  @override
  Future<void> deleteContact(String contactId) async {
    try {
      await _remoteDataSource.deleteContact(contactId);
      await _invalidateCache();
    } catch (_) {
      // ignore offline deletes; cache will refresh next fetch
    }
  }

  Future<void> _invalidateCache() async {
    await _cacheService.delete(CacheBox.core, _cacheKey);
  }

  List<Contact> get _demoContacts => const [
        Contact(
          id: 'demo_1',
          displayName: 'Abdallah Raof',
        ),
        Contact(
          id: 'demo_2',
          displayName: 'Amir Hussein',
        ),
        Contact(
          id: 'demo_3',
          displayName: 'Mazen Ramy Farouk',
        ),
        Contact(
          id: 'demo_4',
          displayName: 'Ahmed Hamada',
        ),
        Contact(
          id: 'demo_5',
          displayName: 'Tamer Samir',
        ),
      ];
}

final contactsRepositoryProvider = Provider<ContactsRepository>((ref) {
  return ContactsRepositoryImpl(
    remoteDataSource: ref.watch(contactsRemoteDataSourceProvider),
    cacheService: ref.watch(
      cacheServiceProvider,
    ),
  );
});
