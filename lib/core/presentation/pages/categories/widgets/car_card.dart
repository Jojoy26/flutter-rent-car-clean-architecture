import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';

import 'package:flutter_rent/core/presentation/pages/categories/widgets/shimmer_image_car.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_favorites_presenter.dart';
import 'package:get/get.dart';

class CarCard extends StatefulWidget {
  final int index;
  final void Function () onTap;
  final CarModel carModel;
  const CarCard({
    Key? key,
    required this.index,
    required this.onTap,
    required this.carModel,
  }) : super(key: key);

  @override
  _CarCardState createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {

  final GetxFavoritesPresenter favoritesPresenter = Get.put(Modular.get<GetxFavoritesPresenter>());
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Obx(() => 
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: (){
                      favoritesPresenter.toggleFavorite(widget.carModel.refDocument);
                    }, 
                    icon: favoritesPresenter.isFavorite(widget.carModel.refDocument) ?  Icon(Icons.bookmark, color: Color(0xFFDBB51A), size: 25,) : Icon(Icons.bookmark_border, color: Color(0xFFDBB51A), size: 25,)
                  )
                ),
              ),
              Hero(
                tag: "CAR${widget.index}", 
                child: Image.network(
                  widget.carModel.img, 
                  height: 100, 
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress){
                    if (loadingProgress == null) {
                      return child;
                    }
                    return ShimmerImageCar();
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 100,
                      child: Center(
                        child: Text("Failed on load image"),
                      ),
                    );
                  },
                ),
              ),
              Text(widget.carModel.carName.toUpperCase(), style: TextStyle(fontSize: 11),),
              Row(
                children: [
                  Text("EGP", style: TextStyle(color: Color(0xFFDBB51A), fontSize: 17, fontWeight: FontWeight.bold),),
                  SizedBox(width: 2,),
                  Text("${widget.carModel.price}/Day", style: TextStyle(fontSize: 17),),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star, color: Color(0xFFDBB51A), size: 13,
                        ),
                        
                        Text(widget.carModel.score.toString(), style: TextStyle(fontSize: 11),)
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}