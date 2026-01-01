import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/contact.dart';
import '../../domain/value_objects/contact_sort.dart';

class ContactsState {
  const ContactsState({
    required this.contacts,
    required this.query,
    required this.sort,
    required this.hasMore,
    required this.isLoadingMore,
    required this.pageSize,
  });

  factory ContactsState.initial() => const ContactsState(
        contacts: AsyncValue.loading(),
        query: '',
        sort: ContactSort.alphabetical,
        hasMore: true,
        isLoadingMore: false,
        pageSize: 25,
      );

  final AsyncValue<List<Contact>> contacts;
  final String query;
  final ContactSort sort;
  final bool hasMore;
  final bool isLoadingMore;
  final int pageSize;

  ContactsState copyWith({
    AsyncValue<List<Contact>>? contacts,
    String? query,
    ContactSort? sort,
    bool? hasMore,
    bool? isLoadingMore,
    int? pageSize,
  }) {
    return ContactsState(
      contacts: contacts ?? this.contacts,
      query: query ?? this.query,
      sort: sort ?? this.sort,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
