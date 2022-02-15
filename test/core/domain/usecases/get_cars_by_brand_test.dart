import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/errors/getCarsByBrand/errors.dart';
import 'package:flutter_rent/core/domain/usecases/get_cars_by_brand.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/test_params.dart';
import '../mocks/categories_repository_mock.dart';

void main() {

  final repository = MockGetRepository();
  final usecase = GetCarsByBrandImpl(repository: repository);
  testWidgets('Must return a list CarModel by brand', (tester) async {
    when(() => repository.getCarsByBrand(brandNameTest)).thenAnswer((invocation) => Future.value(Right(<CarModel>[])));

    final result = await usecase(brandNameTest);

    expect(result.fold(id, id), isA<List<CarModel>>());
  });

  testWidgets('Must return a FailureGetCarsByBrand', (tester) async {
    when(() => repository.getCarsByBrand(brandNameTest)).thenAnswer((invocation) => Future.value(Left(FailureGetCarsByBrand())));

    final result = await usecase(brandNameTest);

    expect(result.fold(id, id), isA<FailureGetCarsByBrand>());
  });
}