import 'package:contact_book/data/models/contact.dart';
import 'package:contact_book/domain/entities/app_error.dart';
import 'package:contact_book/domain/entities/no_params.dart';
import 'package:contact_book/domain/repositories/contact_repository.dart';
import 'package:contact_book/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetContacts extends UseCase<List<ContactModel>, NoParams> {
  final ContactRepository repository;
  GetContacts(this.repository);
  
  @override
  Future<Either<AppError, List<ContactModel>>> call(NoParams noParams) async {
    print("Get Contacts Call");
    return await repository.getContacts();
  }
}
