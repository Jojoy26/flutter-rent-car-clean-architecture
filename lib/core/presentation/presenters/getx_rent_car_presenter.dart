import 'package:flutter_rent/core/domain/errors/rentCarException/errors.dart';
import 'package:flutter_rent/core/presentation/commons/call_snackbar.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_user_presenter.dart';
import 'package:get/get.dart';

import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/domain/usecases/rent_car.dart';

import 'mixins/verify_number.dart';

class GetxRentCarPresenter extends GetxController with VerifyNumber {

  final RentCar rentCarUsecase;
  final GetxUserPresenter userPresenter;
  
  GetxRentCarPresenter({
    required this.rentCarUsecase,
    required this.userPresenter,
  });

  CarModel? car;
  int price = 0;
  int totalPrice = 0;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  void setCar(CarModel carParam){
    car = carParam;
    price = carParam.price;
  }

  void setTotalPrice(){
    var days = 0;
    var startDateCopy = startDate;
    var endDateCopy = endDate;
    if(endDate.month - startDate.month == 0){
      days = endDate.day - startDate.day;
    } else {

      while(true){
        final formatedDate = convertDate(startDateCopy);
        startDateCopy = formatedDate;
        days+=1;
        if(formatedDate == endDate) break;
      }
    }
    totalPrice = price * days;
  }

  DateTime convertDate(DateTime date) {
    var year = date.year;
    var day = date.day;
    day+=1;
    var month = verifyNumber(date.month);
    var minutes = verifyNumber(date.minute);
    var hour = verifyNumber(date.hour);
    
    return DateTime.parse("${year}-${month}-${verifyNumber(day)} ${hour}:${minutes}:00");
  }


  void setDates (DateTime startDateParam, DateTime endDateParam){
    startDate = startDateParam;
    endDate = endDateParam;
    print(startDate.hour);
    setTotalPrice();
  }

  Future callRentCar() async {
    RentCarParams params = RentCarParams(
      startDate: startDate, 
      endDate: endDate, 
      userUid: userPresenter.loggedUser.value.uid,
      refDocumentCar: car!.refDocument
    );
    final result = await rentCarUsecase.call(params);

    result.fold(
    (l) {
      if(l is NoInternetConnectionRentCar){
        callSnackBar("Error", "No internet connection");
      } else {
        callSnackBar("Error", "Failed on rent a car");
      }
      
    }, 
    (r) {
      Get.toNamed("/confirmrent");
    });
    
  }

}
