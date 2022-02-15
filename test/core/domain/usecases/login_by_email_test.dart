import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/entities/logged_user.dart';
import 'package:flutter_rent/core/domain/errors/userErros/errors.dart';

import 'package:flutter_rent/core/domain/usecases/login_by_email.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


import '../../../commons/test_params.dart';
import '../mocks/user_repository_mock.dart';



void main() {

  final repository = MockUserRepository();
  final usecase = LoginByEmailImpl(repository: repository);

  testWidgets('Must return LoggedUser', (tester) async {
    when(() => repository.loginByEmail(credentialParamsLoginTest)).thenAnswer((realInvocation) => Future.value(Right(loggedUserTest)));
    final result = await usecase(credentialParamsLoginTest);
    expect(result.fold(id, id), isA<LoggedUser>());
  });
  testWidgets('Must return LoginException', (tester) async {
    when(() => repository.loginByEmail(credentialParamsLoginTest)).thenAnswer((realInvocation) => Future.value(Left(LoginException())));
    final result = await usecase(credentialParamsLoginTest);
    expect(result.fold(id, id), isA<LoginException>());
  });
  
}