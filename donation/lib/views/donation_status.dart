import 'package:flutter/material.dart';

class DonationStatusPage extends StatelessWidget {
  final String donationId;
  final String itemName;
  final int quantity;
  final String pickupOption;
  final DateTime? pickupDate;
  final TimeOfDay? pickupTime;

  DonationStatusPage({
    required this.donationId,
    required this.itemName,
    required this.quantity,
    required this.pickupOption,
    this.pickupDate,
    this.pickupTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Status'),
        backgroundColor: Color(0xFF1565C0),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Donation ID: $donationId',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Item: $quantity x $itemName',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Pickup Option: $pickupOption',
              style: TextStyle(fontSize: 16),
            ),
            if (pickupOption == 'Schedule Pickup' && pickupDate != null && pickupTime != null) ...[
              SizedBox(height: 16),
              Text(
                'Scheduled For: ${pickupDate!.day}/${pickupDate!.month}/${pickupDate!.year} at ${pickupTime!.hour}:${pickupTime!.minute.toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 16),
              ),
            ],
            SizedBox(height: 16),
            Text(
              'Status: Pending',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            SizedBox(height: 16),
            Text(
              'Your donation request has been submitted and is awaiting administrator review.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
