
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/categories.dart';
import 'package:flutter_application_1/views/donation_status.dart';
import 'package:flutter_application_1/views/homePage.dart';
import 'package:flutter_application_1/views/profile.dart';
import 'package:flutter_application_1/views/signUp.dart';
import 'package:get/get.dart';

class Pages {
  static const String splash = '/splash';
  static const String signUp = '/signUp';
  static const String login = '/login';
  //static const String email = '/email';
 // static const String verification = '/verification';
  //tatic const String newpassword = '/newpassword';
  static const String homepage = '/homepage';
  static const String categories = '/categories';
  static const String status = '/status';
  static const String profile = '/profile';

  static final routes = [
    //GetPage(name: splash, page: () => splashScreen()),
    GetPage(name: signUp, page: () => SignUpScreen()),
    // GetPage(name: login, page: () => LoginPage()),
     GetPage(name: homepage, page: () => HomePage()),
     GetPage(name: categories, page: () => CategoriesPage()),
     //GetPage(name: status, page: () => StatusPage()),
     GetPage(name: profile, page: () => ProfilePage()),
    //GetPage(name: email, page: () => EmailScreen()),
    //GetPage(name: newpassword, page: () => NewPasswordScreen()),
    //GetPage(name: verification, page: () => VerificationScreen()),
 
    
   
    
  ];
}
