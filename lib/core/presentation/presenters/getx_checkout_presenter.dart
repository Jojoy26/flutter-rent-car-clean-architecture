import 'package:get/get.dart';

import 'package:flutter_rent/core/presentation/presenters/getx_rent_car_presenter.dart';

class GextCheckoutPresenter extends GetxController {

  final GetxRentCarPresenter rentCarPresenter;
  GextCheckoutPresenter({
    required this.rentCarPresenter,
  });


  void goBack(){
    Get.back();
  }

  void callRentCar() {
    rentCarPresenter.callRentCar();
  }

}
