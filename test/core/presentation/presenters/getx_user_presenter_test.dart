import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/usecases/login_by_email.dart';
import 'package:flutter_rent/core/domain/usecases/singin_by_google.dart';
import 'package:flutter_rent/core/domain/usecases/singup_by_email.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_user_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/test_params.dart';

class MockLoginByEmail extends Mock implements LoginByEmail{}
class MockSingUpByEmail extends Mock implements SingUpByEmail{}
class MockSingInByGoogle extends Mock implements SingInByGoogle{}
void main() {

  final loginByEmail = MockLoginByEmail();
  final singUpByEmail = MockSingUpByEmail();
  final singInByGoogle = MockSingInByGoogle();

  final userPresenter = GetxUserPresenter(loginByEmailUsecase: loginByEmail, singInByGoogleUsecase: singInByGoogle, singUpByEmailUsecase: singUpByEmail);
  testWidgets('Must call a loginByEmail', (tester) async {
    when(() => loginByEmail.call(credentialParamsLoginTest)).thenAnswer((invocation) => Future.value(Right(loggedUserTest)));

    await userPresenter.callLoginByEmail(credentialParamsLoginTest);

    verify(() => loginByEmail.call(credentialParamsLoginTest));
  });
  testWidgets('Must call a singUpByEmail', (tester) async {
    when(() => singUpByEmail.call(credentialParamsSingUpTest)).thenAnswer((invocation) => Future.value(Right(loggedUserTest)));

    await userPresenter.callSingUpByEmail(credentialParamsSingUpTest);

    verify(() => singUpByEmail.call(credentialParamsSingUpTest));
  });
  testWidgets('Must call a singInByGoogle', (tester) async {
    when(() => singInByGoogle.call()).thenAnswer((invocation) => Future.value(Right(loggedUserTest)));

    await userPresenter.callSingInByGoogle();

    verify(() => singInByGoogle.call());
  });
}