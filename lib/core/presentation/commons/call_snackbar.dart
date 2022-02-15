import 'package:flutter/material.dart';
import 'package:get/get.dart';

void callSnackBar(String title, String subtitle){
    Get.snackbar(
      title, 
      subtitle, 
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: EdgeInsets.only(bottom: 10, right: 10, left: 10)
    );
  }