import 'package:flutter/material.dart';

Widget googleButton (String title, void Function() f) {
  return Container(
    height: 45,
    child: (
      TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          )
        ),
        onPressed: f, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/assets/images/googleLogo.png",height: 14),
            SizedBox(width: 5,),
            Text(title, style: TextStyle(color: Colors.black),)
          ],
        ),
      )
    ),
  );
}