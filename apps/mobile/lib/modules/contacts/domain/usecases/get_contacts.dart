import '../entities/contact.dart';
import '../repositories/contacts_repository.dart';
import '../value_objects/contact_sort.dart';

class GetContactsUseCase {
  const GetContactsUseCase(this._repository);

  final ContactsRepository _repository;

  Future<List<Contact>> call({
    String query = '',
    ContactSort sort = ContactSort.alphabetical,
    int offset = 0,
    int limit = 25,
  }) {
    return _repository.fetchContacts(
      query: query,
      sort: sort,
      offset: offset,
      limit: limit,
    );
  }
}
