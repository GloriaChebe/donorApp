import 'dart:convert';
import 'package:flutter_application_1/models/donationModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class DonationController extends GetxController {
  var donations = <Donation>[].obs;
  var userDonations = <Donation>[].obs;
  
  var isLoading = false.obs;
  var isLoadingUserDonations = false.obs;
  var openingStatus = <bool>[].obs;
   setOpeningStatus(index, val) {
  openingStatus[index]= val;
  openingStatus.refresh(); // Notify the UI to update.
  for (int i = 0; i < openingStatus.length; i++) {
    if (i != index) openingStatus[i] = !val;
  }
  update();
    
   }

  
  

  Future<void> fetchDonations(status) async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('https://sanerylgloann.co.ke/donorApp/readDonations.php?status=$status'),
      );
      print(response.body);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['success'] == 1) {
          final List<dynamic> data = jsonData['data'];

            donations.value = data.map((item) {
            return Donation(
              userID: item['userID'] ?? '',
              firstName: item['firstName'] ?? '',
              lastName: item['lastName'] ?? '',
              category: item['category'] ?? '',
              name: item['name'] ?? '',
              donationsID: item['donationsID'] ?? '',
              itemsID: item['itemsID'] ?? '',
              address: item['address'] ?? '',
              deliveryMethod: item['deliveryMethod'] ?? '',
              preferredDate: item['prefferedDate'] ?? '',
              preferredTime: item['prefferedTime'] ?? '',
              quantity: int.tryParse(item['quantity'].toString()) ?? 0,
              status: item['status'] ?? '',
              comments: item['comments'] ?? '',
              timestamp: item['timestamp'] ?? '',
            );
          }).toList();

         
        } else {
          Get.snackbar('Error', 'No data found');
        }
      } else {
        Get.snackbar('Error', 'Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoading(false);
    }
  }

    Future<void> fetchPersonalDonations(userID) async {
    try {
      isLoadingUserDonations(true);
      final response = await http.get(
        Uri.parse('https://sanerylgloann.co.ke/donorApp/readPersonalDonations.php?userID=$userID'),
       
      );
      print(response.body);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['success'] == 1) {
          final List<dynamic> data = jsonData['data'];

            userDonations.value = data.map((item) {
            return Donation(
              userID: item['userID'] ?? '',
              firstName: item['firstName'] ?? '',
              lastName: item['lastName'] ?? '',
              category: item['category'] ?? '',
              name: item['name'] ?? '',
              donationsID: item['donationsID'] ?? '',
              itemsID: item['itemsID'] ?? '',
              address: item['address'] ?? '',
              deliveryMethod: item['deliveryMethod'] ?? '',
              preferredDate: item['prefferedDate'] ?? '',
              preferredTime: item['prefferedTime'] ?? '',
              quantity: int.tryParse(item['quantity'].toString()) ?? 0,
              status: item['status'] ?? '',
              comments: item['comments'] ?? '',
              timestamp: item['timestamp'] ?? '',
              
            );
          }).toList();
          print("testing");
           openingStatus.assignAll(List.filled(userDonations.length, false));
           print("here ${openingStatus.length}");
             print("testing2");
          
        } else {
          Get.snackbar('Error', 'No data found');
        }
      } else {
        Get.snackbar('Error', 'Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoadingUserDonations(false);
    }
  }
}