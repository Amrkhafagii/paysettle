import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/contacts_repository_impl.dart';
import '../value_objects/contact_sort.dart';
import 'delete_contact.dart';
import 'get_contacts.dart';
import 'upsert_contact.dart';

final contactQueryProvider = StateProvider<String>((ref) => '');
final contactSortProvider = StateProvider<ContactSort>((ref) => ContactSort.alphabetical);

final getContactsUseCaseProvider = Provider<GetContactsUseCase>((ref) {
  return GetContactsUseCase(ref.watch(contactsRepositoryProvider));
});

final upsertContactUseCaseProvider = Provider<UpsertContactUseCase>((ref) {
  return UpsertContactUseCase(ref.watch(contactsRepositoryProvider));
});

final deleteContactUseCaseProvider = Provider<DeleteContactUseCase>((ref) {
  return DeleteContactUseCase(ref.watch(contactsRepositoryProvider));
});
