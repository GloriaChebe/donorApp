import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';

class ManageUsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> users = _getUsers(); // Mock user data

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appwhiteColor),
          onPressed: () {
            Navigator.pushNamed(context, '/admin'); // Navigate to Admin Page
          },
        ),
        title: Text(
          'Users',
          style: TextStyle(color: appwhiteColor),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Enable horizontal scrolling
        child: DataTable(
          columns: [
            DataColumn(label: Text('User ID', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Contacts', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Role', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: users.map((user) {
            return DataRow(cells: [
              DataCell(Text(user['id'] ?? 'N/A')),
              DataCell(Text(user['name'] ?? 'N/A')),
              DataCell(Text(user['email'] ?? 'N/A')),
              DataCell(Text(user['contacts'] ?? 'N/A')),
              DataCell(Text(user['role'] ?? 'N/A')),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  // Mock data for users
  List<Map<String, String>> _getUsers() {
    return [
      {
        'id': '001',
        'name': 'Gloria Chebet',
        'email': 'gloss@gmail.com',
        'contacts': '0745881266',
        'role': 'Admin',
      },
      {
        'id': '002',
        'name': 'Linus Korir',
        'email': 'linusKorir@gmail.com',
        'contacts': '0700000001',
        'role': 'Donor',
      },
      {
        'id': '003',
        'name': 'Alice Macharia',
        'email': 'alicemacharia01n@gmail.com',
        'contacts': '0700000002',
        'role': 'Donor',
      },
      {
        'id': '004',
        'name': 'Felix Omondi',
        'email': 'omosh@gmail.com.com',
        'contacts': '0700000003',
        'role': 'Donor',
      },
    ];
  }
}