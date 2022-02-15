import 'package:flutter/material.dart';
import 'package:flutter_rent/core/presentation/pages/pickRentDate/pick_rent_date.dart';
import 'package:get/get.dart';

import 'core/presentation/pages/Home/home_navigation.dart';
import 'core/presentation/pages/carDetails/car_details.dart';
import 'core/presentation/pages/checkout/checkout_page.dart';
import 'core/presentation/pages/confirmRent/confirm_rent_page.dart';
import 'core/presentation/pages/login/login_page.dart';
import 'core/presentation/pages/singup/singup_page.dart';
import 'core/presentation/pages/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    theme: ThemeData(
      colorScheme: ThemeData().colorScheme.copyWith(
        primary: Color(0xFFDBB51A),
      ),
    ),
    debugShowCheckedModeBanner: false,
    home: SplashPage(),
    getPages: [
      GetPage(name: "/splash", page: () => SplashPage(),),
      GetPage(name: "/login", page: () => LoginPage(), transition: Transition.fadeIn, transitionDuration: Duration(milliseconds: 1500)), 
      GetPage(name: "/singup", page: () => SingUpPage() ),
      GetPage(name: "/home", page: () => HomeNavigation(), transition: Transition.fadeIn, transitionDuration: Duration(milliseconds: 1500)),
      GetPage(name: "/cardetails", page: () => CarDetails()),
      GetPage(name: "/pickdate", page: () => PickRentDate()),
      GetPage(name: "/checkout", page: () => CheckoutPage()),
      GetPage(name: "/confirmrent", page: () => ConfirmRentPage())
    ],
  );
  }
}