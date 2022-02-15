import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/errors/rentCarException/errors.dart';
import 'package:flutter_rent/core/domain/repository/rent_car_repository.dart';
import 'package:flutter_rent/core/domain/usecases/rent_car.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/test_params.dart';


class MockRentCarRepository extends Mock implements RentCarRepository{}
void main() {

  final repository = MockRentCarRepository();
  final usecase = RentCarImpl(repository: repository);
  testWidgets('Must return refDocument string', (tester) async {
    when(() => repository.rentCar(rentCarParamsTest)).thenAnswer((invocation) => Future.value(Right(stringReturnedOfRentcarTest)));

    final result = await usecase(rentCarParamsTest);

    expect(result.fold(id, id ), isA<String>());
  });

  testWidgets('Must return FailureRentCar', (tester) async {
    when(() => repository.rentCar(rentCarParamsTest)).thenAnswer((invocation) => Future.value(Left(FailureRentCar())));

    final result = await usecase(rentCarParamsTest);

    expect(result.fold(id, id ), isA<FailureRentCar>());
  });
}