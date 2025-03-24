
import 'package:flutter_application_1/configs/constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class SignUpController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController termsController = TextEditingController();

  bool passwordVisibility = true;
 
 
  void toggleVisibility() {
    passwordVisibility = !passwordVisibility;
    update();
  }

}
 Widget successDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          //const Divider(color: primaryColor.accentColor, thickness: 2),
          const SizedBox(height: 10),
          const Icon(
            Icons.check_circle_outline,
            size: 100,
            color: primaryColor,
          ),
          const SizedBox(height: 30),
          const Text(
            'Your Account has been created successfully.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to login screen
              Get.toNamed('/login');
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              backgroundColor: primaryColor,
            ),
            child: const Text(
              'Click here to login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

