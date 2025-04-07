import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
var storage=GetStorage();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  primaryColor,
                  secondaryColor,
                ],
              ),
            ),
          ),
          // Login Form
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blue.shade100,
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Welcome Text
                          Text(
                            'Welcome!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Log in to your account',
                            style: TextStyle(
                              fontSize: 16,
                              color: appBlackColor,
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Email Field
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          // Password Field
                          TextFormField(
                            controller: passwordController,
                            obscureText: passwordVisibility,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordVisibility
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    passwordVisibility = !passwordVisibility;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          // Forgot Password Link
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Handle forgot password
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: secondaryColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Log In Button
                          ElevatedButton(
                            onPressed: () async{
                               http.Response response = await http.post(
                                  Uri.parse('https://sanerylgloann.co.ke/donorApp/readUser.php'),
                                  body: {
                                    
                                    'email': emailController.text,
                                    
                                    'password': passwordController.text,
                                  },
                                );
                                print(response.body);
                                if(response.statusCode == 200) {
                                  // Handle successful login
                                  var res=jsonDecode(response.body);

                                  print(res['success']);

                                  if(res['success'] == 1) {
                                    storage.write("role", res['role']);
                                    storage.write("firstName", res['firstName']);
                                    storage.write("userID", res['userID']);
                                    print(res['role']);
                                    print(res['firstName']);
                                    print(res['userID']);
                                    Navigator.pushReplacementNamed(context, '/navpage');
                                    // login successfully
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('login successful')),
                                          
                                    );
                                  } else {
                                    
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('invalid email/password')),
                                    );
                                  }
                                
                                  
                                 
                                } else {
                                  // Handle error
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('login Failed')),
                                  );
                                }
                              //Navigator.pushReplacementNamed(context, '/navpage');
                              if (_formKey.currentState!.validate()) {
                                // Handle login logic
                                
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Sign Up Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(fontSize: 16),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/signUp');
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: secondaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
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