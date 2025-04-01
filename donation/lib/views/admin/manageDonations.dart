import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';

class ManageDonationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, 
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,foregroundColor: appwhiteColor,
          title: Text('Manage Donations',style: TextStyle(color: appwhiteColor),),
          backgroundColor:primaryColor,
          bottom: TabBar(
            indicatorColor: secondaryColor,
            labelColor: appwhiteColor,
            unselectedLabelColor: appwhiteColor.withOpacity(0.7),
            tabs: [
              Tab(text: 'Pending', icon: Icon(Icons.pending_actions)),
              Tab(text: 'Approve', icon: Icon(Icons.check_circle)),
              Tab(text: 'Picked Up', icon: Icon(Icons.local_shipping)),
              Tab(text: 'Completed', icon: Icon(Icons.done_all)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Pending Donations Tab
            DonationList(
              donations: _getPendingDonations(),
              onApprove: (donation) {
                // Handle approve action
              },
              onReject: (donation) {
                // Handle reject action
              },
              onMarkAsPickedUp: null, // No "Mark as Picked Up" for pending donations
              onMarkAsCompleted: null, // No "Mark as Completed" for pending donations
            ),
            // Approved/Rejected Donations Tab
            DonationList(
              donations: _getApprovedDonations(),
              onApprove: null, // No "Approve" for already approved donations
              onReject: null, // No "Reject" for already approved donations
              onMarkAsPickedUp: (donation) {
                // Handle mark as picked up action
              },
              onMarkAsCompleted: null, // No "Mark as Completed" for approved donations
            ),
            // Picked Up Donations Tab
            DonationList(
              donations: _getPickedUpDonations(),
              onApprove: null,
              onReject: null,
              onMarkAsPickedUp: null, // No "Mark as Picked Up" for picked up donations
              onMarkAsCompleted: (donation) {
                // Handle mark as completed action
              },
            ),
            // Completed Donations Tab
            DonationList(
              donations: _getCompletedDonations(),
              onApprove: null,
              onReject: null,
              onMarkAsPickedUp: null,
              onMarkAsCompleted: null, // No actions for completed donations
            ),
          ],
        ),
      ),
    );
  }

  // Mock data for Pending Donations
  List<Map<String, String>> _getPendingDonations() {
    return [
      {
        'donorName': 'John Doe',
        'donationType': 'Food',
        'date': '2025-04-01',
        'status': 'Pending',
      },
      {
        'donorName': 'Jane Smith',
        'donationType': 'Money',
        'date': '2025-03-30',
        'status': 'Pending',
      },
    ];
  }

  // Mock data for Approved Donations
  List<Map<String, String>> _getApprovedDonations() {
    return [
      {
        'donorName': 'Alice Johnson',
        'donationType': 'Textiles',
        'date': '2025-03-28',
        'status': 'Approved',
      },
    ];
  }

  // Mock data for Picked Up Donations
  List<Map<String, String>> _getPickedUpDonations() {
    return [
      {
        'donorName': 'Bob Brown',
        'donationType': 'Engineering',
        'date': '2025-03-27',
        'status': 'Picked Up',
      },
    ];
  }

  // Mock data for Completed Donations
  List<Map<String, String>> _getCompletedDonations() {
    return [
      {
        'donorName': 'Charlie Green',
        'donationType': 'Clothing',
        'date': '2025-03-25',
        'status': 'Completed',
      },
    ];
  }
}

class DonationList extends StatelessWidget {
  final List<Map<String, String>> donations;
  final Function(Map<String, String>)? onApprove;
  final Function(Map<String, String>)? onReject;
  final Function(Map<String, String>)? onMarkAsPickedUp;
  final Function(Map<String, String>)? onMarkAsCompleted;

  DonationList({
    required this.donations,
    this.onApprove,
    this.onReject,
    this.onMarkAsPickedUp,
    this.onMarkAsCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: donations.length,
      itemBuilder: (context, index) {
        final donation = donations[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Donor: ${donation['donorName']}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Donation Type: ${donation['donationType']}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  'Date: ${donation['date']}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  'Status: ${donation['status']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: donation['status'] == 'Pending'
                        ? Colors.orange
                        : donation['status'] == 'Approved'
                            ? Colors.green
                            : donation['status'] == 'Picked Up'
                                ? Colors.blue
                                : Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onApprove != null)
                      ElevatedButton(
                        onPressed: () => onApprove!(donation),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                        ),
                        child: Text(
                          'Approve',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    if (onReject != null)
                      SizedBox(width: 8),
                    if (onReject != null)
                      ElevatedButton(
                        onPressed: () => onReject!(donation),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:secondaryColor,
                        ),
                        child: Text(
                          'Reject',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    if (onMarkAsPickedUp != null)
                      SizedBox(width: 8),
                    if (onMarkAsPickedUp != null)
                      ElevatedButton(
                        onPressed: () => onMarkAsPickedUp!(donation),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                        ),
                        child: Text(
                          'Mark as Picked Up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    if (onMarkAsCompleted != null)
                      SizedBox(width: 8),
                    if (onMarkAsCompleted != null)
                      ElevatedButton(
                        onPressed: () => onMarkAsCompleted!(donation),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                        ),
                        child: Text(
                          'Mark as Completed',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}