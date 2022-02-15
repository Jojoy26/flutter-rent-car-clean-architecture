import 'package:dartz/dartz.dart';

import 'package:flutter_rent/core/domain/entities/logged_user.dart';
import 'package:flutter_rent/core/domain/errors/userErros/errors.dart';
import 'package:flutter_rent/core/domain/repository/user_repository.dart';

abstract class GetCurrentUser {
  Future<Either<AuthException, LoggedUser>> call();
}

class GetCurrentUserImpl implements GetCurrentUser {

  final UserRepository repository;
  GetCurrentUserImpl({
    required this.repository,
  });

  @override
  Future<Either<AuthException, LoggedUser>> call() async {
    return await repository.getCurrentUser();
  }
}
