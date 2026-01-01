import '../entities/contact.dart';
import '../value_objects/contact_sort.dart';

abstract class ContactsRepository {
  Future<List<Contact>> fetchContacts({
    String query,
    ContactSort sort,
    int offset,
    int limit,
  });
  Future<Contact> saveContact(Contact contact);
  Future<void> deleteContact(String contactId);
}
