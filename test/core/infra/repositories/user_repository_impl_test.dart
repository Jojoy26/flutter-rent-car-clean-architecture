
import 'package:dartz/dartz.dart';
import 'package:flutter_rent/commons/networkInfo/network_info.dart';
import 'package:flutter_rent/core/domain/entities/logged_user.dart';
import 'package:flutter_rent/core/domain/errors/userErros/errors.dart';

import 'package:flutter_rent/core/infra/datasources/user_datasource.dart';
import 'package:flutter_rent/core/infra/repositories/user_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/network_info_mock.dart';
import '../../../commons/test_params.dart';



class MockUserDatasource extends Mock implements UserDatasource{}

void main() {
  final netInfo = MockNetworkInfo();
  final datasource = MockUserDatasource();
  final repository = UserRepositoryImpl(datasource: datasource, netInfo: netInfo);
  
  // SingUp Tests
  group("SingUpByEmailTest", (){
    testWidgets('Must return LoggedUser ', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.singUpByEmail(credentialParamsSingUpTest)).thenAnswer((realInvocation) => Future.value(loggedUserTest));
      final result = await repository.singUpByEmail(
        credentialParamsSingUpTest
      );

      expect(result.fold(id, id), isA<LoggedUser>());
    });

    testWidgets('Must throw a error if no connection ', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(false));
      when(() => datasource.singUpByEmail(credentialParamsSingUpTest)).thenAnswer((realInvocation) => Future.value(loggedUserTest));
      final result = await repository.singUpByEmail(
        credentialParamsSingUpTest
      );

      expect(result.fold(id, id), isA<NoInternetConnection>());
    });

    testWidgets('Must throw a error SingUpException ', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.singUpByEmail(credentialParamsSingUpTest)).thenThrow(Exception());
      final result = await repository.singUpByEmail(
        credentialParamsSingUpTest
      );

      expect(result.fold(id, id), isA<SingUpException>());
    });
  });


  // Login Tests

  group("LoginByEmailTest", (){
    testWidgets('Must return LoggedUser ', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.loginByEmail(credentialParamsLoginTest)).thenAnswer((_) => Future.value(loggedUserTest));
      final result = await repository.loginByEmail(
        credentialParamsLoginTest
      );

      expect(result.isRight(), true);
    });
    testWidgets('Must throw a error if no connection ', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(false));
      when(() => datasource.loginByEmail(credentialParamsLoginTest)).thenAnswer((_) => Future.value(loggedUserTest));
      final result = await repository.loginByEmail(
        credentialParamsLoginTest
      );

      expect(result.isLeft(), true);
    });
    testWidgets('Must throw a error LoginException ', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.loginByEmail(credentialParamsLoginTest)).thenThrow(Exception());
      final result = await repository.loginByEmail(
        credentialParamsLoginTest
      );

      expect(result.fold(id, id), isA<LoginException>());
    });
  });

  // SingInByGoogle

  group("SingInByGoogleTest", (){
    testWidgets('Must return LoggedUser', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.singInByGoogle()).thenAnswer((_) => Future.value(loggedUserTest));
      final result = await repository.singInByGoogle();

      expect(result.isRight(), true);
    });

    testWidgets('Must throw a error if no connection ', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(false));
      when(() => datasource.singInByGoogle()).thenAnswer((_) => Future.value(loggedUserTest));
      final result = await repository.singInByGoogle();

      expect(result.isLeft(), true);
    });

    testWidgets('Must throw a error LoginException ', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.singInByGoogle()).thenThrow(Exception());
      final result = await repository.singInByGoogle();

      expect(result.fold(id, id), isA<SingInByGoogleException>());
    });
  });

  // GetCurretnUser
  group("GetCurrentUserTest", (){
    testWidgets('Must return LoggedUser', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.getCurrentUser()).thenAnswer((_) => Future.value(loggedUserTest));
      final result = await repository.getCurrentUser();

      expect(result.isRight(), true);
    });

    testWidgets('Must throw a error if no connection ', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(false));
      when(() => datasource.getCurrentUser()).thenAnswer((_) => Future.value(loggedUserTest));
      final result = await repository.getCurrentUser();

      expect(result.isLeft(), true);
    });

    testWidgets('Must throw a error GetCurrentUserException ', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.getCurrentUser()).thenThrow(Exception());
      final result = await repository.getCurrentUser();

      expect(result.fold(id, id), isA<GetCurrentUserException>());
    });
  });

}


