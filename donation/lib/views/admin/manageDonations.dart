import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/controllers/donationController.dart';
import 'package:flutter_application_1/models/donationModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
 final DonationController donationController=DonationController();

class ManageDonationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    donationController.fetchDonations("Pending"); // Fetch donations when the page is built
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
            
               onTap: (index) {
  String status;
  switch (index) {
    case 0:
      status = "Pending";
      break;
    case 1:
      status = "Approved";
      break;
    case 2:
      status = "PickedUp";
      break;
    case 3:
      status = "Completed";
      break;
    default:
      status = "Pending";
  }
  donationController.fetchDonations(status);


            },
            unselectedLabelColor: appwhiteColor.withOpacity(0.7),
            tabs: [
              Tab(text: 'Pending', icon: Icon(Icons.pending_actions)),
              Tab(text: 'Approve', icon: Icon(Icons.check_circle)),
              Tab(text: 'PickedUp', icon: Icon(Icons.local_shipping)),
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
                //donations: donationController.donations,
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
                //donations: donationController.donations,
                onApprove: null, // No "Approve" for already approved donations
                onReject: null, // No "Reject" for already approved donations
                onMarkAsPickedUp: (donation) {
                  // Handle mark as picked up action
                },
                onMarkAsCompleted: null, // No "Mark as Completed" for approved donations
              ),
              // Picked Up Donations Tab
              DonationList(
               // donations: donationController.donations,
                onApprove: null,
                onReject: null,
                onMarkAsPickedUp: null, // No "Mark as Picked Up" for picked up donations
                onMarkAsCompleted: (donation) {
                  // Handle mark as completed action
                },
                // filterAction: ()=> {
                //   print('Picked Up Donations'),
                //   //donationController.donations.where((donation) => donation.status == 'PickedUp').toList(),
                //   donationController.updateList(donationController.originalDonations.where((donation) => donation.status == 'PickedUp').toList())
                // },

                
              ),
              // Completed Donations Tab
              DonationList(
                //donations: donationController.donations,
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
  

 
}

class DonationList extends StatelessWidget {
  
  final Function(String)? onApprove;
  final Function( String)? onReject;
  final Function( String)? onMarkAsPickedUp;
  final Function(String)? onMarkAsCompleted;
   VoidCallback ? filterAction;
  

  DonationList({
    
    this.onApprove,
    this.onReject,
    this.onMarkAsPickedUp,
    this.onMarkAsCompleted,
    this.filterAction,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
    Center(
      child: donationController.isLoading.value?
      SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          color: primaryColor,
          
        ),
      )
      // Center(
      //     child: Text(
      //       'No donations available',
      //       style: TextStyle(fontSize: 18, color: Colors.grey),
      //     ),
      //   )
        :Container(
        padding: EdgeInsets.all(16.0),
        child:
      ListView.builder(
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
                                : donation.status == 'PickedUp'
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
                            onPressed:()async{
                              var res= await http.get(
                                Uri.parse('https://sanerylgloann.co.ke/donorApp/rejectApprove.php?donationsID=${donation.donationsID}&status=Approved'),
                              );
                              if (res.statusCode==200){
                                donationController.fetchDonations("Pending");
                                Get.snackbar('Success', 'Donation Approved',
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                              }},

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
                            onPressed: () => onReject!(donation.donationsID),
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
                            onPressed: () => onMarkAsPickedUp!(donation.donationsID),
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
                            onPressed: () => onMarkAsCompleted!(donation.donationsID),
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
        ),
        ),
    )
    );
  }
}