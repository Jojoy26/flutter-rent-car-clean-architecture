import 'package:get/get.dart';

class GetxConfirmRentPresenter extends GetxController {

  void goToHome() {
    Get.offAndToNamed("/home");
  }

  void goBack() {
    Get.back();
  }

}