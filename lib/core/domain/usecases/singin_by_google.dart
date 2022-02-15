import 'package:dartz/dartz.dart';

import 'package:flutter_rent/core/domain/entities/logged_user.dart';
import 'package:flutter_rent/core/domain/errors/userErros/errors.dart';
import 'package:flutter_rent/core/domain/repository/user_repository.dart';

abstract class SingInByGoogle {
  Future<Either<AuthException, LoggedUser>> call();
}

class SingInByGoogleImpl implements SingInByGoogle {

  final UserRepository repository;
  SingInByGoogleImpl({
    required this.repository,
  });

  @override
  Future<Either<AuthException, LoggedUser>> call() async{
    return await repository.singInByGoogle();
  }

}
