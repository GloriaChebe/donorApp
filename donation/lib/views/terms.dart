import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';

class TermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: appwhiteColor,
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
              "By using this donation platform, you agree to comply with and be bound by these Terms and Conditions. If you do not agree with any part of the terms, please do not use the platform.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "2. Purpose of the Platform",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "This platform is designed to facilitate donations to support research, development, and innovation efforts at KIRDI)",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "3. User Responsibilities",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Users must provide accurate information during registration and while making donations. Users are responsible for maintaining the confidentiality of their account and activity.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "4. Donation Guidelines",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "All donations made through this platform are voluntary. Donated items or funds must be genuine and not violate any local or international laws.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "5. Transparency and Tracking",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Our platform provides status tracking for each donation .You will be notified of the progress of your donation, from pending to received.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "6. Prohibited Activities",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "You may not use this platform for any fraudulent, illegal, or unauthorized purpose. Misuse may lead to account suspension or legal action.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "7. Data Privacy",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "We value your privacy. Any personal information collected is used solely for donation management and communication purposes. We do not share your information with third parties without consent.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "8. Limitation of Liability",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "This platform is provided 'as is' without warranties. We are not liable for any indirect, incidental, or consequential damages arising from the use of the platform.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "9. Modification of Terms",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "We reserve the right to modify these terms at any time. Continued use of the platform indicates acceptance of any changes made.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "10. Contact Us",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "If you have any questions or concerns about these Terms and Conditions, please contact us at glosschebet@gmail.com.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
