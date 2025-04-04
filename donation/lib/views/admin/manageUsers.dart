import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManageUsersPage extends StatefulWidget {
  @override
  _ManageUsersPageState createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  late Future<List<Map<String, String>>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _fetchUsers();
  }

  Future<List<Map<String, String>>> _fetchUsers() async {
    final url = Uri.parse('https://sanerylgloann.co.ke/donorApp/totalUsers.php');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Check if the response contains a "data" key
        if (data['data'] != null && data['data'] is List) {
          final List<dynamic> users = data['data'];
          return users.map((user) {
            return {
              'id': (user['userID'] ?? 'N/A').toString(),
              // Combine firstName and lastName for the name field
              'name': '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}'.trim(),
              'email': (user['email'] ?? 'N/A').toString(),
              'contacts': (user['phoneNumber'] ?? 'N/A').toString(),
              // Map role 1 to "Admin" and 0 to "Donor"
              'role': (user['role'] == '1') ? 'Admin' : 'Donor',
            };
          }).toList();
        } else {
          throw Exception('Invalid response structure: "data" key not found');
        }
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<List<Map<String, String>>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found.'));
          } else {
            final users = snapshot.data!;
            return SingleChildScrollView(
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
            );
          }
        },
      ),
    );
  }
}