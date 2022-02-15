import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/usecases/get_current_user.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_splash_presenter.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_user_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/test_params.dart';

class MockGetxUserPresenter extends Mock implements GetxUserPresenter{}
class MockGetCurrentUser extends Mock implements GetCurrentUser{}
void main() {

  final getCurrentUserUsecase = MockGetCurrentUser();
  final userPresenter = MockGetxUserPresenter();
  final splashPresenter = GetxSplashPresenter(getCurrentUserUsecase: getCurrentUserUsecase, userPresenter: userPresenter);
  testWidgets('Must call a getCurrentUserUsecase', (tester) async {
    when(() => getCurrentUserUsecase.call()).thenAnswer((invocation) => Future.value(Right(loggedUserTest)));

    await splashPresenter.callGetCurrentUser();
    
    verify(() => getCurrentUserUsecase.call());
  });
  testWidgets('Must call a userPresenter setUser', (tester) async {
    when(() => getCurrentUserUsecase.call()).thenAnswer((invocation) => Future.value(Right(loggedUserTest)));
    when(() => userPresenter.setUser(loggedUserTest)).thenAnswer((invocation) { });

    await splashPresenter.callGetCurrentUser();
    
    verify(() => userPresenter.setUser(loggedUserTest));
  });
}