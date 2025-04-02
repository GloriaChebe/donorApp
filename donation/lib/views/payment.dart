import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor:primaryColor,
        title: const Text(
          "Payment Method",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        
        foregroundColor:appwhiteColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       primaryColor,
        //       secondaryColor,
        //     ],
        //   ),
        // ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                // Header Section
                const Text(
                  "Select Your Preferred\nPayment Method",
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
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text("M-Pesa payment selected")),
                    // );
                  },
                ),
                
                const SizedBox(height: 16),
                
                _buildPaymentOption(
                  context,
                  title: "Credit/Debit Card",
                  subtitle: "Pay with Visa, Mastercard or other cards",
                  icon: Icons.credit_card,
                  color: Colors.blue.shade400,
                  onTap: () {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text("Card payment selected")),
                    // );
                  },
                ),
                
                const Spacer(),
                
                // Helper Text
              
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
}