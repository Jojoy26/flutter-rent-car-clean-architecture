import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rent/core/presentation/pages/checkout/widgets/card_date.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_checkout_presenter.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_rent_car_presenter.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({ Key? key }) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  final GextCheckoutPresenter checkoutPresenter = Get.put(Modular.get<GextCheckoutPresenter>());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width-20,
        child: FloatingActionButton.extended(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        onPressed: (){
          checkoutPresenter.callRentCar();
        }, 
        label: Text("Confirm Rental", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
        backgroundColor: Color(0xFFDBB51A),
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 70),
          child: Column(
            children: [
              Container(
                color: Color(0xFFF9F3DB),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: () {
                            checkoutPresenter.goBack();
                          }, 
                          icon: Icon(Icons.arrow_back_ios_rounded)
                         ),
        
                        Text("Summary", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),),
        
                        Text("")
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 20, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(checkoutPresenter.rentCarPresenter.car!.carName.toUpperCase(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  SizedBox(width: 5,),
                                  Icon(Icons.star, color: Color(0xFFDBB51A), size: 14,),
                                  SizedBox(width: 2,),
                                  Text(checkoutPresenter.rentCarPresenter.car!.score.toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),),
                                  Text("(${checkoutPresenter.rentCarPresenter.car!.reviewsNumber} Reviews)", style: TextStyle(fontSize: 12, color: Colors.grey[500]),)
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text("EGP ${checkoutPresenter.rentCarPresenter.car!.price}", style: TextStyle(color: Color(0xFFDBB51A), fontWeight: FontWeight.bold, fontSize: 18),),
                                  Text("/Day", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)
                                ],
                              ),
                            ],
                          ),
                          Image.network(checkoutPresenter.rentCarPresenter.car!.img, width: 190,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Payment Method", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Text("Credit Card:", style: TextStyle(color: Color(0xFFDBB51A), fontWeight: FontWeight.bold, fontSize: 15),),
                            Text(" No. 5544 6565 6523 4589", style: TextStyle(fontSize: 15, color: Colors.grey),)
                          ],
                        ),
                        SizedBox(height: 20,),
                        Text("Rent Duration", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            CardDate(title: "Start", date: checkoutPresenter.rentCarPresenter.startDate,),
                            SizedBox(width: 10,),
                            CardDate(title: "End", date: checkoutPresenter.rentCarPresenter.endDate,)
                          ],
                        ),
                        SizedBox(height: 20,),
                        Text("Delivery Location", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Text("Pickup Location:", style: TextStyle(color: Color(0xFFDBB51A), fontWeight: FontWeight.bold, fontSize: 16),),
                            Expanded(child: Text(" ${checkoutPresenter.rentCarPresenter.car!.locationCar}", style: TextStyle(fontSize: 15, color: Colors.grey), overflow: TextOverflow.ellipsis, softWrap: false,))
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Text("Total Rental Price:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                            Text(" EGP ${checkoutPresenter.rentCarPresenter.totalPrice}", style: TextStyle(color: Color(0xFFDBB51A), fontWeight: FontWeight.bold, fontSize: 15),),
                          ],
                        ),
                        SizedBox(height: 30,)
                      ],
                    ),
                  )
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}