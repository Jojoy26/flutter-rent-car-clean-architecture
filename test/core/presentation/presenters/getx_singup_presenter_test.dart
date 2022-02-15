import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/usecases/singin_by_google.dart';
import 'package:flutter_rent/core/domain/usecases/singup_by_email.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_login_presenter.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_singup_presenter.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_user_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/test_params.dart';

class MockUserPresenter extends Mock implements GetxUserPresenter{}
void main() {

  final userPresenter = MockUserPresenter();
  final presenter = GetxSingUpPresenter(userPresenter: userPresenter);

  test('Must call a callSingInByGoogle', () async{
    when(() => userPresenter.callSingInByGoogle()).thenAnswer((invocation) => Future.value());
    await presenter.singInByGoogle();

    verify(() => userPresenter.callSingInByGoogle());
  });

  test('Must call a callSingUpByEmail', () async{
    when(() => userPresenter.callSingUpByEmail(credentialParamsSingUpTest)).thenAnswer((invocation) => Future.value());
    await presenter.singUpByEmail(credentialParamsSingUpTest);

    verify(() => userPresenter.callSingUpByEmail(credentialParamsSingUpTest));
  });
}