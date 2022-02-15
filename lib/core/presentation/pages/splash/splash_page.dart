import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_splash_presenter.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetxSplashPresenter presenter = Get.put(Modular.get<GetxSplashPresenter>());
    presenter.callGetCurrentUser();

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xFFB49B2D),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset("lib/assets/images/sedan-car.png", color: Colors.white, fit: BoxFit.contain,),
            ),
            Text("Carento", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white,))
          ],
        )
      ),
    );
  }
}