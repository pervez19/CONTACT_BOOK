import 'package:contact_book/data/models/contact.dart';
import 'package:contact_book/domain/entities/app_error.dart';
import 'package:contact_book/domain/repositories/contact_repository.dart';
import 'package:dartz/dartz.dart';

class SearchContact  {
  final ContactRepository repository;
  SearchContact(this.repository);
  Future<Either<AppError, List<ContactModel>>> call(String searchQuery) async {
    print("Get Contacts Call");
    return await repository.searchContact(searchQuery);
  }

}
