import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/contact.dart';
import '../../domain/usecases/delete_contact.dart';
import '../../domain/usecases/get_contacts.dart';
import '../../domain/usecases/upsert_contact.dart';
import '../../domain/usecases/usecase_providers.dart';
import '../../domain/value_objects/contact_sort.dart';
import '../state/contacts_state.dart';

class ContactsController extends StateNotifier<ContactsState> {
  ContactsController({
    required GetContactsUseCase getContacts,
    required UpsertContactUseCase upsertContact,
    required DeleteContactUseCase deleteContact,
  })  : _getContacts = getContacts,
        _upsertContact = upsertContact,
        _deleteContact = deleteContact,
        super(ContactsState.initial()) {
    load();
  }

  final GetContactsUseCase _getContacts;
  final UpsertContactUseCase _upsertContact;
  final DeleteContactUseCase _deleteContact;

  Future<void> load() async {
    state = state.copyWith(
      contacts: const AsyncValue.loading(),
      hasMore: true,
      isLoadingMore: false,
    );
    final result = await AsyncValue.guard(
      () => _getContacts(
        query: state.query,
        sort: state.sort,
        offset: 0,
        limit: state.pageSize,
      ),
    );
    if (result.hasError) {
      state = state.copyWith(contacts: result, hasMore: false);
      return;
    }
    final data = result.value ?? const [];
    state = state.copyWith(
      contacts: AsyncValue.data(data),
      hasMore: data.length == state.pageSize,
    );
  }

  void updateQuery(String query) {
    state = state.copyWith(query: query);
    load();
  }

  void updateSort(ContactSort sort) {
    state = state.copyWith(sort: sort);
    load();
  }

  Future<void> saveContact(Contact contact) async {
    await _upsertContact(contact);
    await load();
  }

  Future<void> deleteContact(String contactId) async {
    await _deleteContact(contactId);
    await load();
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) {
      return;
    }
    final current = state.contacts.valueOrNull ?? const <Contact>[];
    state = state.copyWith(isLoadingMore: true);
    try {
      final next = await _getContacts(
        query: state.query,
        sort: state.sort,
        offset: current.length,
        limit: state.pageSize,
      );
      final combined = List<Contact>.from(current)..addAll(next);
      state = state.copyWith(
        contacts: AsyncValue.data(combined),
        hasMore: next.length == state.pageSize,
        isLoadingMore: false,
      );
    } catch (_) {
      state = state.copyWith(
        contacts: AsyncValue.data(current),
        isLoadingMore: false,
      );
    }
  }
}

final contactsControllerProvider =
    StateNotifierProvider<ContactsController, ContactsState>((ref) {
  return ContactsController(
    getContacts: ref.watch(getContactsUseCaseProvider),
    upsertContact: ref.watch(upsertContactUseCaseProvider),
    deleteContact: ref.watch(deleteContactUseCaseProvider),
  );
});
