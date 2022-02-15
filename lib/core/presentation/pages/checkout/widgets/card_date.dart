import 'package:flutter/material.dart';
import 'package:flutter_rent/core/presentation/presenters/mixins/verify_number.dart';
import 'package:flutter_rent/utils/months_list.dart';

class CardDate extends StatefulWidget {
  final String title;
  final DateTime date;
  const CardDate({
    Key? key,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  _CardDateState createState() => _CardDateState();
}

class _CardDateState extends State<CardDate> with VerifyNumber {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          Text(widget.title),
          SizedBox(height: 13,),
          Row(
            children: [
              Icon(Icons.date_range, color: Color(0xFFDBB51A), size: 18,),
              Text("From ${widget.date.day} ${monthsList[widget.date.month]}")
            ],
          ),
          SizedBox(height: 9,),
          Row(
            children: [
              Icon(Icons.timer, color: Color(0xFFDBB51A), size: 19,),
              Text("At ${widget.date.hour < 12 ? widget.date.hour : widget.date.hour - 12 }:${verifyNumber(widget.date.minute)} ${widget.date.hour < 12 ? "AM" : "PM"}")
            ],
          )
        ],
      ),
    );
  }
}