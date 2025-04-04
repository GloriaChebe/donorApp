import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/views/contactUs.dart';
import 'package:flutter_application_1/views/profileDetails.dart';
import 'package:flutter_application_1/views/terms.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Text(
      //     "Profile",
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: Colors.blue[700],
       
      // ),
      body: ListView(
        children: [
          // Profile header with avatar
          // Container(
          //   padding: EdgeInsets.symmetric(vertical: 24),
          //   decoration: BoxDecoration(
          //     color: Colors.blue[700],
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(30),
          //       bottomRight: Radius.circular(30),
          //     ),
          //   ),
          //   child: Column(
          //     children: [
          //       // Avatar
          //       CircleAvatar(
          //         radius: 50,
          //         backgroundColor: Colors.white,
          //         child: Icon(
          //           Icons.person,
          //           size: 60,
          //           color: Colors.blue[700],
          //         ),
          //       ),
          //       SizedBox(height: 16),
          //       Text(
          //         "John Doe",
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 24,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       SizedBox(height: 4),
                
          //     ],
          //   ),
          // ),
          
          SizedBox(height: 16),
          
          // Account section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "ACCOUNT",
              style: TextStyle(
                color:primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          
          Card(
            //color: secondaryColor.withOpacity(0.001),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildListTile(
                  context,
                  Icons.person,
                  "My Profile",
                  Colors.blue,
                  () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileDetailsPage()),
                    ); 
                  },
                ),
                SizedBox(height: 10),
                Divider(height: 1, indent: 64),
                SizedBox(height: 10),
                _buildListTile(
                  context,
                  Icons.support,
                  "Contact Support",
                  Colors.green,
                  () {
                    // Navigate to Contact Support page
                   // Navigate to Contact Us page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactUsPage()),
                    ); 
                  },
                ),
              ],
            ),
          ),
          
          SizedBox(height: 16),
          
          // Legal section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "LEGAL",
              style: TextStyle(
                color:primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: _buildListTile(
              context,
              Icons.description,
              "Terms and Conditions",
              Colors.orange,
              () {
                 Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TermsPage()),
                    ); 
                // Navigate to Terms and Conditions page
              },
            ),
          ),
          
          SizedBox(height: 16),
          
          // Log out button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed("login");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout,color: appwhiteColor,),
                  SizedBox(width: 8),
                  Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 24),
        ],
      ),
    );
  }
  
  Widget _buildListTile(BuildContext context, IconData icon, String title, Color color, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: color,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}