import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/controllers/donationController.dart';
import 'package:flutter_application_1/views/categories.dart';
import 'package:flutter_application_1/views/home/homePage.dart';
import 'package:flutter_application_1/views/nav.dart';
import 'package:flutter_application_1/widgets/statusWidget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';

import 'package:step_progress_indicator/step_progress_indicator.dart' as step_progress;
final DonationController donationController=DonationController();
var store= GetStorage();
class Statuspage extends StatefulWidget {
   var donationId;
   var currentStatus;
   var itemName;
   var quantity;
   var pickupOption;
   DateTime? pickupDate;
   TimeOfDay? pickupTime;

  Statuspage({
    this.donationId,
     this.currentStatus,
     this.itemName,
    this.quantity,
     this.pickupOption,
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
    // Fetch the donation data from the controller  
    donationController.fetchPersonalDonations(store.read('userID'));
   
    return Scaffold(
     appBar: AppBar(
  automaticallyImplyLeading: false,
  // leading: IconButton(
  //   icon: Icon(Icons.arrow_back, color: appwhiteColor),
  //   onPressed: () {
  //     Navigator.pop(context); // or Navigator.pushNamed(context, '/categories');
  //   },
  // ),
  actions: [
    TextButton(
      onPressed: () {
       // Navigator.pushNamed(context, '/categories'); // replace with your actual route
        //Get.to(CategoriesPage()); 
        Get.to(navPage());
      },
      child: Text(
        'Back',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ],
  foregroundColor: appwhiteColor,
  title: Text('Donation Status', style: TextStyle(color: Colors.white)),
  backgroundColor: primaryColor,
),

      body:Obx(()=> ListView.builder(
          itemCount: donationController.userDonations.length, // Only one item in this case
          itemBuilder:   (context, index) => Column(
          children: [
         
            StatusCard(
              donationId: donationController.userDonations[index].donationsID,
              currentStatus: donationController.userDonations[index].status,
              itemName: donationController.userDonations[index].name,
              quantity:donationController.userDonations[index].quantity,
              pickupOption: donationController.userDonations[index].deliveryMethod=='0'
                  ? 'Pickup'
                  :'Drop Off'
                      ,
              pickupDate: donationController.userDonations[index].preferredDate != null
                  ? DateTime.parse(donationController.userDonations[index].preferredDate)
                  : null,
              pickupTime:donationController.userDonations[index].preferredTime != null
                  ? TimeOfDay(
                      hour: int.parse(donationController.userDonations[index].preferredTime.split(':')[0]),
                      minute: int.parse(donationController.userDonations[index].preferredTime.split(':')[1]),
                    )
                  : null,
              showFullDetails: donationController.openingStatus[index],
              onToggleDetails: () {
                print("clicked $index");
                donationController.setOpeningStatus(index, !donationController.openingStatus[index]);
              },
            ),
            SizedBox(height: 20),
            
            Obx(()=>Visibility(
                visible:donationController. openingStatus[index],
                child: SizedBox(
                  height: 160,
                  
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
                                  currentStep: _getStepIndex(donationController.userDonations[index].status) + 1,
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
                                _getStatusDescription(donationController.userDonations[index].status),
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
            ),
          ],
        ),),
      )
     
    );
  }

  int _getStepIndex(String status) {
    switch (status) {
      case 'Pending':
        return 0;
      case 'Approved':
        return 1;
      case 'Rejected':
        return 2;
      case 'PickedUP':
        return 3;
        case 'Completed':
        return 4;
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
        return 'Unfortunately, your donation request could not be accepted at this time.';
      default:
        return 'Status information not available. Please contact administrator for more details.';
    }
  }
}