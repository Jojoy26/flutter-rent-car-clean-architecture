import 'package:flutter_rent/core/external/firebaseuser/firebase_user_datasource_impl.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import '../../../commons/test_params.dart';


class MockFirebaseUserDatasourceImpl extends Mock implements FirebaseUserDatasourceImpl{}

void main() async {

  final datasource = MockFirebaseUserDatasourceImpl();

  testWidgets('Must completes SingUpTest', (tester) async {
    when(() => datasource.singUpByEmail(credentialParamsSingUpTest)).thenAnswer((realInvocation) => Future.value(loggedUserTest));
    final result = datasource.singUpByEmail(credentialParamsSingUpTest);

    expect(result, completes);
  });

  testWidgets('Must completes LoginTest', (tester) async {
    when(() => datasource.loginByEmail(credentialParamsLoginTest)).thenAnswer((realInvocation) => Future.value(loggedUserTest));
    final result = datasource.loginByEmail(credentialParamsLoginTest);

    expect(result, completes);
  });

  testWidgets('Must completes SingInByGoogleTest', (tester) async {
    when(() => datasource.singInByGoogle()).thenAnswer((realInvocation) => Future.value(loggedUserTest));
    final result = datasource.singInByGoogle();

    expect(result, completes);
  });

  testWidgets('Must completes GetCurrentUserTest', (tester) async {
    when(() => datasource.getCurrentUser()).thenAnswer((realInvocation) => Future.value(loggedUserTest));
    final result = datasource.getCurrentUser();

    expect(result, completes);
  });
}