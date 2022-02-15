import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/errors/rentCarException/errors.dart';
import 'package:flutter_rent/core/infra/datasources/rent_car_datasource.dart';
import 'package:flutter_rent/core/infra/repositories/rent_car_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/network_info_mock.dart';
import '../../../commons/test_params.dart';

class MockRentCarDatasource extends Mock implements RentCarDatasource{}
void main() {

  final datasource = MockRentCarDatasource();
  final netInfo = MockNetworkInfo();
  final repository = RentCarRepositoryImpl(datasource: datasource, netInfo: netInfo);

  testWidgets('Must return refDocument string', (tester) async {
    when(() => netInfo.isConnected()).thenAnswer((invocation) => Future.value(true));
    when(() => datasource.rentCar(rentCarParamsTest)).thenAnswer((invocation) => Future.value(stringReturnedOfRentcarTest));

    final result = await repository.rentCar(rentCarParamsTest);

    expect(result.fold(id, id), isA<String>());
  });

  testWidgets('Must throw a error if no connection', (tester) async {
    when(() => netInfo.isConnected()).thenAnswer((invocation) => Future.value(false));
    when(() => datasource.rentCar(rentCarParamsTest)).thenAnswer((invocation) => Future.value(stringReturnedOfRentcarTest));

    final result = await repository.rentCar(rentCarParamsTest);

    expect(result.fold(id, id), isA<NoInternetConnectionRentCar>());
  });

  testWidgets('Must throw a error FailureRentCar', (tester) async {
    when(() => netInfo.isConnected()).thenAnswer((invocation) => Future.value(true));
    when(() => datasource.rentCar(rentCarParamsTest)).thenThrow(Exception());

    final result = await repository.rentCar(rentCarParamsTest);

    expect(result.fold(id, id), isA<FailureRentCar>());
  });
}