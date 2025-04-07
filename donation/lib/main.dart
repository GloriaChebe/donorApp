import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/link.dart';
import 'package:flutter_application_1/views/admin/adminCategories.dart';
import 'package:flutter_application_1/views/admin/adminPage.dart';
import 'package:flutter_application_1/views/categories.dart';
import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_application_1/views/profileDetails.dart';

import 'package:flutter_application_1/views/signUp.dart';
import 'package:flutter_application_1/views/splashScreen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'views/nav.dart';

void main() async{
await GetStorage.init();
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
      //itialRoute: AppRouting.initialRoute,
     getPages: AppRouting.getPages,
      home: SplashScreen(),
      //home: CategoriesAdmin(),
      debugShowCheckedModeBanner: false,
    );
  }
}
