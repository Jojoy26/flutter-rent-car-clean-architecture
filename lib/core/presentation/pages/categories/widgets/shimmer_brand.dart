import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBrand extends StatefulWidget {
  const ShimmerBrand({ Key? key }) : super(key: key);

  @override
  _ShimmerBrandState createState() => _ShimmerBrandState();
}

class _ShimmerBrandState extends State<ShimmerBrand> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 75,
      child: Shimmer.fromColors(
        child: Container(
          margin: EdgeInsets.only(left: 10),
          color: Colors.blue,
          height: 55,
          width: 75,
          constraints: BoxConstraints(maxHeight: 55, minWidth: 60),
        ), 
        baseColor: Color(0xFFEBEBF4), 
        highlightColor: Color(0xFFF4F4F4)
      ),
    );
  }
}