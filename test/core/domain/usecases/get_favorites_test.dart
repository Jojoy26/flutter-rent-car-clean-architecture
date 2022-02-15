import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/errors/favoritesErrors/erros.dart';
import 'package:flutter_rent/core/domain/usecases/get_favorites.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/favorites_repository_mock.dart';

void main() {

  final repository = MockFavoritesRepository();
  final usecase = GetFavoritesImpl(repository: repository);
  testWidgets('Must return a List of string', (tester) async {
    when(() => repository.getFavorites()).thenAnswer((invocation) => Future.value(Right(<String>[])));

    final result = await usecase();

    expect(result.fold(id, id), isA<List<String>>());
  });

  testWidgets('Must return a FailureGetFavorites', (tester) async {
    when(() => repository.getFavorites()).thenAnswer((invocation) => Future.value(Left(FailureGetFavorites())));

    final result = await usecase();

    expect(result.fold(id, id), isA<FailureGetFavorites>());
  });
}