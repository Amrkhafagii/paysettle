import '../repositories/contacts_repository.dart';

class DeleteContactUseCase {
  const DeleteContactUseCase(this._repository);

  final ContactsRepository _repository;

  Future<void> call(String contactId) {
    return _repository.deleteContact(contactId);
  }
}
