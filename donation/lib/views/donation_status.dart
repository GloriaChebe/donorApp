import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  final String donationId;
  final String itemName;
  final int quantity;
  final String pickupOption;
  final DateTime? pickupDate;
  final TimeOfDay? pickupTime;
  final String currentStatus;

  StatusPage({
    required this.donationId,
    required this.itemName,
    required this.quantity,
    required this.pickupOption,
    this.pickupDate,
    this.pickupTime,
    this.currentStatus = 'Pending',
  });

  @override
  _DonationStatusPage createState() => _DonationStatusPage();
}

class _DonationStatusPage extends State<StatusPage> {
  bool _showFullDetails = false; // Toggle for showing full details

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Status'),
        backgroundColor: Color(0xFF1565C0),
        actions: [
          // General message button in the app bar
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagesPage(),
                ),
              );
            },
            tooltip: 'Messages',
          ),
        ],
      ),
      body: Column(
        children: [
          // Upper Details Section
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Donation ID: ${widget.donationId}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(widget.currentStatus),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.currentStatus,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Item: ${widget.quantity} x ${widget.itemName}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Pickup Option: ${widget.pickupOption}',
                  style: TextStyle(fontSize: 16),
                ),
                if (widget.pickupOption == 'Schedule Pickup' &&
                    widget.pickupDate != null &&
                    widget.pickupTime != null) ...[
                  SizedBox(height: 8),
                  Text(
                    'Scheduled For: ${widget.pickupDate!.day}/${widget.pickupDate!.month}/${widget.pickupDate!.year} at ${widget.pickupTime!.hour}:${widget.pickupTime!.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
                // Dropdown Arrow Below Status
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showFullDetails = !_showFullDetails; // Toggle visibility
                    });
                  },
                  child: Center(
                    child: Icon(
                      _showFullDetails ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      size: 32,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Full Details Section
          Visibility(
            visible: _showFullDetails,
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Timeline Section
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: StepProgressIndicator(
                              currentStep: _getStepIndex(widget.currentStatus),
                              steps: ['Pending', 'Approved', 'Picked Up', 'Completed'],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Status Description Section
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getStatusDescription(widget.currentStatus),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Floating action button to access messages
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MessagesPage(),
            ),
          );
        },
        backgroundColor: Color(0xFF1565C0),
        child: Icon(Icons.chat),
        tooltip: 'Messages',
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'Picked Up':
        return Colors.blue;
      case 'Completed':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  int _getStepIndex(String status) {
    switch (status) {
      case 'Pending':
        return 0;
      case 'Approved':
        return 1;
      case 'Picked Up':
        return 2;
      case 'Completed':
        return 3;
      default:
        return 0;
    }
  }

  String _getStatusDescription(String status) {
    switch (status) {
      case 'Pending':
        return 'Your donation request has been submitted and is awaiting administrator review. We will process it as soon as possible.';
      case 'Approved':
        return 'Your donation has been approved. Please follow the pickup instructions or await further communication from our team.';
      case 'Picked Up':
        return 'Your donation has been picked up successfully. Thank you for your contribution!';
      case 'Completed':
        return 'Your donation process has been completed. Thank you for your generosity and support!';
      case 'Rejected':
        return 'Unfortunately, your donation request could not be accepted at this time. Please check messages for more details.';
      default:
        return 'Status information not available. Please contact administrator for more details.';
    }
  }
}

// Messages list page
class MessagesPage extends StatelessWidget {
  final List<ChatThread> threads = [
    ChatThread(
      donationId: 'D12345',
      itemName: 'Books',
      lastMessage: 'Your donation has been approved.',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      unreadCount: 1,
    ),
    ChatThread(
      donationId: 'D12346',
      itemName: 'Clothing',
      lastMessage: 'We will be collecting your items tomorrow.',
      timestamp: DateTime.now().subtract(Duration(days: 1)),
      unreadCount: 0,
    ),
    ChatThread(
      donationId: 'D12347',
      itemName: 'Electronics',
      lastMessage: 'Can you provide more details about the condition?',
      timestamp: DateTime.now().subtract(Duration(days: 3)),
      unreadCount: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        backgroundColor: Color(0xFF1565C0),
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
                        'Donation #${thread.donationId}',
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
                        thread.itemName,
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
                        builder: (context) => ChatPage(donationId: thread.donationId),
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
            ? 'Welcome to support. How can we help you today?'
            : 'Donation request has been submitted. An administrator will review it shortly.',
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
  final String donationId;
  final String itemName;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;

  ChatThread({
    required this.donationId,
    required this.itemName,
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

// Custom step progress indicator
class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  StepProgressIndicator({
    required this.currentStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(steps.length, (index) {
            final isActive = index <= currentStep;
            final isFirst = index == 0;
            final isLast = index == steps.length - 1;
            
            return Expanded(
              child: Row(
                children: [
                  // Line before circle (except for first item)
                  if (!isFirst)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: isActive ? Color(0xFF1565C0) : Colors.grey[300],
                      ),
                    ),
                  
                  // Circle
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive ? Color(0xFF1565C0) : Colors.grey[300],
                      border: Border.all(
                        //color: isActive ? Color(0xFF1565C0) : Colors.grey[300],
                        width: 2,
                      ),
                    ),
                    child: isActive
                        ? Icon(Icons.check, color: Colors.white, size: 16)
                        : null,
                  ),
                  
                  // Line after circle (except for last item)
                  if (!isLast)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: index < currentStep ? Color(0xFF1565C0) : Colors.grey[300],
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: steps.map((step) {
            final index = steps.indexOf(step);
            final isActive = index <= currentStep;
            
            return Text(
              step,
              style: TextStyle(
                color: isActive ? Color(0xFF1565C0) : Colors.grey,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}