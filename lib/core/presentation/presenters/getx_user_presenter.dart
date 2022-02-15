
import 'package:flutter_rent/core/domain/usecases/singin_by_google.dart';
import 'package:flutter_rent/core/domain/usecases/singup_by_email.dart';
import 'package:get/get.dart';

import 'package:flutter_rent/core/domain/entities/logged_user.dart';
import 'package:flutter_rent/core/domain/errors/userErros/errors.dart';
import 'package:flutter_rent/core/domain/usecases/login_by_email.dart';
import 'package:flutter_rent/core/presentation/commons/call_snackbar.dart';

class GetxUserPresenter extends GetxController {
  
  final LoginByEmail loginByEmailUsecase;
  final SingInByGoogle singInByGoogleUsecase;
  final SingUpByEmail singUpByEmailUsecase;
  
  GetxUserPresenter({
    required this.loginByEmailUsecase,
    required this.singInByGoogleUsecase,
    required this.singUpByEmailUsecase
  });
  
  Rx<LoggedUser> loggedUser = LoggedUser(email: "", uid: "", name: "", phoneNumber: "").obs;

  void setUser(LoggedUser user){
    loggedUser.value = user;
  }

  void onSucessSingIn (LoggedUser user) {
    setUser(user);
    try {
      Get.offAndToNamed("/home");
    } catch (e){
    }
  }

  Future<void> callLoginByEmail(CredentialParamsLogin params) async {
    final result = await loginByEmailUsecase.call(params);
    result.fold(
      (l) {
        if(l is InvalidEmail){
          callSnackBar("Error", "Invalid email");
        } else if(l is UserNotFound){
          callSnackBar("Error", "User not found");
        } else if (l is WrongPassword){
          callSnackBar("Error", "Wrong password");
        } else if(l is NoInternetConnection){
          callSnackBar("Error", "Wrong password");
        } else {
          callSnackBar("Error", "Login failed try again later");
        }
      },
      (r){
        onSucessSingIn(r);
      },
    );
  }

  Future<void> callSingInByGoogle () async {
    final result = await singInByGoogleUsecase.call();
    result.fold(
      (l) {
        print(l);
        if(l is UserRejectAuth){
          callSnackBar("Error", "User reject authentication");
        } else if(l is UserNotFound){
          callSnackBar("Error", "User not found");
        } else if (l is NoInternetConnection) {
          callSnackBar("Error", "No internet connection");
        } else {
          callSnackBar("Error", "Failed singIn with google");
        }
      }, 
      (r) {
        onSucessSingIn(r); 
      }
    );
  }

  Future<void> callSingUpByEmail (CredentialParamsSingUp params) async{
    final result = await singUpByEmailUsecase.call(params);
    result.fold(
      (l) {
        print(l);
        if(l is EmailAlreadyUse){
          callSnackBar("Error", "Email already use");
        } else if(l is WeakPassword){
          callSnackBar("Error", "Password so weak");
        } else if(l is InvalidEmail){
          callSnackBar("Error", "Invalid email");
        } else if(l is NoInternetConnection){
          callSnackBar("Error", "No internet connection");
        } else {
          callSnackBar("Error", "Failed to create account try again later");
        }
      }, 
      (r) {
        onSucessSingIn(r);
      }
    );
  }
  
}
