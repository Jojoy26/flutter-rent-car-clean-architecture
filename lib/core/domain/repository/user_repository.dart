import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/entities/logged_user.dart';
import 'package:flutter_rent/core/domain/errors/userErros/errors.dart';

import 'package:flutter_rent/core/domain/usecases/login_by_email.dart';
import 'package:flutter_rent/core/domain/usecases/singup_by_email.dart';

abstract class UserRepository {
  Future<Either<AuthException, LoggedUser>> singUpByEmail(CredentialParamsSingUp params);
  Future<Either<AuthException, LoggedUser>> loginByEmail(CredentialParamsLogin params);
  Future<Either<AuthException, LoggedUser>> singInByGoogle();
  Future<Either<AuthException, LoggedUser>> getCurrentUser();
}