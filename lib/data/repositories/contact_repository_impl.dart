import 'package:contact_book/data/data_sources/contact_remote_data_source.dart';
import 'package:contact_book/data/models/contact.dart';
import 'package:contact_book/domain/entities/app_error.dart';
import 'package:contact_book/domain/repositories/contact_repository.dart';
import 'package:dartz/dartz.dart';

class ContactRepositoryImpl extends ContactRepository {
  final ContactRemoteDataSource remoteDataSource;

  ContactRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<ContactModel>>> getContacts() async {
    print("Call ContactRepositoryImp");
    try {
      final contacts = await remoteDataSource.getContacts();
      print(contacts);
      if (contacts != null) {
        print("Return Rightttttttttttttttttttttt");
        return Right(contacts);
      } else {
        print("Return Error Type");
        return Left(AppError(AppErrorType.Contact_Not_Found));
      }
    } on Exception {
      print("Return Error Type");
      return Left(AppError(AppErrorType.Contact_Not_Found));
    }
  }

  @override
  Future<Either<AppError, ContactModel>> saveContact(
      ContactModel contactModel) async {
    // ContactModel contactModel = contactEntity;
    try {
      final contact = await remoteDataSource.saveContact(contactModel);
      print(contact);
      if (contact != null) {
        print("Return Rightttttttttttttttttttttt");
        return Right(contact);
      } else {
        print("Return Error Type");
        return Left(AppError(AppErrorType.Contact_Not_Found));
      }
    } on Exception {
      return Left(AppError(AppErrorType.UNABLE_TO_CREATE_CONTACT));
    }
  }

  @override
  Future<Either<AppError, List<ContactModel>>> searchContact(
      String searchQuery) async {
    print("Call ContactRepositoryImp");
    try {
      Object contacts = await remoteDataSource.searchContacts(searchQuery);
      print(contacts);
      if (contacts != null) {
        print("Return Rightttttttttttttttttttttt");
        return Right(contacts);
      } else {
        print("Return Error Type");
        return Left(AppError(AppErrorType.Contact_Not_Found));
      }
    } on Exception {
      print("Return Error Type");
      return Left(AppError(AppErrorType.Contact_Not_Found));
    }
  }

  @override
  Future<Either<AppError, ContactModel>> editContact(
      ContactModel contactModel) async {
    try {
      final contact = await remoteDataSource.editContact(contactModel);
      if (contact!= null) {
        print("Return Rightttttttttttttttttttttt");
        return Right(contact);
      } else {
        print("Return Error Type");
        return Left(AppError(AppErrorType.Contact_Not_Found));
      }
    } on Exception {
      return Left(AppError(AppErrorType.UNABLE_TO_CREATE_CONTACT));
    }
  }

  @override
  Future<Either<AppError, ContactModel>> removeContact(
      ContactModel contactModel) async {
    try {
      final contact = await remoteDataSource.removeContact(contactModel);
      if (contact != null) {
        print("Return Rightttttttttttttttttttttt");
        return Right(contact);
      } else {
        print("Return Error Type");
        return Left(AppError(AppErrorType.Contact_Not_Found));
      }
    } on Exception {
      return Left(AppError(AppErrorType.Contact_Not_Found));
    }
  }
}
