import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';

class TermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,foregroundColor: appwhiteColor,
        title: Text("Terms and Conditions", style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Terms and Conditions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "1. Acceptance of Terms",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "By using this application, you agree to be bound by these terms and conditions. If you do not agree, please do not use the application.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "2. User Responsibilities",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "3. Prohibited Activities",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "You agree not to engage in any activities that may harm the application, its users, or violate any applicable laws.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "4. Limitation of Liability",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "The application is provided 'as is' without any warranties. We are not liable for any damages arising from the use of this application.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "5. Changes to Terms",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "We reserve the right to modify these terms at any time. Continued use of the application constitutes acceptance of the updated terms.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "6. Contact Us",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "If you have any questions about these terms, please contact us at support@example.com.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 24),
           
          ],
        ),
      ),
    );
  }
}