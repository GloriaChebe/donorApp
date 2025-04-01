
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/controllers/loginController.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final Logincontroller controller = Get.put(Logincontroller());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 128),
      ),
      body: Stack(
        children: [
          // Background Container (At the top)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              color: const Color.fromARGB(255, 0, 0, 128),
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: const [
                  // add logo image
                  // const Spacer(),
                    SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Sign in to your Account",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 173, 216, 230)),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Enter your email and password to log in",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.25,
                  // )
                ],
              ),
            ),
            
          ),
         
          // Form Widget (On top)
          Positioned(
            top:130,
            left: 0,
            right: 0,
      height: MediaQuery.of(context).size.height * 0.6,
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
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                minimumSize: const Size(double.infinity, 50),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Image.asset('assets/images/google_logo.png', width: 24, height: 24,),
                                Icon(Icons.g_mobiledata),
                                Text(
                                  "Continue with Google",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                         
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Expanded(child: Divider()),
                              Text("   Or login with   "),
                              Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: controller.emailController,
                            decoration: const InputDecoration(
                              labelText: "Email Address",
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? "Enter an email"
                                : controller.validateEmail(value),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: controller.passwordController,
                            obscureText: controller.passwordVisibility,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      controller.toggleVisibility();
                                    });
                                  },
                                  icon: controller.passwordVisibility
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)),
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? "Enter a password"
                                : value.length < 8
                                    ? "Make sure you have a length of more than 8 digits"
                                    : null,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              // alignment: WrapAlignment.start,
                              // crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    //forgotPasswordPopup(context); // Show the forgot password popup dialog
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 245, 132, 14),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // if(_formKey.currentState!.validate()){
                              //   print("Go to dashboard");
                              // }
                              Get.toNamed('/admin');
                            
                            
                              
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 0, 0, 128),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 50),
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed("/signUp");
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height:80),
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


