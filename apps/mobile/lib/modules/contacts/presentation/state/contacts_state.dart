import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/contact.dart';
import '../../domain/value_objects/contact_sort.dart';

class ContactsState {
  const ContactsState({
    required this.contacts,
    required this.query,
    required this.sort,
  });

  factory ContactsState.initial() => const ContactsState(
        contacts: AsyncValue.loading(),
        query: '',
        sort: ContactSort.alphabetical,
      );

  final AsyncValue<List<Contact>> contacts;
  final String query;
  final ContactSort sort;

  ContactsState copyWith({
    AsyncValue<List<Contact>>? contacts,
    String? query,
    ContactSort? sort,
  }) {
    return ContactsState(
      contacts: contacts ?? this.contacts,
      query: query ?? this.query,
      sort: sort ?? this.sort,
    );
  }
}
