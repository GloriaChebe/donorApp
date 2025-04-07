import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/controllers/donationController.dart';
import 'package:flutter_application_1/models/donationModel.dart';
import 'package:http/http.dart' as http;
 final DonationController donationController=DonationController();

class ManageDonationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    donationController.fetchDonations(); // Fetch donations when the page is built
    return DefaultTabController(
      length: 4, 
      child: Scaffold(
        appBar: AppBar( leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appwhiteColor),
          onPressed: () {
            Navigator.pushNamed(context, '/admin'); 
          },
        ),
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
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade50, Colors.white],
            ),
         ),
          child: TabBarView(
            children: [
              // Pending Donations Tab
              DonationList(
                donations: donationController.donations.where((donation) => donation.status == 'Pending').toList(),
                onApprove: (donation) async{
                //  var res=await http.get(
                //     Uri.parse('https://example.com/approveDonation?donationId=${donation.donationId}'),
                    
                //   );
                  // Handle approve actio
                },
                onReject: (donation) {
                  // Handle reject action
                },
                onMarkAsPickedUp: null, // No "Mark as Picked Up" for pending donations
                onMarkAsCompleted: null, // No "Mark as Completed" for pending donations
              ),
              // Approved/Rejected Donations Tab
              DonationList(
                donations: donationController.donations.where((donation) => donation.status == 'Approved').toList(),
                onApprove: null, // No "Approve" for already approved donations
                onReject: null, // No "Reject" for already approved donations
                onMarkAsPickedUp: (donation) {
                  // Handle mark as picked up action
                },
                onMarkAsCompleted: null, // No "Mark as Completed" for approved donations
              ),
              // Picked Up Donations Tab
              DonationList(
                donations: donationController.donations.where((donation) => donation.status == 'PickedUp').toList(),
                onApprove: null,
                onReject: null,
                onMarkAsPickedUp: null, // No "Mark as Picked Up" for picked up donations
                onMarkAsCompleted: (donation) {
                  // Handle mark as completed action
                },
              ),
              // Completed Donations Tab
              DonationList(
                donations: donationController.donations.where((donation) => donation.status == 'Completed').toList(),
                onApprove: null,
                onReject: null,
                onMarkAsPickedUp: null,
                onMarkAsCompleted: null, // No actions for completed donations
              ),
            ],
          ),
        ),
      ),
    );
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
  final List<Donation> donations ;
  final Function(String)? onApprove;
  final Function( String)? onReject;
  final Function( String)? onMarkAsPickedUp;
  final Function(String)? onMarkAsCompleted;

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
      itemCount:donationController.donations.length,
      itemBuilder: (context, index) {
        final donation = donationController.donations[index];
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
                  'Donor: ${donation.firstName} ${donation.lastName}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Donation Type: ${donation.deliveryMethod}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  'Date: ${donation.preferredDate}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  'Status: ${donation.status}',
                  style: TextStyle(
                    fontSize: 14,
                    color: donation.status == 'Pending'
                        ? Colors.orange
                        : donation.status == 'Approved'
                            ? Colors.green
                            : donation.status == 'Picked Up'
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
                        onPressed: () => onApprove!(donation.donationId),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 4, 101, 22),
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
                        onPressed: () => onReject!(donation.donationId),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:Color.fromARGB(255, 232, 12, 12),
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
                        onPressed: () => onMarkAsPickedUp!(donation.donationId),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:secondaryColor ,
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
                        onPressed: () => onMarkAsCompleted!(donation.donationId),
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