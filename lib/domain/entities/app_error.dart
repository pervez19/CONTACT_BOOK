import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final AppErrorType appErrorType;

  const AppError(this.appErrorType);

  @override
  List<Object> get props => [appErrorType];
}

enum AppErrorType { api, network, Contact_Not_Found, UNABLE_TO_CREATE_CONTACT }