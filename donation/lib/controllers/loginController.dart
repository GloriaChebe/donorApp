import 'dart:convert';
//import 'package:ask_giver/controllers/products_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


//import '../services/auth_service.dart';

class Logincontroller extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  //final ProductController productController=Get.put(ProductController());

  bool passwordVisibility = true;
 
  RxString userId= ''.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  // RxString authToken = ''.obs;

  // Email validation
  String? validateEmail(String email) {
    if (!EmailValidator.validate(email)) {
     return "Enter a valid email";
    } else {
      return null;
   }
   }
   void login() {
    // Add login logic here
    print("Login method called with email: ${emailController.text} and password: ${passwordController.text}");
  }

  // Toggle password visibility
  void toggleVisibility() {
    passwordVisibility = !passwordVisibility;
    update();
  }

}