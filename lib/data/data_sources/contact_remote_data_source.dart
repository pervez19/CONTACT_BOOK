import 'package:contact_book/common/constants/constants.dart';
import 'package:contact_book/data/core/database_client.dart';
import 'package:contact_book/data/models/base/event_object.dart';
import 'package:contact_book/data/models/contact.dart';

abstract class ContactRemoteDataSource {
  Future<List<ContactModel>> getContacts();
  Future<List<ContactModel>> searchContacts(String searchQuery);
  Future<ContactModel> saveContact(ContactModel contactModel);

  Future<ContactModel> editContact(ContactModel contactModel);

  Future<ContactModel> removeContact(ContactModel contactModel);
}

class ContactRemoteDataSourceImpl extends ContactRemoteDataSource {
  //DatabaseClient _preferenceClient;

  ContactRemoteDataSourceImpl();

  @override
  Future<List<ContactModel>> getContacts() async {
    print("Call Remote data Source");
    EventObject eventObject =
        await get(SharedPreferenceKeys.CONTACTS);
    print(eventObject.id);
    List<ContactModel> contacts;
    if (eventObject.id == Events.READ_CONTACTS_SUCCESSFUL) {
      contacts = eventObject.object;
    }
    print(contacts);
    return contacts;
  }

  @override
  Future<ContactModel> saveContact(ContactModel contactModel) async {
    EventObject eventObject = await save(contactModel);
    ContactModel contact;
    if (eventObject.id == Events.CONTACT_WAS_CREATED_SUCCESSFULLY) {
      contact = eventObject.object;
    }
    print(contact);
    return contact;
  }

  @override
  Future<List<ContactModel>> searchContacts(String searchQuery) async {
    EventObject eventObject =
        await searchContactUsingPrefs(searchQuery);
    print(eventObject.id);
    List<ContactModel> contacts;
    if (eventObject.id == Events.SEARCH_CONTACTS_SUCCESSFUL) {
      contacts = eventObject.object;
    }
    print(contacts);
    return contacts;
  }

  @override
  Future<ContactModel> editContact(ContactModel contactModel) async {
    EventObject eventObject = await edit(contactModel);
    ContactModel contact;
    if (eventObject.id == Events.CONTACT_WAS_UPDATED_SUCCESSFULLY) {
      contact = eventObject.object;
    }
    print(contact);
    return contact;
  }

  @override
  Future<ContactModel> removeContact(ContactModel contactModel) async {
    EventObject eventObject =await remove(contactModel);
    ContactModel contact;
    if (eventObject.id == Events.CONTACT_WAS_UPDATED_SUCCESSFULLY) {
      contact = eventObject.object;
    }
    print(contact);
    return contact;
  }
}
