import 'package:flutter/material.dart';

Widget buildTextFormField(
  Icon iconName, 
  String hintText, 
  TextInputType keyboardType, 
  bool obscure, 
  TextEditingController controller,
  String? Function(String? value) validator
  ) {
  return (Container(
    margin: EdgeInsets.only(top: 15),
    child: TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          prefixIcon: iconName,
          hintText: hintText,
          contentPadding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFDBB51A), width: 1.5),
              borderRadius: BorderRadius.circular(10))),
    ),
  ));
}
