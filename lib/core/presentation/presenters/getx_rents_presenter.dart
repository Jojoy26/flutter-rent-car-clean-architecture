import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_rent_car_presenter.dart';
import 'package:get/get.dart';

import 'package:flutter_rent/core/domain/entities/rent_model.dart';
import 'package:flutter_rent/core/domain/errors/getCarByRef/erros.dart';
import 'package:flutter_rent/core/domain/errors/getUserRentCars/erros.dart';
import 'package:flutter_rent/core/domain/usecases/get_car_by_ref.dart';
import 'package:flutter_rent/core/domain/usecases/get_user_rent_cars.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_user_presenter.dart';
import 'package:flutter_rent/core/presentation/presenters/models/rent_car_model.dart';

import 'enums/status_rents_page.dart';

class GetxRentsPresenter extends GetxController {

  final GetUserRentCars getUserRentCarsUsecase;
  final GetCarByRef getCarByRefUsecase;
  final GetxUserPresenter userPresenter;
  final GetxRentCarPresenter rentCarPresenter;
  GetxRentsPresenter({
    required this.getUserRentCarsUsecase,
    required this.getCarByRefUsecase,
    required this.userPresenter,
    required this.rentCarPresenter,
  });

  RxList<RentCarModel> rentCarModelList = <RentCarModel>[].obs;
  RxList<RentCarModel> filteredRentCarModelList = <RentCarModel>[].obs;
  RxList<RentModel> rentModelList = <RentModel>[].obs;
  Rx<StatusGetUserRentCars> statusGetUserRentCars = StatusGetUserRentCars.loading.obs;
  RxInt selectedItem = 0.obs;


  Future callGetUserRentCars() async {
    final result = await getUserRentCarsUsecase.call(userPresenter.loggedUser.value.uid);

    result.fold(
      (l) {
        if(l is NoInternetConnectionGetUserRentCars){
          statusGetUserRentCars.value = StatusGetUserRentCars.noInternetConnection;
        } else {
          statusGetUserRentCars.value = StatusGetUserRentCars.error;
        }
      }, 
      (r) {
        rentModelList.value = r;
      }
    );
  }

  Future callGetCarByRef() async {
    statusGetUserRentCars.value = StatusGetUserRentCars.loading;
    List<RentCarModel> list = [];

    for(var item in rentModelList){
      final result = await getCarByRefUsecase.call(item.refDocumentCar);

      result.fold(
        (l) {
          if(l is NoInternetConnectionGetCarByRef){
            statusGetUserRentCars.value = StatusGetUserRentCars.noInternetConnection;
          } else {
            statusGetUserRentCars.value = StatusGetUserRentCars.error;
          }
        }, 
        (r) {
          list.add(
            RentCarModel(rentModel: item, carModel: r)
          );
        }
      );
    }
    
    rentCarModelList.value = list;
    if(statusGetUserRentCars.value != StatusGetUserRentCars.error && statusGetUserRentCars.value != StatusGetUserRentCars.noInternetConnection){
      statusGetUserRentCars.value = StatusGetUserRentCars.completed;
    }
    
  }

  Future getAll() async {
    await callGetUserRentCars();
    if(statusGetUserRentCars.value != StatusGetUserRentCars.error && statusGetUserRentCars.value != StatusGetUserRentCars.noInternetConnection) await callGetCarByRef();
    if(statusGetUserRentCars.value == StatusGetUserRentCars.completed) setFilteredList();
  }

  void setFilteredList() {
    if(selectedItem.value == 0){
      List<RentCarModel> list = <RentCarModel>[];
      for(var item in rentCarModelList){
        
        if(item.rentModel.endDate.compareTo(DateTime.now()) < 0){
          list.add(item);
        }
      }
      filteredRentCarModelList.value = list;
    } else {
      List<RentCarModel> list = <RentCarModel>[];
      for(var item in rentCarModelList){
        
        if(item.rentModel.endDate.compareTo(DateTime.now()) > 0){
          list.add(item);
        }
      }
      filteredRentCarModelList.value = list;
    }
  }

  void setSelectedItem(int number){
    selectedItem.value = number;
    setFilteredList();
  }

  void goToPickRentDate(CarModel carModel) {
    rentCarPresenter.setCar(carModel);
    Get.toNamed("/pickdate");
  }

  void searchList (String search) {
    setFilteredList();
    var copyFilteredRentCarModelList = [...filteredRentCarModelList].where((element) => element.carModel.carName.contains(search)).toList();

  
    print(copyFilteredRentCarModelList);

    filteredRentCarModelList.value = copyFilteredRentCarModelList;
  }

}
