import 'package:flutter_rent/core/presentation/presenters/getx_user_presenter.dart';
import 'package:get/get.dart';


import 'package:flutter_rent/core/domain/usecases/login_by_email.dart';


class GetxLoginPresenter extends GetxController {

  final GetxUserPresenter userPresenter;
  GetxLoginPresenter({
    required this.userPresenter,
  });

  void goToSingUp () {
    Get.toNamed("/singup");
  }

  Future loginByEmail (CredentialParamsLogin params) async{
    userPresenter.callLoginByEmail(params);
  }

  Future singInByGoogle () async {
    userPresenter.callSingInByGoogle();
  }
}
