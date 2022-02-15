import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:flutter_rent/core/presentation/presenters/getx_rent_car_presenter.dart';
import 'package:flutter_rent/utils/months_list.dart';

import 'mixins/verify_number.dart';

class GetxPickRentDatePresenter extends GetxController with VerifyNumber {

  final GetxRentCarPresenter rentCarPresenter;

  var fromDate = "${monthsList[DateTime.now().month]} ${DateTime.now().day}".obs;
  var toDate = "${monthsList[DateTime.now().month]} ${DateTime.now().day}".obs;
  var amOrpm = 0.obs;
  var messageErrorTime = "".obs;
  var messageErrorDate = "".obs;

  TextEditingController controllerHour = TextEditingController();

  GetxPickRentDatePresenter({
    required this.rentCarPresenter
  }
  ) {
    controllerHour.text = getCurrentDate();
  }


  var startDate = DateTime.now();
  var endDate = DateTime.now();

  void onSelectionChanged (DateRangePickerSelectionChangedArgs args) {
    startDate = args.value.startDate;
    fromDate.value = "${monthsList[args.value.startDate.month]} ${args.value.startDate.day.toString()}";
    if(args.value.endDate != null){
      endDate = args.value.endDate;
      toDate.value = "${monthsList[args.value.endDate.month]} ${args.value.endDate.day.toString()}";
    } else {
      endDate = args.value.startDate;
      toDate.value = fromDate.value;
    }
  }


  void changeSelectAmOrPm (int num){
    amOrpm.value = num;
  }

  String getCurrentDate (){
    DateTime date = DateTime.now();
    
    late var hour;
    late var minute;
    if(date.hour < 9){
      hour = "0${date.hour}";
    } else {
      hour = "${date.hour}";
    }
    if(date.minute < 9){
      minute = "0${date.minute}";
    } else {
      minute = "${date.minute}";
    }
    var intTime = int.tryParse("${hour}${minute}");
    if(intTime! > 1159){
      hour = "00";
      minute = "00";
    }
    return "${hour}:${minute}";
  }
  

  DateTime convertDate (DateTime date) {

    var year = date.year;
    var day = date.day;
    var month = date.month;
    var hour = controllerHour.text.substring(0, 2);
    var minutes = controllerHour.text.substring(3, 5);

    if(amOrpm == 1){
      var hourDouble = 0.0;
      if(double.parse(hour) < 12){
        hourDouble = double.parse(hour) + 12;
      }
      hour = hourDouble.toStringAsFixed(0);

    }
    print("hour: ${hour}");

    return DateTime.parse("${year}-${verifyNumber(month)}-${verifyNumber(day)} ${verifyNumber(int.parse(hour))}:${minutes}:00");
  }

  void goToCheckout() {
    if(messageErrorDate.value != "" || messageErrorTime.value != "") return;
    var dateStartConvert = convertDate(startDate);
    var dateEndConvert = convertDate(endDate);
    rentCarPresenter.setDates(dateStartConvert, dateEndConvert);
    Get.toNamed("/checkout");
  }

  void validateFields(){
    if(controllerHour.text != "" && controllerHour.text.length == 5){
      var replacedValue = controllerHour.text.replaceAll(":", "");
      try {
        int? number = int.tryParse(replacedValue);
        if(number! > 1159){
          messageErrorTime.value = "Times must be less than 11:59";
        } else {
          messageErrorTime.value = "";
        } 
      } catch(e){
        messageErrorTime.value = "Type a valid time";
      }
    } else {
      messageErrorTime.value = "Type a valid time";
    }
    if(fromDate == toDate){
      messageErrorDate.value = "Select different days";
    } else {
      messageErrorDate.value = "";
    }
  }

}
