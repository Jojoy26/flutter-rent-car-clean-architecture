import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/errors/favoritesErrors/erros.dart';
import 'package:flutter_rent/core/domain/usecases/save_favorites.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/test_params.dart';
import '../mocks/favorites_repository_mock.dart';

void main() {

  final repository = MockFavoritesRepository();
  final usecase = SaveFavoritesImpl(repository: repository);
  testWidgets('Must return a list of String', (tester) async {
    when(() => repository.saveFavorites(listTest)).thenAnswer((invocation) => Future.value(Right(<String>[])));

    final result = await usecase(listTest);

    expect(result.fold(id, id), isA<List<String>>());
  });

  testWidgets('Must return a FailureSaveFavorites', (tester) async {
    when(() => repository.saveFavorites(listTest)).thenAnswer((invocation) => Future.value(Left(FailureSaveFavorites())));

    final result = await usecase(listTest);

    expect(result.fold(id, id), isA<FailureSaveFavorites>());
  });
}