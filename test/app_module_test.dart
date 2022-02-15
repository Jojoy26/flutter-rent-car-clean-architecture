import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart' as modular;
import 'package:flutter_rent/app_module.dart';
import 'package:flutter_rent/commons/networkInfo/network_info.dart';
import 'package:flutter_rent/core/domain/entities/logged_user.dart';
import 'package:flutter_rent/core/domain/usecases/get_favorites.dart';
import 'package:flutter_rent/core/domain/usecases/singup_by_email.dart';

import 'package:flutter_rent/core/infra/datasources/user_datasource.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_categories_presenter.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import 'commons/network_info_mock.dart';
import 'commons/test_params.dart';


class MockUserDatasource extends Mock implements UserDatasource {}


void main() {

  final datasourceMock = MockUserDatasource();
  final netInfoMock = MockNetworkInfo();

  initModule(AppModule(), replaceBinds: [
    modular.Bind.factory<UserDatasource>((i) => datasourceMock),
    modular.Bind.factory<NetworkInfo>((i) => netInfoMock)
  ]);
  testWidgets('Must recover usecase', (tester) async {
    final usecase = modular.Modular.get<SingUpByEmail>();

    expect(usecase, isA<SingUpByEmailImpl>());
  });

  testWidgets('Must return a LoggedUser instance', (tester) async {

    when(() => netInfoMock.isConnected()).thenAnswer((_) => Future.value(true));
    when(() => datasourceMock.singUpByEmail(credentialParamsSingUpTest)).thenAnswer((realInvocation) => 
    Future.value(loggedUserTest));

    final usecase = modular.Modular.get<SingUpByEmail>();
    final result = await usecase.call(credentialParamsSingUpTest);

    expect(result.fold(id, id), isA<LoggedUser>());
  });

  testWidgets('Must recover usecase GetFavorites', (tester) async {
    final usecase = modular.Modular.get<GetFavorites>();

    expect(usecase, isA<GetFavoritesImpl>());
  });

  testWidgets('Must recover usecase GetxCategoriesPresenter', (tester) async {
    final usecase = modular.Modular.get<GetxCategoriesPresenter>();

    expect(usecase, isA<GetxCategoriesPresenter>());
  });
  
}