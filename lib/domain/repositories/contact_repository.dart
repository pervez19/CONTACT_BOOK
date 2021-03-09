import 'package:contact_book/data/models/contact.dart';
import 'package:contact_book/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

abstract class ContactRepository {
  Future<Either<AppError, List<ContactModel>>> getContacts();
  Future<Either<AppError, ContactModel>> saveContact(ContactModel contactModel);

  Future<Either<AppError, List<ContactModel>>> searchContact(
      String searchQuery);

  Future<Either<AppError, ContactModel>> editContact(ContactModel contactModel);

  Future<Either<AppError, ContactModel>> removeContact(
      ContactModel contactModel);
}
