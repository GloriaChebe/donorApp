
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/admin/adminCategories.dart';
import 'package:flutter_application_1/views/admin/adminPage.dart';
import 'package:flutter_application_1/views/admin/manageDonations.dart';

import 'package:flutter_application_1/views/admin/manageUsers.dart';
import 'package:flutter_application_1/views/admin/manageWallet.dart';
import 'package:flutter_application_1/views/categories.dart';
import 'package:flutter_application_1/views/contactUs.dart';

import 'package:flutter_application_1/views/home/homePage.dart';
import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_application_1/views/nav.dart';
import 'package:flutter_application_1/views/profile.dart';
import 'package:flutter_application_1/views/profileDetails.dart';
import 'package:flutter_application_1/views/signUp.dart';
import 'package:flutter_application_1/views/splashScreen.dart';
import 'package:flutter_application_1/views/status.dart';
import 'package:get/get.dart';

class Pages {
  static const String splash = '/splash';
  static const String signUp = '/signUp';
  static const String login = '/login';
  static const String homepage = '/homepage';
  static const String navpage='/navpage';
  static const String categories = '/categories';
  static const String status = '/status';
  static const String profile = '/profile';
  static const String admin = '/admin';
  static const String manageUsers = '/manageUsers';
  static const String manageDonations= '/manageDonations';
  static const String manageWallet= '/manageWallet';

  static const String contactUs= '/contactUs';
  static const String categoriesAdmin= '/categoriesAdmin';
  static const String profileDetails= '/profileDetails';
  

  static final routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: signUp, page: () => SignUpPage()),
     GetPage(name: login, page: () => LoginPage()),
     GetPage(name: homepage, page: () => HomePage()),
      GetPage(name: navpage, page: () => navPage()),
     GetPage(name: categories, page: () => CategoriesPage()),
     GetPage(name: status, page: () => Statuspage()),
     GetPage(name: profile, page: () => ProfilePage()),
     GetPage(name: admin, page: () => AdminPage()),
     GetPage(name: manageDonations, page: () => ManageDonationsPage()),
     GetPage(name: manageUsers, page: () => ManageUsersPage()),
     GetPage(name: manageWallet, page: () => ManageWalletPage()),
    
     GetPage(name: contactUs, page: () => ContactUsPage()),
     GetPage(name: categoriesAdmin, page: () => CategoriesAdmin()),
      GetPage(name: profileDetails, page: () => ProfileDetailsPage()),
   
    
  ];
}
