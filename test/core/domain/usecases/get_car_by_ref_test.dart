import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/usecases/get_car_by_ref.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/test_params.dart';
import '../mocks/categories_repository_mock.dart';

void main() {

  final repository = MockGetRepository();
  final usecase = GetCarByRefImpl(repository: repository);
  testWidgets('Must return a carModel', (tester) async {
    when(() => repository.getCarByRef(carModelRefTest)).thenAnswer((invocation) => Future.value(Right(carModelTest)));

    final result = await usecase(carModelRefTest);

    expect(result.fold(id, id), isA<CarModel>());
  });
}