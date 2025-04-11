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
  TextEditingController _responseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    final url = Uri.parse('https://sanerylgloann.co.ke/donorApp/readMessage.php?');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> parsedResponse = json.decode(response.body);
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

  // Function to mark message as read after sending a response
  Future<void> markMessageAsRead(int messageID) async {
    final response = await http.post(
      Uri.parse('https://sanerylgloann.co.ke/donorApp/markMessageAsRead.php'),
      body: {
        'messageID': messageID.toString(),
      },
    );
    if (response.statusCode == 200) {
      print('Message marked as read');
      fetchMessages(); // Refresh the list after updating
    } else {
      print("Failed to mark message as read");
    }
  }

  // Function to show the response dialog for unread messages
  void _showResponseDialog(BuildContext context, int messageID, bool isRead) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isRead ? 'Message' : 'Reply to Message'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('From: ${messages[messageID]['firstName']}'), // Displaying sender
              SizedBox(height: 8),
              Text('Message: ${messages[messageID]['message']}'), // Displaying message content
              if (!isRead) ...[
                TextField(
                  controller: _responseController,
                  decoration: InputDecoration(
                    labelText: 'Your Response',
                    hintText: 'Type your response here',
                  ),
                  maxLines: 4,
                ),
              ]
            ],
          ),
          actions: <Widget>[
            if (!isRead) ...[
              ElevatedButton(
                onPressed: () async {
                  // Send the email and mark the message as read
                  await markMessageAsRead(messageID);
                  Navigator.of(context).pop(); // Close the dialog
                  setState(() {
                    _responseController.clear(); // Clear the text field after sending
                  });
                },
                child: Text('Mark as Read'),
              ),
            ],
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without marking as read
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: appwhiteColor,
        title: Text('Notifications', style: TextStyle(color: appwhiteColor)),
        backgroundColor: primaryColor,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : messages.isEmpty
              ? Center(child: Text('No messages available'))
              : ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isRead = message['messageStatus'] == '1'; // Check for read status

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
                          Icons.done_all,
                          color: isRead ? Colors.blue : Colors.grey, // Blue for read, grey for unread
                        ),
                        onTap: () {
                          // Show the response dialog if the message is unread
                          _showResponseDialog(context, index, isRead);
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
