import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/widgets/statusWidget.dart';

import 'package:step_progress_indicator/step_progress_indicator.dart' as step_progress;


class Statuspage extends StatefulWidget {
  final String donationId;
  final String currentStatus;
  final String itemName;
  final int quantity;
  final String pickupOption;
  final DateTime? pickupDate;
  final TimeOfDay? pickupTime;

  Statuspage({
    required this.donationId,
    required this.currentStatus,
    required this.itemName,
    required this.quantity,
    required this.pickupOption,
    this.pickupDate,
    this.pickupTime,
  });

  @override
  StatusPage createState() => StatusPage();
}

class StatusPage extends State<Statuspage> {
  bool _showFullDetails = false; // Toggle for showing full details

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: appwhiteColor,
        title: Text('Donation Status', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          // First StatusCard for donation details
          StatusCard(
            donationId: widget.donationId,
            currentStatus: widget.currentStatus,
            itemName: widget.itemName,
            quantity: widget.quantity,
            pickupOption: widget.pickupOption,
            pickupDate: widget.pickupDate,
            pickupTime: widget.pickupTime,
            showFullDetails: _showFullDetails,
            onToggleDetails: () {
              setState(() {
                _showFullDetails = !_showFullDetails;
              });
            },
          ),
          SizedBox(height: 20),
          // Second StatusCard for pickup option details
          StatusCard(
            donationId: widget.donationId,
            currentStatus: 'Approved',
            itemName: 'Banana Stems',
            quantity: 1,
            pickupOption: widget.pickupOption,
            pickupDate: widget.pickupDate,
            pickupTime: widget.pickupTime,
            showFullDetails: true, // No toggle needed for this card
            onToggleDetails: () {}, // Empty callback
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
                            child: step_progress.StepProgressIndicator(
                              currentStep: _getStepIndex(widget.currentStatus) + 1,
                              totalSteps: 4,
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
      // // Floating action button to access messages
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => (),
      //       ),
      //     );
      //   },
      //   backgroundColor: Color.fromARGB(255, 245, 132, 14),
      //   child: Icon(
      //     Icons.chat,
      //     color: appwhiteColor,
      //   ),
      //   tooltip: 'Messages',
      // ),
    );
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