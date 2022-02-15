import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:get/get.dart';

import 'package:flutter_rent/core/presentation/presenters/getx_rent_car_presenter.dart';

class GetxCarDetailsPresenter extends GetxController {

  final GetxRentCarPresenter rentCarPresenter;
  GetxCarDetailsPresenter({
    required this.rentCarPresenter,
  });

  void setRefCar(CarModel car){
    rentCarPresenter.setCar(car);
  }

  void goToPickRentDate(CarModel carModel) {
    setRefCar(carModel);
    Get.toNamed("/pickdate");
  }

}
