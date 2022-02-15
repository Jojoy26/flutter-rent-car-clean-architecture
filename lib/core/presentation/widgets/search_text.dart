import 'package:flutter/material.dart';

class SearchText extends StatefulWidget {
  final void Function(String search) onSubmitted;
  const SearchText({
    Key? key,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  _SearchTextState createState() => _SearchTextState();
}

class _SearchTextState extends State<SearchText> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 40,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.only(left: 10),
            hintText: "Search",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide()
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                width: 0.1,
                color: Colors.grey
              )
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Color(0xFFDBB51A),width: 0.5)
            )
          ),
          onSubmitted: (String search){
            widget.onSubmitted(search);
          },
        ),
      ),
    );
  }
}