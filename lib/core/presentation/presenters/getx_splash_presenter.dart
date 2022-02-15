import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:flutter_rent/core/domain/usecases/get_current_user.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_user_presenter.dart';

class GetxSplashPresenter extends GetxController {

  final GetCurrentUser getCurrentUserUsecase;
  final GetxUserPresenter userPresenter;
  GetxSplashPresenter({
    required this.getCurrentUserUsecase,
    required this.userPresenter,
  });

  Future callGetCurrentUser () async {
    await Future.delayed(Duration(seconds: 2));
    final result = await getCurrentUserUsecase.call();
    result.fold(
      (l) {
        Get.offAndToNamed("/login");
      }, 
      (r) {
        userPresenter.setUser(r);
        try {
          Get.offAndToNamed("/home");
        } catch(e){

        }
      }
    );
  }

}
