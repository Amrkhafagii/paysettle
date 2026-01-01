import '../entities/contact.dart';
import '../repositories/contacts_repository.dart';

class UpsertContactUseCase {
  const UpsertContactUseCase(this._repository);

  final ContactsRepository _repository;

  Future<Contact> call(Contact contact) {
    return _repository.saveContact(contact);
  }
}
