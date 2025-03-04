import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.history),
            title: Text("History"),
            onTap: () {
              // Navigate to History page
            },
          ),
          ListTile(
            leading: Icon(Icons.support),
            title: Text("Contact Support"),
            onTap: () {
              // Navigate to Contact Support page
            },
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text("Messenger"),
            onTap: () {
              // Navigate to Messenger page
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Log Out"),
            onTap: () {
              // Handle log out
            },
          ),
        ],
      ),
    );
  }
}