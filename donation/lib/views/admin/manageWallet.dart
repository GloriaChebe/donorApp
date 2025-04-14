import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:get/get.dart'; // Import GetX package
import 'package:flutter_application_1/controllers/statisticsController.dart'; // Import your statistics controller

class ManageWalletPage extends StatelessWidget {
  final DashboardController amountController = Get.find(); // Get the controller instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appwhiteColor),
          onPressed: () {
            Navigator.pushNamed(context, '/admin');
          },
        ),
        title: const Text(
          'Wallet',
          style: TextStyle(fontWeight: FontWeight.w600, color: appwhiteColor),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Wallet Balance Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade200.withOpacity(0.5),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: Colors.white70,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Wallet Balance',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Obx(() {
                        // Dynamically fetch and display the wallet balance
                        final balance = amountController.summary.value?.amount ?? '0.00';
                        return Text(
                          'Ksh $balance',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Recent Activity Section
              Padding(
                padding: const EdgeInsets.only(left: 4.0, bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Recent Transactions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Example Transaction Item
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: Icon(Icons.add, color: Colors.green.shade700),
                ),
                title: const Text('Deposit'),
                subtitle: const Text('Apr 1, 2025'),
                trailing: const Text(
                  '+Ksh 250.00',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}