import 'package:contact_book/data/models/contact.dart';
import 'package:contact_book/domain/entities/app_error.dart';
import 'package:contact_book/domain/repositories/contact_repository.dart';
import 'package:dartz/dartz.dart';

class SaveContact {

  final ContactRepository repository;
 SaveContact(this.repository);


  Future<Either<AppError, ContactModel>> call(ContactModel contactModel) async {
    return await repository.saveContact(contactModel);
  }
}