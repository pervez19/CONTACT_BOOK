import 'package:contact_book/common/constants/constants.dart';
import 'package:contact_book/data/models/base/event_object.dart';
import 'package:contact_book/data/models/contact.dart';
import 'package:contact_book/di/get_it.dart' as getIt;
import 'package:contact_book/domain/entities/app_error.dart';
import 'package:contact_book/domain/entities/no_params.dart';
import 'package:contact_book/domain/usecases/edit_contact.dart';
import 'package:contact_book/domain/usecases/get_contact.dart';
import 'package:contact_book/domain/usecases/remove_contact.dart';
import 'package:contact_book/domain/usecases/save_contact.dart';
import 'package:contact_book/domain/usecases/search_contact.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:dartz/dartz.dart';
import 'package:pedantic/pedantic.dart';

Future<EventObject> loadContactList() async {
  unawaited(getIt.init());
  GetContacts getContacts = getIt.getItInstances<GetContacts>();
  // PreferenceConstants preferenceConstants = PreferenceConstants();
  // PreferenceClient preferenceClient = PreferenceClient(preferenceConstants);
  // ContactRemoteDataSource dataSource =
  //     ContactRemoteDataSourceImpl(preferenceClient);
  // ContactRepository contactRepository = ContactRepositoryImpl(dataSource);
  //GetContacts getContacts = GetContacts(contactRepository);
  print("Call loadContacts");
  final Either<AppError, List<ContactModel>> eitherResponse =
      await getContacts(NoParams());
  print("Call eitherResponse");
  eitherResponse.fold(
    (l) {
      return new EventObject(id: Events.NO_CONTACTS_FOUND);
    },
    (r) {
      return new EventObject(id: Events.READ_CONTACTS_SUCCESSFUL, object: r);
    },
  );
  return new EventObject(id: Events.NO_CONTACTS_FOUND);
}

Future<EventObject> saveContact(ContactModel contactToBeCreated) async {
  unawaited(getIt.init());
  SaveContact saveContact = getIt.getItInstances<SaveContact>();
  // PreferenceConstants preferenceConstants = PreferenceConstants();
  // DatabaseClient preferenceClient = DatabaseClient(preferenceConstants);
  // ContactRemoteDataSource dataSource =
  //     ContactRemoteDataSourceImpl(preferenceClient);
  // ContactRepository contactRepository = ContactRepositoryImpl(dataSource);
  // SaveContact saveContact = SaveContact(contactRepository);
  final Either<AppError, ContactModel> eitherResponse =
      await saveContact(contactToBeCreated);
  eitherResponse.fold(
    (l) {
      return new EventObject(id: Events.UNABLE_TO_CREATE_CONTACT);
    },
    (r) {
      return new EventObject(
          id: Events.CONTACT_WAS_CREATED_SUCCESSFULLY, object: r);
    },
  );
  return new EventObject(id: Events.UNABLE_TO_CREATE_CONTACT);
}


Future<EventObject> searchContactsAvailable(String searchQuery) async { unawaited(getIt.init());
  unawaited(getIt.init());
  SearchContact  searchContact = getIt.getItInstances<SearchContact >();
  // PreferenceConstants preferenceConstants = PreferenceConstants();
  // PreferenceClient preferenceClient = PreferenceClient(preferenceConstants);
  // ContactRemoteDataSource dataSource =
  //     ContactRemoteDataSourceImpl(preferenceClient);
  // ContactRepository contactRepository = ContactRepositoryImpl(dataSource);
  //GetContacts getContacts = GetContacts(contactRepository);
  print("Call loadContacts");
  final Either<AppError, List<ContactModel>> eitherResponse =
      await searchContact(searchQuery);
  print("Call eitherResponse");
  eitherResponse.fold(
    (l) {
      return new EventObject(id: Events.NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY);
    },
    (r) {
      return new EventObject(id: Events.SEARCH_CONTACTS_SUCCESSFUL, object: r);
    },
  );
  return new EventObject(id: Events.NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY);
}


Future<EventObject> updateContact(ContactModel contactToBeEdited) async{
   unawaited(getIt.init());
   EditContact editContact = getIt.getItInstances<EditContact>();
  // PreferenceConstants preferenceConstants = PreferenceConstants();
  // DatabaseClient preferenceClient = DatabaseClient(preferenceConstants);
  // ContactRemoteDataSource dataSource =
  //     ContactRemoteDataSourceImpl(preferenceClient);
  // ContactRepository contactRepository = ContactRepositoryImpl(dataSource);
  // EditContact editContact = EditContact(contactRepository);
  final Either<AppError, ContactModel> eitherResponse =
      await editContact(contactToBeEdited);
  eitherResponse.fold(
    (l) {
      return new EventObject(id: Events.UNABLE_TO_UPDATE_CONTACT);
    },
    (r) {
      return new EventObject(
          id: Events.CONTACT_WAS_UPDATED_SUCCESSFULLY, object: r);
    },
  );
  return new EventObject(id: Events.UNABLE_TO_UPDATE_CONTACT);
}




 Future<EventObject> removeContact(ContactModel contactModel)
 async {
     unawaited(getIt.init());
   RemoveContact removeContact= getIt.getItInstances<RemoveContact>();
  // PreferenceConstants preferenceConstants = PreferenceConstants();
  // DatabaseClient preferenceClient = DatabaseClient(preferenceConstants);
  // ContactRemoteDataSource dataSource =
  //     ContactRemoteDataSourceImpl(preferenceClient);
  // ContactRepository contactRepository = ContactRepositoryImpl(dataSource);
  // RemoveContact removeContact = RemoveContact(contactRepository);
  final Either<AppError, ContactModel> eitherResponse =
      await removeContact(contactModel);
  eitherResponse.fold(
    (l) {
      return new EventObject(id: Events.NO_CONTACT_WITH_PROVIDED_ID_EXIST_IN_DATABASE);
    },
    (r) {
      return new EventObject(
          id: Events.CONTACT_WAS_DELETED_SUCCESSFULLY);
    },
  );
  return new EventObject(id: Events.NO_CONTACT_WITH_PROVIDED_ID_EXIST_IN_DATABASE);
 }