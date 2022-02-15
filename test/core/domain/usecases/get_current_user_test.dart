import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/entities/logged_user.dart';
import 'package:flutter_rent/core/domain/errors/userErros/errors.dart';
import 'package:flutter_rent/core/domain/usecases/get_current_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/test_params.dart';
import '../mocks/user_repository_mock.dart';

void main() {

  final repository = MockUserRepository();
  final usecase = GetCurrentUserImpl(repository: repository);
  testWidgets('Must return a loggedUser', (tester) async {
    when(() => repository.getCurrentUser()).thenAnswer((invocation) => Future.value(Right(loggedUserTest)));

    final result = await usecase();
    
    expect(result.fold(id, id), isA<LoggedUser>());
  });

  testWidgets('Must return a GetCurrentUserException', (tester) async {
    when(() => repository.getCurrentUser()).thenAnswer((invocation) => Future.value(Left(GetCurrentUserException())));

    final result = await usecase();
    
    expect(result.fold(id, id), isA<GetCurrentUserException>());
  });
}