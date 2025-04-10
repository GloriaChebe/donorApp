import 'dart:convert';
import 'package:flutter_application_1/models/statisticsModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class DashboardController extends GetxController {
  var summary = Rxn<DashboardSummary>();
  var isLoading = false.obs;

  Future<void> fetchDashboardSummary() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('https://sanerylgloann.co.ke/donorApp/readStatistics.php'), 
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['success'] == 1) {
          summary.value = DashboardSummary.fromJson(jsonData['data']);
        } else {
          Get.snackbar('Error', 'Failed to fetch summary data');
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
