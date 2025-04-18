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
      length: 5, 
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
      status = "Rejected";
      break;
    case 3:
      status = "PickedUp";
      case 4:
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
              Tab(text: 'Approved', icon: Icon(Icons.check_circle)),
              Tab(text: 'Rejected', icon: Icon(Icons.cancel,color: Color.fromARGB(255, 232, 12, 12),)),
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
               
                onApprove: null,
                onReject: null,
                onMarkAsPickedUp: null, // No "Mark as Picked Up" for picked up donations
                onMarkAsCompleted: (donation) {
                  // Handle mark as completed action
                },
               
              ),
              // Completed Donations Tab
              DonationList(
                //donations: donationController.donations,
                onApprove: null,
                onReject: null,
                onMarkAsPickedUp: null,
                onMarkAsCompleted: null, // No actions for completed donations
              ),
              // Additional Tab
              DonationList(
                onApprove: null,
                onReject: null,
                onMarkAsPickedUp: null,
                onMarkAsCompleted: null, // No actions for this additional tab
              ),
            ],
          ),
        ),
      ),
    );
  } 
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
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Donor: ${donation.firstName?.isNotEmpty == true ? donation.firstName : 'N/A'} '
          '${donation.lastName?.isNotEmpty == true ? donation.lastName : 'N/A'}, '
          '${donation.userID ?? 'N/A'}',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Donation ID: ${donation.donationsID ?? 'N/A'}',
          style: TextStyle(fontSize: 12),
        ),
        Text(
          'Item: ${donation.name?.isNotEmpty == true ? donation.name : 'N/A'}',
          style: TextStyle(fontSize: 12),
        ),
        Text(
          'Quantity: ${donation.quantity?.toString().isNotEmpty == true ? donation.quantity : 'N/A'}',
          style: TextStyle(fontSize: 12),
        ),
        Text(
          'Address: ${donation.address?.isNotEmpty == true ? donation.address : 'N/A'}',
          style: TextStyle(fontSize: 12),
        ),
        Text(
          'Delivery Method: ${donation.deliveryMethod == '0' ? 'Drop Off' : donation.deliveryMethod == '1' ? 'Schedule Pickup' : 'N/A'}',
          style: TextStyle(fontSize: 12),
        ),
        Text(
          'Preferred Date: ${donation.preferredDate?.isNotEmpty == true ? donation.preferredDate : 'N/A'}',
          style: TextStyle(fontSize: 12),
        ),
        Text(
          'Preferred Time: ${donation.preferredTime?.isNotEmpty == true ? donation.preferredTime : 'N/A'}',
          style: TextStyle(fontSize: 12),
        ),
        Text(
          'Status: ${donation.status ?? 'N/A'}',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: donation.status == 'Pending'
                ? Colors.orange
                : donation.status == 'Approved'
                    ? Colors.green
                    : donation.status == 'Rejected'
                        ? Colors.red
                        : donation.status == 'PickedUp'
                            ? Colors.blue
                            : Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (onApprove != null)
              ElevatedButton(
                onPressed: () async {
                  var res = await http.get(
                    Uri.parse('https://sanerylgloann.co.ke/donorApp/rejectApprove.php?donationsID=${donation.donationsID}&status=Approved'),
                  );
                  if (res.statusCode == 200) {
                    donationController.fetchDonations("Pending");
                    Get.snackbar('Success', 'Donation Approved',
                        backgroundColor: secondaryColor,
                        colorText: Colors.white);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 4, 101, 22),
                ),
                child: Text('Approve', style: TextStyle(color: Colors.white)),
              ),
            if (onReject != null) SizedBox(width: 8),
            if (onReject != null)
              ElevatedButton(
                onPressed: () async {
                  var res = await http.get(
                    Uri.parse('https://sanerylgloann.co.ke/donorApp/rejectApprove.php?donationsID=${donation.donationsID}&status=Rejected'),
                  );
                  if (res.statusCode == 200) {
                    donationController.fetchDonations("Pending");
                    Get.snackbar('Success', 'Donation Rejected',
                        colorText: Colors.white
                        ,backgroundColor: secondaryColor)
                      ;
                       
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 232, 12, 12),
                ),
                child: Text('Reject', style: TextStyle(color: Colors.white)),
              ),
            if (donation.status == 'Rejected') SizedBox(width: 8),
            if (donation.status == 'Rejected')
              ElevatedButton(
                onPressed: () async {
                  var res = await http.get(
                    Uri.parse('https://sanerylgloann.co.ke/donorApp/rejectApprove.php?donationsID=${donation.donationsID}&status=Pending'),
                  );
                  if (res.statusCode == 200) {
                    donationController.fetchDonations("Rejected");
                    Get.snackbar('Notice', 'Donation Revoked',
                        colorText: Colors.white,
                        backgroundColor: secondaryColor);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: Text('Revoke', style: TextStyle(color: Colors.white)),
              ),
            if (onMarkAsPickedUp != null) SizedBox(width: 8),
            if (onMarkAsPickedUp != null)
              ElevatedButton(
                onPressed: () async {
                  var res = await http.get(
                    Uri.parse('https://sanerylgloann.co.ke/donorApp/rejectApprove.php?donationsID=${donation.donationsID}&status=PickedUp'),
                  );
                  if (res.statusCode == 200) {
                    donationController.fetchDonations("Approved");
                    Get.snackbar('Success', 'On Transit',
                        colorText: Colors.white
                        ,backgroundColor: secondaryColor);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                ),
                child: Text('Mark as Picked Up',
                    style: TextStyle(color: Colors.white)),
              ),
            if (donation.status == 'PickedUp') SizedBox(width: 8),
            if (donation.status == 'PickedUp')
              ElevatedButton(
                onPressed: () async {
                  var res = await http.get(
                    Uri.parse('https://sanerylgloann.co.ke/donorApp/rejectApprove.php?donationsID=${donation.donationsID}&status=Completed'),
                  );
                  if (res.statusCode == 200) {
                    donationController.fetchDonations("PickedUp");
                    Get.snackbar('Success', 'Completed',
                        colorText: Colors.white,
                        backgroundColor: secondaryColor);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                ),
                child:
                    Text('Mark as Completed', style: TextStyle(color: Colors.white)),
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