import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_saved_presenter.dart';
import 'package:flutter_rent/core/presentation/widgets/custom_button.dart';

class SavedFavoriteCarCard extends StatefulWidget {

  final CarModel carModel;
  final void Function(CarModel carModel) onPressedBookMarker;
  final void Function(CarModel carModel) onPressButton;

  const SavedFavoriteCarCard({
    Key? key,
    required this.carModel,
    required this.onPressedBookMarker,
    required this.onPressButton,
  }) : super(key: key);

  @override
  _SavedFavoriteCarCardState createState() => _SavedFavoriteCarCardState();
}

class _SavedFavoriteCarCardState extends State<SavedFavoriteCarCard> {

  final GetxSavedPresenter savedPresenter = Modular.get<GetxSavedPresenter>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFDDDDDD)),
          bottom: BorderSide(color: Color(0xFFDDDDDD)),
        )
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Icon(Icons.bookmark, color: Color(0xFFDBB51A),),
              onPressed: (){
                widget.onPressedBookMarker(widget.carModel);
              },
          ),
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(widget.carModel.img, width: 150,),
              Column(
                children: [
                  Text((widget.carModel.carName.toUpperCase()), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                  SizedBox(height: 9,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.star, color: Color(0xFFDBB51A), size: 14,),
                      SizedBox(width: 2,),
                      Text(widget.carModel.score.toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),),
                      Text("(${widget.carModel.reviewsNumber} Reviews)", style: TextStyle(fontSize: 12, color: Colors.grey[500]),)
                    ],
                  ),
                  SizedBox(height: 7,),
                  Row(
                    children: [
                      Text("EGP ${widget.carModel.price}", style: TextStyle(color: Color(0xFFDBB51A), fontWeight: FontWeight.bold, fontSize: 18),),
                      Text("/Day", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)
                    ],
                  ),
                  SizedBox(height: 9,),
                  Container(
                    width: 130,
                    child: customButton("Book", (){
                      widget.onPressButton(widget.carModel);
                    }),
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