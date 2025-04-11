import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PasswordResetController extends GetxController {
  var isLoading = false.obs;

  // Shared data between screens
  String email = '';
  String hash = '';
  String expiry = '';

  Future<bool> requestResetCode(String userEmail) async {
    isLoading.value = true;
    final response = await http.post(
      Uri.parse("https://sanerylgloann.co.ke/donorApp/resetPassword.php?"),
      body: {'email': userEmail},
    );
    isLoading.value = false;

    final data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      email = userEmail;
      hash = data['hash'];
      expiry = data['expiry'].toString();
      return true;
    } else {
      Get.snackbar("Error", data['message']);
      return false;
    }
  }

  Future<bool> resetPassword(String code, String newPassword) async {
    isLoading.value = true;
    final response = await http.post(
      Uri.parse("https://sanerylgloann.co.ke/donorApp/resetPassword.php?"),
      body: {
        'email': email,
        'code': code,
        'hash': hash,
        'expiry': expiry,
        'new_password': newPassword,
      },
    );
    isLoading.value = false;

    final data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      Get.snackbar("Success", data['message']);
      return true;
    } else {
      Get.snackbar("Error", data['message']);
      return false;
    }
  }
}




class ResetRequestPage extends StatelessWidget {
  final emailController = TextEditingController();
  final controller = Get.put(PasswordResetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Enter your email to receive a reset code."),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 20),
            Obx(() => controller.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      final success = await controller.requestResetCode(
                        emailController.text.trim(),
                      );
                      if (success) {
                        Get.to(() => ResetConfirmPage());
                      }
                    },
                    child: Text("Send Reset Code"),
                  )),
          ],
        ),
      ),
    );
  }
}



class ResetConfirmPage extends StatelessWidget {
  final codeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final controller = Get.find<PasswordResetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confirm Password Reset")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Enter the code you received and your new password."),
            TextField(
              controller: codeController,
              decoration: InputDecoration(labelText: "Verification Code"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "New Password"),
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Confirm Password"),
            ),
            const SizedBox(height: 20),
            Obx(() => controller.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      final pass = passwordController.text.trim();
                      final confirm = confirmPasswordController.text.trim();
                      if (pass != confirm) {
                        Get.snackbar("Error", "Passwords do not match");
                        return;
                      }
                      final success = await controller.resetPassword(
                        codeController.text.trim(),
                        pass,
                      );
                      if (success) {
                        Get.back(); // Or go to login page
                      }
                    },
                    child: Text("Reset Password"),
                  )),
          ],
        ),
      ),
    );
  }
}
