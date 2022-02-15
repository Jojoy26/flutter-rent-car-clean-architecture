import 'package:flutter/material.dart';
import 'package:flutter_rent/core/presentation/pages/categories/categories_page.dart';
import 'package:flutter_rent/core/presentation/pages/profile/profile_page.dart';
import 'package:flutter_rent/core/presentation/pages/rents/rents_page.dart';
import 'package:flutter_rent/core/presentation/pages/saved/saved_page.dart';


List<Widget> listPages = [
  CategoriesPage(),
  RentsPage(),
  SavedPage(),
  ProfilePage()
];