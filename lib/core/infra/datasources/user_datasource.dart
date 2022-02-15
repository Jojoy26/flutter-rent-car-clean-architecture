import 'package:flutter_rent/core/domain/entities/logged_user.dart';
import 'package:flutter_rent/core/domain/usecases/login_by_email.dart';
import 'package:flutter_rent/core/domain/usecases/singup_by_email.dart';

abstract class UserDatasource {
  Future<LoggedUser> singUpByEmail (CredentialParamsSingUp params);
  Future<LoggedUser> loginByEmail (CredentialParamsLogin params);
  Future<LoggedUser> singInByGoogle ();
  Future<LoggedUser> getCurrentUser ();
}