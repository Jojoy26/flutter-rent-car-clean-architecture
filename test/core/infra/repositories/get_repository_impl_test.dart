import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/entities/brand_model.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/entities/rent_model.dart';
import 'package:flutter_rent/core/domain/errors/getBrands/erros.dart';
import 'package:flutter_rent/core/domain/errors/getCarByRef/erros.dart';
import 'package:flutter_rent/core/domain/errors/getCars/erros.dart';
import 'package:flutter_rent/core/domain/errors/getCarsByBrand/errors.dart';
import 'package:flutter_rent/core/domain/errors/getCarsBySearch/erros.dart';
import 'package:flutter_rent/core/domain/errors/getUserRentCars/erros.dart';
import 'package:flutter_rent/core/infra/datasources/get_datasource.dart';
import 'package:flutter_rent/core/infra/repositories/get_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/network_info_mock.dart';
import '../../../commons/test_params.dart';

class MockGetDatasource extends Mock implements GetDatasource {}


void main() {

  final datasource = MockGetDatasource();
  final netInfo = MockNetworkInfo();
  final repository = GetRepositoryImpl(datasource: datasource, netInfo: netInfo);

  // Get Brands Test
  group("GetBrandsTest", (){
    testWidgets('Must return a brandModel List', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.getBrands()).thenAnswer((realInvocation) => Future.value(<BrandModel>[]));

      final result = await repository.getBrands();

      expect(result.fold(id, id), isA<List<BrandModel>>());
    });

    testWidgets('Must throw a error if no connection', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(false));
      when(() => datasource.getBrands()).thenAnswer((realInvocation) => Future.value(<BrandModel>[]));

      final result = await repository.getBrands();

      expect(result.fold(id, id), isA<NoInternetConnectionGetBrands>());
    });

    testWidgets('Must throw a error FailureGetBrands', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.getBrands()).thenThrow(Exception());

      final result = await repository.getBrands();

      expect(result.fold(id, id), isA<FailureGetBrands>());
    });
  });

  // Get Cars Test

  group("GetCarsTest", (){
    testWidgets('Must return a carModel List', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.getCars()).thenAnswer((realInvocation) => Future.value(<CarModel>[]));

      final result = await repository.getCars();

      expect(result.fold(id, id), isA<List<CarModel>>());
    });

    testWidgets('Must throw a error if no connection', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(false));
      when(() => datasource.getCars()).thenAnswer((realInvocation) => Future.value(<CarModel>[]));

      final result = await repository.getCars();

      expect(result.fold(id, id), isA<NoInternetConnectionGetCars>());
    });

    testWidgets('Must throw a error GetCarsException', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.getCars()).thenThrow(Exception());

      final result = await repository.getCars();

      expect(result.fold(id, id), isA<FailureGetCars>());
    });
  });

  // Get Cars By Brand Test

  group("GetCarsByBrandTest", () {
    testWidgets('Must return a list carModel by brand name ', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.getCarsByBrand(brandNameTest)).thenAnswer((realInvocation) => Future.value(<CarModel>[]));

      final result = await repository.getCarsByBrand(brandNameTest);

      expect(result.fold(id, id), isA<List<CarModel>>());
    });

    testWidgets('Must throw a error if no connection', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(false));
      when(() => datasource.getCarsByBrand(brandNameTest)).thenAnswer((realInvocation) => Future.value(<CarModel>[]));

      final result = await repository.getCarsByBrand(brandNameTest);

      expect(result.fold(id, id), isA<NoInternetConnectionGetCarsByBrand>());
    });

    testWidgets('Must throw a error FailureGetCarsByBrand', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.getCarsByBrand(brandNameTest)).thenThrow(Exception());

      final result = await repository.getCarsByBrand(brandNameTest);

      expect(result.fold(id, id), isA<FailureGetCarsByBrand>());
    });
  });

  group("GetCarsBySearchTest", () {
    testWidgets('Must return a list carModel', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.getCarsBySearch(searchTest)).thenAnswer((realInvocation) => Future.value(<CarModel>[]));

      final result = await repository.getCarsBySearch(searchTest);

      expect(result.fold(id, id), isA<List<CarModel>>());
    });

    testWidgets('Must throw a error if no connection', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(false));
      when(() => datasource.getCarsBySearch(searchTest)).thenAnswer((realInvocation) => Future.value(<CarModel>[]));

      final result = await repository.getCarsBySearch(searchTest);

      expect(result.fold(id, id), isA<NoInternetConnectionGetCarsBySearch>());
    });

    testWidgets('Must throw a error FailureGetCarsBySearch', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.getCarsBySearch(searchTest)).thenThrow(Exception());

      final result = await repository.getCarsBySearch(searchTest);

      expect(result.fold(id, id), isA<FailureGetCarsBySearch>());
    });
  });
  group("GetCarsByRefTest", () {
    testWidgets('Must return a list carModel ', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.getCarByRef(carModelRefTest)).thenAnswer((realInvocation) => Future.value(carModelTest));

      final result = await repository.getCarByRef(carModelRefTest);

      expect(result.fold(id, id), isA<CarModel>());
    });

    testWidgets('Must throw a error if no connection', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(false));
      when(() => datasource.getCarByRef(carModelRefTest)).thenAnswer((realInvocation) => Future.value(carModelTest));

      final result = await repository.getCarByRef(carModelRefTest);

      expect(result.fold(id, id), isA<NoInternetConnectionGetCarByRef>());
    });

    testWidgets('Must throw a error FailureGetCarByRef', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.getCarByRef(carModelRefTest)).thenThrow(Exception());

      final result = await repository.getCarByRef(searchTest);

      expect(result.fold(id, id), isA<FailureGetCarByRef>());
    });
  });

  group("GetUserRentCars", () {
    testWidgets('Must return a list RentModel', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.getUserRentCars(userUidParamsTest)).thenAnswer((realInvocation) => Future.value(<RentModel>[]));

      final result = await repository.getUserRentCars(userUidParamsTest);

      expect(result.fold(id, id), isA<List<RentModel>>());
    });

    testWidgets('Must throw a error if no connection', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(false));
      when(() => datasource.getUserRentCars(userUidParamsTest)).thenAnswer((realInvocation) => Future.value(<RentModel>[]));

      final result = await repository.getUserRentCars(userUidParamsTest);

      expect(result.fold(id, id), isA<NoInternetConnectionGetUserRentCars>());
    });

    testWidgets('Must throw a error FailureGetUserRentCars', (tester) async {
      when(() => netInfo.isConnected()).thenAnswer((realInvocation) => Future.value(true));
      when(() => datasource.getUserRentCars(userUidParamsTest)).thenThrow(Exception());

      final result = await repository.getUserRentCars(userUidParamsTest);

      expect(result.fold(id, id), isA<FailureGetUserRentCars>());
    });
  });
}