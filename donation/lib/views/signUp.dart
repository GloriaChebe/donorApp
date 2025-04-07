import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
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
                              Icons.person_add,
                              size: 50,
                              color:primaryColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          Text(
                            'Create an Account',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color:primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Sign up to get started',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: appBlackColor,
                            ),
                          ),
                          const SizedBox(height: 30),
                         
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: firstNameController,
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your first name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: lastNameController,
                                  decoration: InputDecoration(
                                    labelText: 'Last Name',
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your last name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
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
                          // Contacts Field
                          TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              hintText: 'e.g., 0700 000 000',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              if (!RegExp(r'^\d{9,10}$').hasMatch(value)) {
                                return 'Enter a valid phone number';
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
                          const SizedBox(height: 30),
                          // Sign Up Button
                          ElevatedButton(
                            onPressed: () async{
                              if (_formKey.currentState!.validate()) {

                                http.Response response = await http.post(
                                  Uri.parse('https://sanerylgloann.co.ke/donorApp/createUser.php'),
                                  body: {
                                    'firstName': firstNameController.text,
                                    'lastName': lastNameController.text,
                                    'email': emailController.text,
                                    'phoneNumber': phoneController.text,
                                    'password': passwordController.text,
                                  },
                                );
                                if(response.statusCode == 200) {
                                  // Handle successful sign-up
                                  var res=jsonDecode(response.body);

                                  if(res['success'] == 1) {
                                     Navigator.pushReplacementNamed(context, '/login');
                                    // User created successfully
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('User Created')),
                                          
                                    );
                                  } else {
                                    // User already exists
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error Ocurred')),
                                    );
                                  }
                                 
                                  
                                } else {
                                  // Handle error
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Sign Up Failed')),
                                  );
                                }
                            
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
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Login Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(fontSize: 16),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: Text(
                                  'Log In',
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