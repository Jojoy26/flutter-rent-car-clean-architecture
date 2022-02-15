import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImageBrand extends StatefulWidget {
  const ShimmerImageBrand({ Key? key }) : super(key: key);

  @override
  _ShimmerImageBrandState createState() => _ShimmerImageBrandState();
}

class _ShimmerImageBrandState extends State<ShimmerImageBrand> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 55,
      child: Shimmer.fromColors(
        child: Container(
          color: Colors.red,
          height: 40,
          width: 55,
        ), 
        baseColor: Color(0xFFEBEBF4), 
        highlightColor: Color(0xFFF4F4F4)
        ),
    );
  }
}