import 'package:flutter/material.dart';
import 'package:tcc_app/View/home_page.dart';
import 'package:tcc_app/test_page.dart';

void main() async {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(
        primaryColor: Colors.deepPurple,
    ),
  ));
}