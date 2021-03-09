
import 'package:contact_book/common/constants/constants.dart';
import 'package:contact_book/data/core/Contacts_database.dart';
import 'package:contact_book/data/models/base/event_object.dart';
import 'package:contact_book/data/models/contact.dart';



  Future<EventObject> get(String key) async {
    try {
      var db = await ContactsDatabase.get().getDb();

      List<Map> contactsMap =
          await db.rawQuery("Select * from ${ContactTable.TABLE_NAME}");
      List<ContactModel> contacts = new List();
      if (contactsMap.isNotEmpty) {
        for (int i = 0; i < contactsMap.length; i++) {
          contacts.add(ContactModel.fromMap(contactsMap[i]));
        }
        return EventObject(
            id: Events.READ_CONTACTS_SUCCESSFUL, object: contacts);
      } else {
        return EventObject(id: Events.NO_CONTACTS_FOUND);
      }
    } catch (e) {
      print(e.toString());
      return new EventObject(id: Events.NO_CONTACTS_FOUND);
    }
  }

  Future<EventObject> save(ContactModel contact) async {
    try {
      var db = await ContactsDatabase.get().getDb();
      int affectedRows =
          await db.insert(ContactTable.TABLE_NAME, contact.toMap());
      if (affectedRows > 0) {
        return EventObject(
            id: Events.CONTACT_WAS_CREATED_SUCCESSFULLY, object: contact);
      } else {
        return EventObject(id: Events.UNABLE_TO_CREATE_CONTACT);
      }
    } catch (e) {
      print(e.toString());
      return new EventObject(id: Events.UNABLE_TO_CREATE_CONTACT);
    }
  }

  Future<EventObject> searchContactUsingPrefs(String searchQuery) async {
    try {
    var db = await ContactsDatabase.get().getDb();
    List<Map> contactsMap =
        await db.rawQuery("Select * from ${ContactTable.TABLE_NAME}");

    List<ContactModel> contacts = new List();
    if (contactsMap.isNotEmpty) {
      for (int i = 0; i < contactsMap.length; i++) {
        contacts.add(ContactModel.fromMap(contactsMap[i]));
      }
      List<ContactModel> searchedContacts = new List();
      for (ContactModel contact in contacts) {
        if (contact.name.contains(searchQuery) ||
            contact.primaryPhone.contains(searchQuery) ||
            contact.secondaryPhone.contains(searchQuery) ||
            contact.primaryEmail.contains(searchQuery) ||
            contact.secondaryEmail.contains(searchQuery) ||
            contact.address.contains(searchQuery)) {
          searchedContacts.add(contact);
        }
      }
      if (searchedContacts.isNotEmpty) {
        return EventObject(
            id: Events.SEARCH_CONTACTS_SUCCESSFUL, object: searchedContacts);
      } else {
        return EventObject(id: Events.NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY);
      }
    } else {
      return EventObject(id: Events.NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY);
    }
  } catch (e) {
    print(e.toString());
    return new EventObject(id: Events.NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY);
  }
  }

  Future<EventObject> remove(ContactModel contact) async {
    try {
      var db = await ContactsDatabase.get().getDb();
      int affectedRows = await db.delete(ContactTable.TABLE_NAME,
          where: "${ContactTable.ID}=?", whereArgs: [contact.id]);
      if (affectedRows > 0) {
        return EventObject(
          id: Events.CONTACT_WAS_DELETED_SUCCESSFULLY, object: contact
        );
      } else {
        return EventObject(
            id: Events.NO_CONTACT_WITH_PROVIDED_ID_EXIST_IN_DATABASE);
      }
    } catch (e) {
      print(e.toString());
      return new EventObject(id: Events.UNABLE_TO_DELETE_CONTACT);
    }
  }

  Future<EventObject> edit(ContactModel contact) async {
   try {
    var db = await ContactsDatabase.get().getDb();
    int affectedRows = await db.update(ContactTable.TABLE_NAME, contact.toMap(),
        where: "${ContactTable.ID}=?", whereArgs: [contact.id]);

    if (affectedRows > 0) {
      return EventObject(
        id: Events.CONTACT_WAS_UPDATED_SUCCESSFULLY, object: contact
      );
    } else {
      return EventObject(
          id: Events.NO_CONTACT_WITH_PROVIDED_ID_EXIST_IN_DATABASE);
    }
  } catch (e) {
    print(e.toString());
    return new EventObject(id: Events.UNABLE_TO_UPDATE_CONTACT);
  }
  }
