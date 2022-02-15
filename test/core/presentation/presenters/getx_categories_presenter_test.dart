import 'package:dartz/dartz.dart';
import 'package:flutter_rent/core/domain/entities/brand_model.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/usecases/get_brands.dart';
import 'package:flutter_rent/core/domain/usecases/get_cars.dart';
import 'package:flutter_rent/core/domain/usecases/get_cars_by_brand.dart';
import 'package:flutter_rent/core/domain/usecases/get_cars_by_search.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_categories_presenter.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_favorites_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../commons/test_params.dart';


class MockGetCars extends Mock implements GetCars{}
class MockGetCarsByBrand extends Mock implements GetCarsByBrand{}
class MockGetBrands extends Mock implements GetBrands{}
class MockGetCarsBySearch extends Mock implements GetCarsBySearch{}
class MockGetxFavoritesPresenter extends Mock implements GetxFavoritesPresenter{}

void main() {
  final getCarsUsecase = MockGetCars();
  final getCarsByBrandUsecase = MockGetCarsByBrand();
  final getBrandsUsecase = MockGetBrands();
  final getCarsBySearchUsecase = MockGetCarsBySearch();
  final favoritesPresenter = MockGetxFavoritesPresenter();
  final presenter = GetxCategoriesPresenter(
    getBrandsUsecase: getBrandsUsecase, 
    getCarsByBrandUsecase: getCarsByBrandUsecase, 
    getCarsUsecase: getCarsUsecase, 
    getCarsBySearchUsecase: getCarsBySearchUsecase,
    favoritesPresenter: favoritesPresenter
  );

  testWidgets('Must call a getBrandsUsecase', (tester) async {
    when(() => getBrandsUsecase.call()).thenAnswer((invocation) => Future.value(Right(<BrandModel>[])));

    await presenter.callGetBrands();

    verify(() => getBrandsUsecase.call());
  });
  testWidgets('Must call a getCarsUsecase', (tester) async {
    when(() => getCarsUsecase.call()).thenAnswer((invocation) => Future.value(Right(<CarModel>[])));

    await presenter.callGetCars();

    verify(() => getCarsUsecase.call());
  });
  testWidgets('Must call a getCarsByBrandUsecase', (tester) async {
    when(() => getCarsByBrandUsecase.call(brandNameTest)).thenAnswer((invocation) => Future.value(Right(<CarModel>[])));

    await presenter.callGetCarsByBrand(brandNameTest, 1);

    verify(() => getCarsByBrandUsecase.call(brandNameTest));
  });

  testWidgets('Must call a getCarsBySearchUsecase', (tester) async {
    when(() => getCarsBySearchUsecase.call(searchTest)).thenAnswer((invocation) => Future.value(Right(<CarModel>[])));

    await presenter.callGetCarsBySearch(searchTest);

    verify(() => getCarsBySearchUsecase.call(searchTest));
  });
}