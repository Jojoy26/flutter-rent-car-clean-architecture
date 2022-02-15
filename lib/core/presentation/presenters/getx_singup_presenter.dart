import 'package:flutter_rent/core/domain/errors/userErros/errors.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_user_presenter.dart';
import 'package:get/get.dart';


import 'package:flutter_rent/core/domain/usecases/singin_by_google.dart';
import 'package:flutter_rent/core/domain/usecases/singup_by_email.dart';
import 'package:flutter_rent/core/presentation/commons/call_snackbar.dart';


class GetxSingUpPresenter extends GetxController {

  final GetxUserPresenter userPresenter;
  
  GetxSingUpPresenter({
    required this.userPresenter,
  });

  Future singUpByEmail (CredentialParamsSingUp params) async{
    userPresenter.callSingUpByEmail(params);
  }

  Future singInByGoogle () async {
    userPresenter.callSingInByGoogle();
  }

  void goBack () {
    Get.back();
  }

}
