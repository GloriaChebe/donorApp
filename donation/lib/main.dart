import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/categories.dart';
import 'package:flutter_application_1/views/homePage.dart';
import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_application_1/views/signUp.dart';
import 'package:get/get.dart';
import 'views/nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Donor App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: navPage(), // Set navPage as the home widget
      debugShowCheckedModeBanner: false,
    );
  }
}
