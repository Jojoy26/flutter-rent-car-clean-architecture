import 'package:flutter/material.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/presentation/presenters/mixins/verify_number.dart';

import 'package:flutter_rent/core/presentation/presenters/models/rent_car_model.dart';
import 'package:flutter_rent/core/presentation/widgets/custom_button.dart';
import 'package:flutter_rent/utils/months_list.dart';

class DynamicRentCarCard extends StatefulWidget {
  final void Function(CarModel carModel)? onPressButton;
  final String? buttonText;
  final RentCarModel rentCarModel;
  const DynamicRentCarCard({
    Key? key,
    this.onPressButton,
    this.buttonText,
    required this.rentCarModel,
  }) : super(key: key);

  @override
  _DynamicRentCarCardState createState() => _DynamicRentCarCardState();
}

class _DynamicRentCarCardState extends State<DynamicRentCarCard> with VerifyNumber {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFDDDDDD)),
          bottom: BorderSide(color: Color(0xFFDDDDDD)),
        )
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(widget.rentCarModel.carModel.img, width: 150,),
              Column(
                children: [
                  Text((widget.rentCarModel.carModel.carName.toUpperCase()), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                  SizedBox(height: 9,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.star, color: Color(0xFFDBB51A), size: 14,),
                      SizedBox(width: 2,),
                      Text(widget.rentCarModel.carModel.score.toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),),
                      Text("(${widget.rentCarModel.carModel.reviewsNumber} Reviews)", style: TextStyle(fontSize: 12, color: Colors.grey[500]),)
                    ],
                  ),
                  SizedBox(height: 7,),
                  Row(
                    children: [
                      Text("EGP ${widget.rentCarModel.carModel.price}", style: TextStyle(color: Color(0xFFDBB51A), fontWeight: FontWeight.bold, fontSize: 18),),
                      Text("/Day", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)
                    ],
                  ),
                  SizedBox(height: 9,),
                  Visibility(
                    visible: widget.onPressButton != null,
                    child: Container(
                      width: 130,
                      child: customButton("Book again", (){
                        widget.onPressButton!(widget.rentCarModel.carModel);
                      }),
                    )
                  ),
                  Visibility(
                    visible: widget.onPressButton == null,
                    child: Column(
                      children: [
                        Container(constraints: BoxConstraints(maxWidth: 150),child: Text("From ${widget.rentCarModel.rentModel.startDate.day} ${monthsList[widget.rentCarModel.rentModel.startDate.month]}. At ${widget.rentCarModel.rentModel.startDate.hour > 12 ? widget.rentCarModel.rentModel.startDate.hour - 12 : widget.rentCarModel.rentModel.startDate.hour}:${verifyNumber(widget.rentCarModel.rentModel.startDate.minute)} ${widget.rentCarModel.rentModel.startDate.hour > 12 ? "PM" : "AM"}GGGGggggGG", overflow: TextOverflow.ellipsis, softWrap: false, maxLines: 1,)),
                        Container(constraints: BoxConstraints(maxWidth: 150),child: Text("To ${widget.rentCarModel.rentModel.endDate.day} ${monthsList[widget.rentCarModel.rentModel.endDate.month]}. At ${widget.rentCarModel.rentModel.endDate.hour > 12 ? widget.rentCarModel.rentModel.endDate.hour - 12 : widget.rentCarModel.rentModel.endDate.hour}:${verifyNumber(widget.rentCarModel.rentModel.endDate.minute)} ${widget.rentCarModel.rentModel.endDate.hour > 12 ? "PM" : "AM"}", overflow: TextOverflow.ellipsis,)),
                      ],
                    )
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}