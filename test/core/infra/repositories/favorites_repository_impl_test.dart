import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/errors/favoritesErrors/erros.dart';
import 'package:flutter_rent/core/infra/datasources/favorites_datasource.dart';
import 'package:flutter_rent/core/infra/repositories/favorites_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/test_params.dart';

class MockFavoritesDatasource extends Mock implements FavoritesDatasource{}

void main() {

  final datasource = MockFavoritesDatasource();
  final repository = FavoritesRepositoryImpl(datasource: datasource);
  group("GetFavoritesTest", (){
    testWidgets('Must return a List of String', (tester) async {
      when(() => datasource.getFavorites()).thenAnswer((invocation) => Future.value(<String>[]));

      final result = await repository.getFavorites();

      expect(result.fold(id, id), isA<List<String>>());
    });

    testWidgets('Must throw a FailureGetFavorites', (tester) async {
      when(() => datasource.getFavorites()).thenThrow(Exception());

      final result = await repository.getFavorites();

      expect(result.fold(id, id), isA<FailureGetFavorites>());
    });
  });

  group("SaveFavoritesTest", (){
    testWidgets('Must return a List of String', (tester) async {
      when(() => datasource.saveFavorites(listTest)).thenAnswer((invocation) => Future.value(<String>[]));

      final result = await repository.saveFavorites(listTest);

      expect(result.fold(id, id), isA<List<String>>());
    });

    testWidgets('Must throw a FailureSaveFavorites', (tester) async {
      when(() => datasource.saveFavorites(listTest)).thenThrow(Exception());

      final result = await repository.saveFavorites(listTest);

      expect(result.fold(id, id), isA<FailureSaveFavorites>());
    });
  });
}