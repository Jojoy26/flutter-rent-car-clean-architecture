import 'package:get/get.dart';

import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/errors/getCarByRef/erros.dart';
import 'package:flutter_rent/core/domain/usecases/get_car_by_ref.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_favorites_presenter.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_rent_car_presenter.dart';

import 'enums/status_saved_page.dart';

class GetxSavedPresenter extends GetxController {

  final GetxFavoritesPresenter favoritesPresenter;
  final GetCarByRef getCarByRefUsecase;
  final GetxRentCarPresenter rentCarPresenter;

  GetxSavedPresenter({
    required this.favoritesPresenter,
    required this.getCarByRefUsecase,
    required this.rentCarPresenter,
  });

  RxList<CarModel> favoritesCarList = <CarModel>[].obs;
  RxList<CarModel> filteredFavoritesCarList = <CarModel>[].obs;
  Rx<StatusGetFavoritesCar> statusGetFavoritesCar = StatusGetFavoritesCar.loading.obs;

  Future loadFavoritesCars() async {

    List<CarModel> list = [];

    for(var item in favoritesPresenter.favoritesList){
      final result = await getCarByRefUsecase.call(item);

      result.fold(
        (l) {
          if(l is NoInternetConnectionGetCarByRef){
            statusGetFavoritesCar.value = StatusGetFavoritesCar.noInternetConnection;
          } else {
            statusGetFavoritesCar.value = StatusGetFavoritesCar.error;
          }
        }, 
        (r) {
          list.add(
            r
          );
        }
      );
    }
    
    favoritesCarList.value = list;
    filteredFavoritesCarList.value = list;
    if(statusGetFavoritesCar.value != StatusGetFavoritesCar.error && statusGetFavoritesCar.value != StatusGetFavoritesCar.noInternetConnection){
      statusGetFavoritesCar.value = StatusGetFavoritesCar.completed;
    }
  }

  void searchList(String search) {
    if(search == "") {
      filteredFavoritesCarList.value = favoritesCarList;
      return;
    }
    var copyFavoritesCarList = [...favoritesCarList].where((element) => element.carName.contains(search)).toList();

    filteredFavoritesCarList.value = copyFavoritesCarList;
  }

  Future removeFavoriteCarOfList (CarModel car) async {
    favoritesCarList.removeWhere((element) => element.refDocument == car.refDocument);
    favoritesPresenter.toggleFavorite(car.refDocument);
  }


  void goToPickRentDate(CarModel carModel) {
    rentCarPresenter.setCar(carModel);
    Get.toNamed("/pickdate");
  }
}
