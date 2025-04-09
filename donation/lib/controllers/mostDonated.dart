import 'package:flutter_application_1/models/mostDonated.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class TopDonationController extends GetxController {
  var topItems = <TopDonationItem>[].obs;
  var isLoading = false.obs;

  Future<void> fetchTopDonations() async {
    isLoading.value = true;

    final url = Uri.parse('https://sanerylgloann.co.ke/donorApp/mostDonated.php'); 
    try {
      final response = await http.get(url);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body['success'] == 1) {
          topItems.value = List<TopDonationItem>.from(
            body['data'].map((item) => TopDonationItem.fromJson(item)),
          );
        } else {
          topItems.clear();
        }
      } else {
        // Handle HTTP error
        print("Failed to load: ${response.statusCode}");
      }
    } catch (e) {
      print("Something exploded: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
