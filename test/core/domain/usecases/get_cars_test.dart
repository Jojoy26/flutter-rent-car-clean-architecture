import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/errors/getCars/erros.dart';
import 'package:flutter_rent/core/domain/usecases/get_cars.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


import '../mocks/categories_repository_mock.dart';

void main() {

  final repository = MockGetRepository();
  final usecase = GetCarsImpl(repository: repository);
  testWidgets('Must return a List carModel ', (tester) async {
    when(() => repository.getCars()).thenAnswer((realInvocation) => Future.value(Right(<CarModel>[])));

    final result = await usecase.call();
    expect(result.fold(id, id), isA<List<CarModel>>());
  });

  testWidgets('Must return a FailureGetCars ', (tester) async {
    when(() => repository.getCars()).thenAnswer((realInvocation) => Future.value(Left(FailureGetCars())));

    final result = await usecase.call();
    expect(result.fold(id, id), isA<FailureGetCars>());
  });
}