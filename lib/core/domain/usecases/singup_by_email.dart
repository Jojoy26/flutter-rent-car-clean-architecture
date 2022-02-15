import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/entities/logged_user.dart';
import 'package:flutter_rent/core/domain/errors/userErros/errors.dart';
import 'package:flutter_rent/core/domain/repository/user_repository.dart';

abstract class SingUpByEmail {
  Future<Either<AuthException, LoggedUser>> call(CredentialParamsSingUp params);
}

class SingUpByEmailImpl implements SingUpByEmail {

  final UserRepository repository;
  SingUpByEmailImpl({
    required this.repository,
  });

  @override
  Future<Either<AuthException, LoggedUser>> call(CredentialParamsSingUp params) async{
    return await repository.singUpByEmail(params);
  }

}

class CredentialParamsSingUp {
  final String email;
  final String password;
  final String name;
  final String phoneNumber;
  CredentialParamsSingUp({
    required this.email,
    required this.password,
    required this.name,
    required this.phoneNumber,
  });
}