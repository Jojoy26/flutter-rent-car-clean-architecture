import 'package:flutter/material.dart';

import 'package:flutter_rent/core/domain/entities/brand_model.dart';
import 'package:flutter_rent/core/presentation/pages/categories/widgets/shimmer_image_brand.dart';

class BrandCard extends StatefulWidget {
  final BrandModel brand;
  final void Function () onTap;
  final int index;
  final int currentSelectIndex;
  const BrandCard({
    Key? key,
    required this.brand,
    required this.onTap,
    required this.index,
    required this.currentSelectIndex,
  }) : super(key: key);

  @override
  _BrandCardState createState() => _BrandCardState();
}

class _BrandCardState extends State<BrandCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.index == widget.currentSelectIndex ? const Color(0xFFDBB51A) : Colors.grey,
                width: widget.index == widget.currentSelectIndex ? 1 : 0.3
              ),
              borderRadius: BorderRadius.circular(5)
            ),
            
            child: Image.network(
              widget.brand.img, 
              height: 40, 
              width: 55,
              loadingBuilder: (BuildContext context, Widget child,  ImageChunkEvent? loadingProgress) {
                if(loadingProgress == null){
                  return child;
                }
                return ShimmerImageBrand();
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 40,
                  width: 55,
                  child: Center(
                    child: Text(widget.brand.brand, style: TextStyle(fontSize: 12, color: Colors.black,),),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}