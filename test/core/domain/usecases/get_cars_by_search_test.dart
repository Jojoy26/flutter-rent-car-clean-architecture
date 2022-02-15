import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/errors/getCarsBySearch/erros.dart';
import 'package:flutter_rent/core/domain/usecases/get_cars_by_search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/test_params.dart';
import '../mocks/categories_repository_mock.dart';

void main() {
  
  final repository = MockGetRepository();
  final usecase = GetCarsBySearchImpl(repository: repository);
  testWidgets('Must return a list carModel by search', (tester) async {
    when(() => repository.getCarsBySearch(searchTest)).thenAnswer((invocation) => Future.value(Right(<CarModel>[])));

    final result = await usecase(searchTest);

    expect(result.fold(id, id ), isA<List<CarModel>>());
  });

  testWidgets('Must return a FailureGetCarsBySearch', (tester) async {
    when(() => repository.getCarsBySearch(searchTest)).thenAnswer((invocation) => Future.value(Left(FailureGetCarsBySearch())));

    final result = await usecase(searchTest);

    expect(result.fold(id, id ), isA<FailureGetCarsBySearch>());
  });
}