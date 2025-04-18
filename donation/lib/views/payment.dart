import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/mpesa/initializer.dart';
import 'package:flutter_application_1/mpesa/payment_enums.dart';
import 'package:flutter_application_1/views/status.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final TextEditingController amountController = TextEditingController();


//mpesa keys for bill
const mConsumerSecret = "uHjtGaaApc2MShGw";
const mConsumerKey = "JcGnu7ytS4pGNW7GiCaT1jKfDlRw3x4Q";
const mPassKey = "da1ea4e78c9c307f67b9ffb3cd2fcfafa7d729c6132a4f31ac4d8b26c8c7ba43";
var store = GetStorage();

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MpesaFlutterPlugin.setConsumerKey(mConsumerKey);
    MpesaFlutterPlugin.setConsumerSecret(mConsumerSecret);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Payment Method",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: appwhiteColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                // Header Section
                const Text(
                  "Make Payment",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: appBlackColor,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Payment Options
                _buildPaymentOption(
                  context,
                  title: "M-Pesa",
                  subtitle: "Fast and convenient mobile payment",
                  icon: Icons.phone_android,
                  color: Colors.green.shade400,
                  onTap: () {
                    final phoneController = TextEditingController();
                    final amountController = TextEditingController();

                    showDialog(
                      context: context,
                      builder: (context) {
                        phoneController.text = store.read('phoneNumber') ?? '';
                        return AlertDialog(
                          title: Text("M-Pesa Payment"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: "Phone Number",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 16),
                              TextField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Amount",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancel"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              onPressed: () {
                                var phone = phoneController.text.trim();
                                var amount = amountController.text.trim();

                                if (phone.isEmpty || amount.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Please fill in all fields")),
                                  );
                                } else {
                                  print("pay");
                                  Navigator.pop(context);
                                  _startCheckout(amount, phone, "donation");
                                }
                              },
                              child: Text(
                                "Proceed to Pay",
                                style: TextStyle(color: appwhiteColor),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _startCheckout(
    String billAmount,
    String phone,
   String billID,
  ) async {
    print("pay");
    try {
      final transactionInitialization =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "7926509",
        transactionType: TransactionTypes.CustomerBuyGoodsOnline,
        amount: double.parse(billAmount),
        partyA: phone.replaceRange(0, 1, "254"),
        partyB: "5619373",
        callBackURL: Uri.parse("https://echama.agilecode.co.ke/public/api/payment/callback"),
        accountReference: "Payment",
        phoneNumber: phone.replaceRange(0, 1, "254"),
        baseUri: Uri(scheme: "https", host: "api.safaricom.co.ke"),
        transactionDesc: "Payment for Bill ID $billID",
        passKey: mPassKey,
      );

      final merchantRequestID = transactionInitialization['MerchantRequestID'];
      //print("Merchant Request ID: $merchantRequestID");

      await _postDonationToDatabase(billAmount); 
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _postDonationToDatabase(String amount ) async {
    final userID = store.read('userID'); 
    if (userID == null) {
      print("User ID not found. Please log in again.");
      return;
    }

    final url = Uri.parse("https://sanerylgloann.co.ke/donorApp/createDonations.php");

    try {
      final response = await http.post(
        url,
        body: {
          'userID': userID.toString(),
          'amount': amount, 
          
          'itemsID': "13",
          'status': '',
          'prefferedDate': '',
          'prefferedTime': '',
          'quantity': '',
          'address': '',
          'deliveryMethod': '',
          'comments': '',


          
        },
      );
print(response.body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          print("Donation successfully posted to the database.");
          amountController.clear(); // Clear the controller after successful submission
        } else {
          print("Failed to post donation: ${responseData['message']}");
        }
      } else {
        print("Failed to post donation. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error posting donation to the database: $e");
    }
  }
}
