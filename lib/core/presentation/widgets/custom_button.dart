import 'package:flutter/material.dart';

Widget customButton (String title, void Function() f) {
  return (
    SizedBox(
      height: 40,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Color(0xFFDBB51A),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9))),
        onPressed: f,
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    )
  );
}