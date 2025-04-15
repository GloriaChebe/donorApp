import 'dart:convert';
import 'package:flutter_application_1/models/donationModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MoneyReportsController extends GetxController {
  var moneyDonations = <Donation>[].obs;
  var isLoadingMoney = false.obs;

  Future<void> fetchMoneyDonations() async {
    try {
      isLoadingMoney(true);

      final response = await http.get(
        Uri.parse('https://sanerylgloann.co.ke/donorApp/readTransactions.php'),
      );
      print("Raw Money Response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['success'] == 1 && jsonData['data'] is List) {
          final List<dynamic> data = jsonData['data'];

          moneyDonations.value = data.map((item) {
            return Donation(
              userID: item['userID'] ?? '',
              firstName: item['firstName'] ?? '',
              lastName: item['lastName'] ?? '',
              category: item['category'] ?? '',
              name: item['name'] ?? '',
              donationsID: item['donationsID'] ?? '',
              itemsID: item['itemsID'] ?? '',
              quantity: int.tryParse(item['quantity']?.toString() ?? '0') ?? 0,
              status: item['status'] ?? '',
              address: item['address'] ?? '',
              deliveryMethod: item['deliveryMethod'] ?? '',
              preferredDate: item['prefferedDate'] ?? '',
              preferredTime: item['prefferedTime'] ?? '',
              timestamp: item['timestamp'] ?? '',
              comments: item['comments'] ?? '',
              amount: item['amount'] ?? '0',
            );
          }).toList();
        } else {
          Get.snackbar('Error', 'No money donations found.');
        }
      } else {
        Get.snackbar('Error', 'Failed to load money donations: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoadingMoney(false);
    }
  }
}
