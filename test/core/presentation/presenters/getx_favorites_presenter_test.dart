import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/usecases/get_favorites.dart';
import 'package:flutter_rent/core/domain/usecases/save_favorites.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_favorites_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/test_params.dart';


class MockGetFavorites extends Mock implements GetFavorites{}
class MockSaveFavorites extends Mock implements SaveFavorites{}
void main() {

  final getFavoritesUsecase = MockGetFavorites();
  final saveFavoritesUsecase = MockSaveFavorites();

  final favoritesPresenter = GetxFavoritesPresenter(getFavoritesUsecase: getFavoritesUsecase, saveFavoritesUsecase: saveFavoritesUsecase);
  testWidgets('Must call a getFavoritesUsecase', (tester) async {
    when(() => getFavoritesUsecase.call()).thenAnswer((invocation) => Future.value(Right(listTest)));

    final result = favoritesPresenter.callGetFavorites();

    verify(() => getFavoritesUsecase.call());
  });

  testWidgets('Must call a saveFavoritesUsecase', (tester) async {
    when(() => saveFavoritesUsecase.call(listTest)).thenAnswer((invocation) => Future.value(Right(listTest)));

    final result = favoritesPresenter.callSaveFavorites();

    verify(() => saveFavoritesUsecase.call(listTest));
  });
}