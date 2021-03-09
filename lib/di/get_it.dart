import 'package:contact_book/data/core/Contacts_database.dart';
import 'package:contact_book/data/data_sources/contact_remote_data_source.dart';
import 'package:contact_book/data/repositories/contact_repository_impl.dart';
import 'package:contact_book/domain/repositories/contact_repository.dart';
import 'package:contact_book/domain/usecases/edit_contact.dart';
import 'package:contact_book/domain/usecases/get_contact.dart';
import 'package:contact_book/domain/usecases/remove_contact.dart';
import 'package:contact_book/domain/usecases/save_contact.dart';
import 'package:contact_book/domain/usecases/search_contact.dart';
import 'package:get_it/get_it.dart';

final getItInstances = GetIt.I;
 


Future init() async {
  


  getItInstances
      .registerLazySingleton <ContactsDatabase  >(() =>ContactsDatabase());

  // getItInstances
  //     .registerLazySingleton<DatabaseClient>(() => DatabaseClient(getItInstances()));

  getItInstances.registerLazySingleton<ContactRemoteDataSource>(
      () => ContactRemoteDataSourceImpl());


  getItInstances.registerLazySingleton<ContactRepository>(
      () => ContactRepositoryImpl(getItInstances()));


getItInstances.registerLazySingleton<GetContacts>(
      () => GetContacts(getItInstances()));


getItInstances.registerLazySingleton<SaveContact>(
      () => SaveContact(getItInstances()));

getItInstances.registerLazySingleton<SearchContact >(
      () => SearchContact (getItInstances()));
  


getItInstances.registerLazySingleton<EditContact>(
      () => EditContact(getItInstances()));


getItInstances.registerLazySingleton<RemoveContact>(
      () => RemoveContact(getItInstances()));
    
}