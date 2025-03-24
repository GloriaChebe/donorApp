import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/controllers/signUpController.dart';
import 'package:flutter_application_1/views/terms.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController controller = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: [
          // Background Container
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.30,
              color: primaryColor,
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Sign Up and Get Started",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 173, 216, 230),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed('/login');
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            color: Color.fromARGB(255, 245, 132, 14),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Form Widget
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),

                          // First and Last Name
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: controller.firstNameController,
                                  decoration: const InputDecoration(
                                    labelText: "First Name",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? "Enter a name"
                                          : null,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: controller.secondNameController,
                                  decoration: const InputDecoration(
                                    labelText: "Last Name",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? "Enter a name"
                                          : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Email Address
                          TextFormField(
                            controller: controller.emailController,
                            decoration: const InputDecoration(
                              labelText: "Email Address",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            
                          ),
                          const SizedBox(height: 10),

                          // Phone Number
                          TextFormField(
                            controller: controller.phoneNumberController,
                            decoration: const InputDecoration(
                              hintText: "700 000 000",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Password
                          TextFormField(
                            controller: controller.passwordController,
                            obscureText: controller.passwordVisibility,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    controller.toggleVisibility();
                                  });
                                },
                                icon: controller.passwordVisibility
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? "Enter a password"
                                : value.length < 8
                                    ? "Password must be at least 8 characters"
                                    : null,
                          ),
                          const SizedBox(height: 10),

                          // Terms and Conditions
                          
                          const SizedBox(height: 20),

                          // Sign-Up Button
                          ElevatedButton(
                            onPressed: ()  {
                             
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:primaryColor,
                        
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text("Sign Up"),
                          ),
                          const SizedBox(height: 20),

                          // Social Sign-Up
                          const Text("Or"),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Handle Google sign-up
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.g_mobiledata),
                                Text(
                                  "Sign up with Google",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}