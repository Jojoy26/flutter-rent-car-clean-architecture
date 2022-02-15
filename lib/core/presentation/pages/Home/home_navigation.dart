// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rent/core/presentation/pages/Home/list_pages.dart';
import 'package:get/get.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({ Key? key }) : super(key: key);

  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {

  int _selectedIndex = 0;

  void onItemTap (int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.border_all_rounded),
            label: "Categories"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_repair),
            label: "Rents"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline_sharp),
            label: "Saved"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile"
          ),
        ],
        selectedItemColor: Color(0xFFDBB51A),
        onTap: onItemTap,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}