import '../entities/contact.dart';
import '../repositories/contacts_repository.dart';
import '../value_objects/contact_sort.dart';

class GetContactsUseCase {
  const GetContactsUseCase(this._repository);

  final ContactsRepository _repository;

  Future<List<Contact>> call({String query = '', ContactSort sort = ContactSort.alphabetical}) {
    return _repository.fetchContacts(query: query, sort: sort);
  }
}
