// Messages list page
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';

class MessagesPage extends StatelessWidget {
  final List<ChatThread> threads = [
    ChatThread(
     userId: '1001',
      lastMessage: 'Your donation has been approved.',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      unreadCount: 1,
    ),
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages' ,),
        backgroundColor: primaryColor,
      ),
      body: threads.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.message,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No messages yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'When you receive messages about your donations,\nthey will appear here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: threads.length,
              itemBuilder: (context, index) {
                final thread = threads[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF1565C0),
                    child: Icon(Icons.inventory_2, color: Colors.white),
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Donation #${thread.userId}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      if (thread.unreadCount > 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${thread.unreadCount}',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text(
                        thread.userId,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 4),
                      Text(
                        thread.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatMessageTime(thread.timestamp),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(donationId: thread.userId),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // This could open a list of donations to select which one to message about
          // or create a general inquiry
          _showContactOptions(context);
        },
        backgroundColor: Color(0xFF1565C0),
        child: Icon(Icons.add),
        tooltip: 'New Message',
      ),
    );
  }

  void _showContactOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.question_answer, color: Color(0xFF1565C0)),
                title: Text('General Inquiry'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(donationId: 'general'),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.inventory_2, color: Color(0xFF1565C0)),
                title: Text('About a Donation'),
                onTap: () {
                  Navigator.pop(context);
                  // This could navigate to a page to select which donation
                  // For demo purposes, we'll just go to a specific donation chat
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(donationId: 'D12345'),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatMessageTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inDays > 7) {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

// Chat page
class ChatPage extends StatefulWidget {
  final String donationId;

  ChatPage({required this.donationId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Add initial system message
    _messages.add(
      ChatMessage(
        sender: 'System',
        message: widget.donationId == 'general'
            ? ' How can we help you today?'
            : ' An administrator will reply it shortly.',
        isSystem: true,
        timestamp: DateTime.now().subtract(Duration(hours: 1)),
      ),
    );
    
    // Add some sample messages for demo
    if (widget.donationId != 'general') {
      _messages.add(
        ChatMessage(
          sender: 'Admin',
          message: 'We have received your donation request for item #${widget.donationId}. Our team will review it shortly.',
          isAdmin: true,
          timestamp: DateTime.now().subtract(Duration(minutes: 45)),
        ),
      );
      
      _messages.add(
        ChatMessage(
          sender: 'You',
          message: 'Thank you! When do you expect to process my request?',
          isUser: true,
          timestamp: DateTime.now().subtract(Duration(minutes: 30)),
        ),
      );
      
      _messages.add(
        ChatMessage(
          sender: 'Admin',
          message: 'We usually process donation requests within 24-48 hours. We\'ll notify you as soon as it\'s approved.',
          isAdmin: true,
          timestamp: DateTime.now().subtract(Duration(minutes: 15)),
        ),
      );
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            sender: 'You',
            message: _messageController.text.trim(),
            isUser: true,
            timestamp: DateTime.now(),
          ),
        );
        _messageController.clear();
      });
      
      
        // Scroll to bottom after message is sent
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
      
      // Simulate admin response (for demo purposes)
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _messages.add(
            ChatMessage(
              sender: 'Admin',
              message: 'Thank you for your message. Our team will respond shortly.',
              isAdmin: true,
              timestamp: DateTime.now(),
            ),
          );
        });
        
        // Scroll to bottom after admin response
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.donationId == 'general' 
              ? 'General Support' 
              : 'Donation #${widget.donationId}'
        ),
        backgroundColor: Color(0xFF1565C0),
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageBubble(_messages[index]);
                },
              ),
            ),
          ),
          
          // Message input
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1565C0),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: message.isUser 
            ? MainAxisAlignment.end 
            : MainAxisAlignment.start,
        children: [
          if (message.isSystem) ...[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  message.message,
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ),
          ] else if (message.isUser) ...[
            Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFF1565C0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message.message,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                ],
              ),
            ),
          ] else ...[
            Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.sender,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(message.message),
                  SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(color: Colors.black54, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}

// Chat thread model for messages list
class ChatThread {
  final String userId;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;

  ChatThread({
     required this.userId,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
  });
}
// Chat message model
class ChatMessage {
  final String sender;
  final String message;
  final DateTime timestamp;
  final bool isUser;
  final bool isAdmin;
  final bool isSystem;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.timestamp,
    this.isUser = false,
    this.isAdmin = false,
    this.isSystem = false,
  });
}