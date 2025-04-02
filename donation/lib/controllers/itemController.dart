import 'package:flutter_application_1/models/item.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ItemController extends GetxController {
  var isLoading = true.obs;
  var isUrgentLoading = true.obs;
  var items = <DonationItem>[].obs;
  var urgentItems = <DonationItem>[].obs;
  var filteredItems = <DonationItem>[].obs;
  var selectedCategory = 'All'.obs;

  final String apiUrl = "https://sanerylgloann.co.ke/donorApp/readItems.php";
  final String urgentApiUrl = "https://sanerylgloann.co.ke/donorApp/readUrgent.php";

  // Fetch donation items from the API
  Future<void> fetchDonationItems() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['success'] == 1) {
          var fetchedItems = (jsonData['data'] as List)
              .map((item) => DonationItem.fromJson(item))
              .toList();

          items.value = fetchedItems;
          filteredItems.value = fetchedItems;
        }
      } else {
        Get.snackbar("Error", "Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUrgentDonationItems() async {
    try {
      isUrgentLoading(true);
      final response = await http.get(Uri.parse(urgentApiUrl));
      print(response.body);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['success'] == 1) {
          var fetchedItems = (jsonData['data'] as List)
              .map((item) => DonationItem.fromJson(item))
              .toList();

          urgentItems.value = fetchedItems;
          filteredItems.value = fetchedItems;
        }
      } else {
        Get.snackbar("Error", "Failed to read most Urgent: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred in most Urgent: $e");
    } finally {
      isUrgentLoading(false);
    }
  }



  // Filter items based on category
  void filterItems(String category) {
    selectedCategory.value = category;
    if (category == 'All') {
      filteredItems.value = items;
    } else {
      filteredItems.value = items.where((item) => item.category == category).toList();
    }
  }

  // Search items
  void searchItems(String query) {
    if (query.isEmpty) {
      filterItems(selectedCategory.value);
    } else {
      filteredItems.value = items.where(
        (item) => item.name.toLowerCase().contains(query.toLowerCase()),
      ).toList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchDonationItems();
    fetchUrgentDonationItems();
  }
}
