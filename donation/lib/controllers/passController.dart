import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  // Text controllers for new and confirm passwords
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observables for password visibility
  var isObscureNewPassword = true.obs;
  var isObscureConfirmPassword = true.obs;

  // Toggle visibility for new password
  void toggleNewPasswordVisibility() {
    isObscureNewPassword.value = !isObscureNewPassword.value;
  }

  // Toggle visibility for confirm password
  void toggleConfirmPasswordVisibility() {
    isObscureConfirmPassword.value = !isObscureConfirmPassword.value;
  }

  // Dispose of the controllers when not needed
  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
