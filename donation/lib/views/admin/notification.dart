import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<dynamic> messages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    final url = Uri.parse('https://sanerylgloann.co.ke/donorApp/readMessage.php?');
    try {
      final response = await http.get(url);
      print('API Response: ${response.body}'); 
      if (response.statusCode == 200) {
        final Map<String, dynamic> parsedResponse = json.decode(response.body);
        print('Parsed Data: $parsedResponse'); 
        if (parsedResponse['success'] == 1 && parsedResponse['data'] is List) {
          setState(() {
            messages = parsedResponse['data'];
            messages.sort((a, b) => int.parse(b['messageID']).compareTo(int.parse(a['messageID'])));
            isLoading = false;
          });
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to load messages');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching messages: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,foregroundColor: appwhiteColor,
        title: Text('Notifications',style: TextStyle(color: appwhiteColor),),
        backgroundColor:primaryColor
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : messages.isEmpty
              ? Center(child: Text('No messages available'))
              : ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isRead = message['messageStatus'] == 'read';

                    return Card(
                      color: isRead ? Colors.grey[200] : Colors.white,
                      child: ListTile(
                        title: Text(
                          message['subject'] ?? 'No Subject',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isRead ? Colors.grey : Colors.black,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('From: ${message['firstName'] ?? 'Unknown'}/${message['userID'] ?? 'N/A'}'),
                            SizedBox(height: 4),
                            Text(message['message'] ?? 'No Message'),
                          ],
                        ),
                        trailing: Icon(
                          message['messageStatus'] == '1' ? Icons.done_all : Icons.done_all,
                          color: message['messageStatus'] == '1' ? Colors.blue : Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}