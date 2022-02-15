// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_car_details_presenter.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_favorites_presenter.dart';
import 'package:flutter_rent/utils/images_car_details_list.dart';
import 'package:get/get.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({ Key? key }) : super(key: key);

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {

  CarModel carModelParam = Get.arguments;
  final GetxFavoritesPresenter favoritesPresenter = Get.put(Modular.get<GetxFavoritesPresenter>());
  final GetxCarDetailsPresenter carDetailsPresenter = Get.put(Modular.get<GetxCarDetailsPresenter>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width-20,
        child: FloatingActionButton.extended(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        onPressed: (){
          carDetailsPresenter.goToPickRentDate(carModelParam);
        }, 
        label: Text("Request Rental", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
        backgroundColor: Color(0xFFDBB51A),
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 70),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top+7, bottom: 30),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/assets/images/background-car.jpeg"),
                  fit: BoxFit.cover
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                        constraints: BoxConstraints(),
                        onPressed: (){
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                      ),
                      Obx(() =>
                        IconButton(
                          padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                          constraints: BoxConstraints(),
                          onPressed: (){
                            favoritesPresenter.toggleFavorite(carModelParam.refDocument);
                          },
                          icon:favoritesPresenter.isFavorite(carModelParam.refDocument) ? Icon(Icons.bookmark, color: Colors.white) : Icon(Icons.bookmark_border_rounded, color: Colors.white)
                        ) 
                      )
                    ],
                  ), 
                  Image.network(
                  carModelParam.img, 
                  width: 250,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 250,
                      height: 150,
                      color: Colors.transparent,
                      child: Center(
                        child: Text("Failed on load imge car"),
                      ),
                    );
                  },
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5, color: Color(0xFFDDDDDD)
                  )
                )
              ),
              padding: EdgeInsets.fromLTRB(10, 20, 10, 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.multitrack_audio_sharp, color: Color(0xFFDBB51A), size: 27,),
                            SizedBox(width: 5,),
                            Text(carModelParam.carName.toUpperCase(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text("EGP ${carModelParam.price}", style: TextStyle(color: Color(0xFFDBB51A), fontWeight: FontWeight.bold, fontSize: 18),),
                            Text("/Day", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 9,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.person, color: Color(0xFFDBB51A), size: 17,),
                            Text("Rent by:", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),),
                            SizedBox(width: 3,),
                            Text(carModelParam.rentBy, style: TextStyle(color: Color(0xFFDBB51A), fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ), 
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Color(0xFFDBB51A), size: 14,),
                            SizedBox(width: 2,),
                            Text(carModelParam.score.toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),),
                            Text("(${carModelParam.reviewsNumber} Reviews)", style: TextStyle(fontSize: 12, color: Colors.grey[500]),)
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 9,),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Color(0xFFDBB51A), size: 16,),
                      SizedBox(width: 2,),
                      Text(carModelParam.locationCar, style: TextStyle(fontSize: 12, color: Colors.grey[600]),)
                    ],
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.5, color: Color(0xFFDDDDDD))
                )
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Specifications", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                  ),
                  SizedBox(
                    height: 200,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 15, mainAxisSpacing: 5, childAspectRatio: 1.4), 
                      itemCount: 6,
                      itemBuilder: (context, index){
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(carDetailsImagesList[index]["image"], height: carDetailsImagesList[index]["height"],),
                              SizedBox(height: 3,),
                              Text(carModelParam.specifications[index], style: TextStyle(fontWeight: FontWeight.w600),)
                            ]
                          )
                        );
                      }
                    ),
                  )
                ]
              )
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                carModelParam.description,
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        )
      )
    );
  }
}