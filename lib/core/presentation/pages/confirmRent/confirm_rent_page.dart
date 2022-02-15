import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_confirm_rent_presenter.dart';
import 'package:flutter_rent/core/presentation/widgets/custom_button.dart';
import 'package:get/get.dart';

class ConfirmRentPage extends StatefulWidget {
  const ConfirmRentPage({ Key? key }) : super(key: key);

  @override
  _ConfirmRentPageState createState() => _ConfirmRentPageState();
}

class _ConfirmRentPageState extends State<ConfirmRentPage> {

  final GetxConfirmRentPresenter confirmRentPresenter = Get.put(GetxConfirmRentPresenter());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFFF9F3DB),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: (){
                      confirmRentPresenter.goBack();
                    }, 
                    icon: Icon(Icons.close, color: Colors.black,)
                  ),
                ),
              ),
              Icon(Icons.check_circle_outline_rounded, color: Color(0xFFDBB51A), size: 300,),
              Align(
                alignment: Alignment.center,
                child: Text("Congratulations", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.center,
                child: Text("Car has been rented successfully!", style: TextStyle(fontSize: 18),),
              ),
              SizedBox(height: 25,),
              customButton("Back to Home", (){
                confirmRentPresenter.goToHome();
              })
            ],
          ),
        ),
      ),
    );
  }
}