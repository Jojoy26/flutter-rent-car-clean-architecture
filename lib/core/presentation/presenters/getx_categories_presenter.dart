import 'package:get/get.dart';

import 'package:flutter_rent/core/domain/entities/brand_model.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/errors/getBrands/erros.dart';
import 'package:flutter_rent/core/domain/errors/getCars/erros.dart';
import 'package:flutter_rent/core/domain/errors/getCarsByBrand/errors.dart';
import 'package:flutter_rent/core/domain/errors/getCarsBySearch/erros.dart';
import 'package:flutter_rent/core/domain/usecases/get_brands.dart';
import 'package:flutter_rent/core/domain/usecases/get_cars.dart';
import 'package:flutter_rent/core/domain/usecases/get_cars_by_brand.dart';
import 'package:flutter_rent/core/domain/usecases/get_cars_by_search.dart';
import 'package:flutter_rent/core/presentation/commons/call_snackbar.dart';
import 'package:flutter_rent/core/presentation/presenters/enums/status_categories_page.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_favorites_presenter.dart';

class GetxCategoriesPresenter extends GetxController {

  final GetxFavoritesPresenter favoritesPresenter;

  final GetBrands getBrandsUsecase;
  final GetCars getCarsUsecase;
  final GetCarsByBrand getCarsByBrandUsecase;
  final GetCarsBySearch getCarsBySearchUsecase;
  GetxCategoriesPresenter({
    required this.favoritesPresenter,
    required this.getBrandsUsecase,
    required this.getCarsUsecase,
    required this.getCarsByBrandUsecase,
    required this.getCarsBySearchUsecase,
  });

  Rx<int> brandSelectIndex = (1*-1).obs;

  RxList<BrandModel> brandsList = <BrandModel>[].obs;
  RxList<CarModel> carsList = <CarModel>[].obs;

  Rx<StatusGetBrands> statusGetBrands = StatusGetBrands.loading.obs;
  Rx<StatusGetCars> statusGetCars = StatusGetCars.loading.obs;

  Future callGetBrands() async {
    statusGetBrands.value = StatusGetBrands.loading;
    final result = await getBrandsUsecase.call();
    result.fold(
      (l) {
        print(l);
        if(l is NoInternetConnectionGetBrands){
          statusGetBrands.value = StatusGetBrands.noConnectionInternet;
        } else {
          statusGetBrands.value = StatusGetBrands.error;
        }
      }, 
      (r) {
        statusGetBrands.value = StatusGetBrands.completed;
        brandsList.value = r;
      }
    );
    
  }

  Future callGetCars() async {
    statusGetCars.value =  StatusGetCars.loading;
    final result = await getCarsUsecase.call();
    result.fold(
      (l) {
        if(l is NoInternetConnectionGetCars){
          statusGetCars.value =  StatusGetCars.noConnectionInternet;
        } else {
          statusGetCars.value = StatusGetCars.error;
        }
      }, 
      (r) {
        statusGetCars.value = StatusGetCars.completed;
        carsList.value = r;
      }
    );
  }

  Future callGetCarsByBrand(String brandName, int index) async {
    brandSelectIndex.value = index;
    final result = await getCarsByBrandUsecase.call(brandName);
    result.fold(
      (l) {
        if(l is NoInternetConnectionGetCarsByBrand){
          callSnackBar("Error", "No Internet Connection");
        } else {
          callSnackBar("Error", "Failure on load cars");
        }
      }, 
      (r) {
        carsList.value = r;
      }
    );
  }

  Future callGetCarsBySearch(String search) async {
    if(search.trim().isNotEmpty){
      final result = await getCarsBySearchUsecase.call(search.trim());
      result.fold(
        (l) {
          if(l is NoInternetConnectionGetCarsBySearch){
            callSnackBar("Error", "No Internet Connection");
          } else {
            callSnackBar("Error", "Failure on load cars");
          }
        }, 
        (r) {
          brandSelectIndex.value = -1;
          carsList.value = r;
        }
      );
    }
  }

  Future callGetFavorites () async {
    favoritesPresenter.callGetFavorites();
  }

  Future getAll() async {
    brandSelectIndex.value = -1;
    await callGetFavorites();
    callGetBrands();
    callGetCars();
  }

  void goToCarDetails (CarModel car) {
    Get.toNamed("cardetails", arguments: car);
  }
}
