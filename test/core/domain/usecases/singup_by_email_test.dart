import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/entities/logged_user.dart';
import 'package:flutter_rent/core/domain/errors/userErros/errors.dart';
import 'package:flutter_rent/core/domain/usecases/singup_by_email.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';



import '../../../commons/test_params.dart';
import '../mocks/user_repository_mock.dart';




void main() {
  final repository = MockUserRepository();
  final usecase = SingUpByEmailImpl(repository: repository);
  
  testWidgets('Must return a loggedUser', (tester) async {
    when(() => repository.singUpByEmail(credentialParamsSingUpTest)).thenAnswer((realInvocation) => Future.value(Right(loggedUserTest)));
    final result = await usecase(credentialParamsSingUpTest);
    expect(result.fold(id, id ), isA<LoggedUser>());
  });

  testWidgets("Must return a SingUpException", (tester) async {
    when(() => repository.singUpByEmail(credentialParamsSingUpTest)).thenAnswer((_) => Future.value(Left(SingUpException())));
    final result = await usecase(credentialParamsSingUpTest);
    expect(result.fold(id, id ), isA<SingUpException>());
  });
}