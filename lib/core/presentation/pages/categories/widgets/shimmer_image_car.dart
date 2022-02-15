import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImageCar extends StatefulWidget {
  const ShimmerImageCar({ Key? key }) : super(key: key);

  @override
  _ShimmerImageCarState createState() => _ShimmerImageCarState();
}

class _ShimmerImageCarState extends State<ShimmerImageCar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Shimmer.fromColors(
        child: Container(
          color: Colors.red,
          height: 100,
        ), 
        baseColor: Color(0xFFEBEBF4), 
        highlightColor: Color(0xFFF4F4F4)
        ),
    );
  }
}