import 'package:flutter/material.dart';

class ManageUsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> users = _getUsers(); // Mock user data

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Users'),
        backgroundColor: Colors.blue,
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
        'id': 'U001',
        'name': 'John Doe',
        'email': 'john.doe@example.com',
        'contacts': '+1234567890',
        'role': 'Donor',
      },
      {
        'id': 'U002',
        'name': 'Jane Smith',
        'email': 'jane.smith@example.com',
        'contacts': '+9876543210',
        'role': 'Recipient',
      },
      {
        'id': 'U003',
        'name': 'Alice Johnson',
        'email': 'alice.johnson@example.com',
        'contacts': '+1122334455',
        'role': 'Admin',
      },
      {
        'id': 'U004',
        'name': 'Bob Brown',
        'email': 'bob.brown@example.com',
        'contacts': '+9988776655',
        'role': 'Donor',
      },
    ];
  }
}