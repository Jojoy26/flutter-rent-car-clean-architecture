import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCar extends StatefulWidget {
  const ShimmerCar({ Key? key }) : super(key: key);

  @override
  _ShimmerCarState createState() => _ShimmerCarState();
}

class _ShimmerCarState extends State<ShimmerCar> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Container(
        color: Colors.blue,
      ), 
      baseColor: Color(0xFFEBEBF4), 
      highlightColor: Color(0xFFF4F4F4)
    );
  }
}