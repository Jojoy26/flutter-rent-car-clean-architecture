import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/entities/logged_user.dart';
import 'package:flutter_rent/core/domain/errors/userErros/errors.dart';
import 'package:flutter_rent/core/domain/usecases/singin_by_google.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


import '../../../commons/test_params.dart';
import '../mocks/user_repository_mock.dart';


void main() {

  final repository = MockUserRepository();
  final usecase = SingInByGoogleImpl(repository: repository);
  testWidgets('Must return Logged User', (tester) async {
    when(() => repository.singInByGoogle()).thenAnswer((realInvocation) => Future.value(Right(loggedUserTest)));
    final result = await usecase();

    expect(result.fold(id, id), isA<LoggedUser>());
  });
  testWidgets('Must return SingInByGoogleException', (tester) async {
    when(() => repository.singInByGoogle()).thenAnswer((realInvocation) => Future.value(Left(SingInByGoogleException())));
    final result = await usecase();

    expect(result.fold(id, id), isA<SingInByGoogleException>());
  });
}