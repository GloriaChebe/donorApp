import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();

  // Static method to fetch unread messages count
  static Future<int> fetchUnreadCount() async {
    final url = Uri.parse('https://sanerylgloann.co.ke/donorApp/readMessage.php');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> parsedResponse = json.decode(response.body);
        if (parsedResponse['success'] == 1 && parsedResponse['data'] is List) {
          final messages = parsedResponse['data'];
          final unreadCount = messages.where((msg) => msg['messageStatus'] == '0').length;
          return unreadCount;
        }
      }
    } catch (e) {
      print('Error fetching unread count: $e');
    }
    return 0; // Default to 0 if there's an error
  }
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
    final url = Uri.parse('https://sanerylgloann.co.ke/donorApp/readMessage.php');
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

  Future<void> sendEmailReply(String userID, String message) async {
    final url = Uri.parse('https://sanerylgloann.co.ke/donorApp/createReplyMessage.php');
    try {
      final response = await http.get(url.replace(queryParameters: {
        'userID': userID,  // changed to match the case expected by the PHP backend
        'message': message,
      }));

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      
      if (response.statusCode == 200) {
        try {
          final jsonResponse = json.decode(response.body);
          if (jsonResponse['success'] == 1) {
            print('Reply sent successfully.');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Reply sent successfully.')),
            );
          } else {
            print('Failed to send reply: ${jsonResponse.toString()}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to send reply: ${jsonResponse['error'] ?? 'Unknown error'}')),
            );
          }
        } catch (e) {
          print('Invalid JSON: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected server response')),
          );
        }
      } else {
        print('Failed to send reply. Status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error sending email reply: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send email: $e')),
      );
    }
  }

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

  void _showResponseDialog(BuildContext context, int index, bool isRead) {
    final message = messages[index];
    _responseController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isRead ? 'Message' : 'Reply to Message',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text('From: ${message['firstName']}'),
                  SizedBox(height: 8),
                  Text('Message: ${message['message']}'),
                  if (!isRead) ...[
                    SizedBox(height: 12),
                    TextField(
                      controller: _responseController,
                      decoration: InputDecoration(
                        labelText: 'Your Response',
                        hintText: 'Type your response here',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                  ],
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (!isRead)
                        ElevatedButton(
                          onPressed: () async {
                            final userID = message['userID'];
                            final replyMessage = _responseController.text.trim();

                            if (replyMessage.isNotEmpty) {
                              await sendEmailReply(userID, replyMessage);
                              await markMessageAsRead(int.parse(message['messageID']));
                              Navigator.of(context).pop();
                              setState(() {
                                _responseController.clear();
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Please type a response message")),
                              );
                            }
                          },
                          child: Text('Send & Mark Read'),
                        ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    final isRead = message['messageStatus'] == '1';

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
                          color: isRead ? Colors.blue : Colors.grey,
                        ),
                        onTap: () {
                          _showResponseDialog(context, index, isRead);
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
