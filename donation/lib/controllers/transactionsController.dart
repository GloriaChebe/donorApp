import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransactionsController extends GetxController {
  var transactions = [].obs; // Observable list to hold transactions
  var isLoading = true.obs; // Observable to track loading state

  @override
  void onInit() {
    super.onInit();
    fetchTransactions(); // Fetch transactions when the controller is initialized
  }

  Future<void> fetchTransactions() async {
    const url = "https://sanerylgloann.co.ke/donorApp/readTransactions.php";

    try {
      isLoading(true);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == 1) {
          transactions.value = data['data']; // Update the transactions list
        } else {
          print("Failed to fetch transactions: ${data['message']}");
        }
      } else {
        print("Failed to fetch transactions. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching transactions: $e");
    } finally {
      isLoading(false);
    }
  }
}