import 'package:flutter_rent/core/domain/entities/brand_model.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/entities/rent_model.dart';

import 'package:flutter_rent/core/external/firebaseGet/firebase_get_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import '../../../commons/test_params.dart';


class MockFirebaseGetDatasourceImpl extends Mock implements FirebaseGetDatasourceImpl{}

void main() {

  final datasource = MockFirebaseGetDatasourceImpl();
  testWidgets('Must completes getBrands', (tester) async {
    when(() => datasource.getBrands()).thenAnswer((realInvocation) => Future.value(<BrandModel>[]));
    final result = datasource.getBrands();

    expect(result, completes);
  });

  testWidgets('Must completes getCars', (tester) async {
    when(() => datasource.getCars()).thenAnswer((realInvocation) => Future.value(<CarModel>[]));
    final result = datasource.getCars();

    expect(result, completes);
  });

  testWidgets('Must completes getCarsByBrand', (tester) async {
    when(() => datasource.getCarsByBrand(brandNameTest)).thenAnswer((realInvocation) => Future.value(<CarModel>[]));
    final result = datasource.getCarsByBrand(brandNameTest);

    expect(result, completes);
  });

  testWidgets('Must completes getCarsBySearch', (tester) async {
    when(() => datasource.getCarsBySearch(searchTest)).thenAnswer((realInvocation) => Future.value(<CarModel>[]));
    final result = datasource.getCarsBySearch(searchTest);

    expect(result, completes);
  });

  testWidgets('Must completes getCarByRef', (tester) async {
    when(() => datasource.getCarByRef(carModelRefTest)).thenAnswer((realInvocation) => Future.value(carModelTest));
    final result = datasource.getCarByRef(carModelRefTest);

    expect(result, completes);
  });

  testWidgets('Must completes getUserRentCars', (tester) async {
    when(() => datasource.getUserRentCars(carModelRefTest)).thenAnswer((realInvocation) => Future.value(<RentModel>[]));
    final result = datasource.getUserRentCars(carModelRefTest);

    expect(result, completes);
  });

}