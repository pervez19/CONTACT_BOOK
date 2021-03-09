import 'package:contact_book/data/models/contact.dart';
import 'package:contact_book/domain/entities/app_error.dart';
import 'package:contact_book/domain/repositories/contact_repository.dart';
import 'package:dartz/dartz.dart';

class EditContact {

  final ContactRepository repository;
 EditContact(this.repository);


  Future<Either<AppError, ContactModel>> call(ContactModel contactModel) async {
    return await repository.editContact(contactModel);
  }
}