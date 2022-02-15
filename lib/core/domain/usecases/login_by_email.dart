import 'package:dartz/dartz.dart';

import 'package:flutter_rent/core/domain/entities/logged_user.dart';
import 'package:flutter_rent/core/domain/errors/userErros/errors.dart';
import 'package:flutter_rent/core/domain/repository/user_repository.dart';

abstract class LoginByEmail {
  Future<Either<AuthException, LoggedUser>> call(CredentialParamsLogin params);
}

class LoginByEmailImpl implements LoginByEmail {

  final UserRepository repository;
  LoginByEmailImpl({
    required this.repository,
  });

  @override
  Future<Either<AuthException, LoggedUser>> call(CredentialParamsLogin params) async{
    return await repository.loginByEmail(params);
  }

}




class CredentialParamsLogin {
  final String email;
  final String password;
  CredentialParamsLogin({
    required this.email,
    required this.password,
  });
}
