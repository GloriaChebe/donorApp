import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Payment Method"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // Handle Mpesa payment logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Mpesa payment selected")),
                );
              },
              icon: Icon(Icons.phone_android),
              label: Text("Pay with Mpesa"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // Handle card payment logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Card payment selected")),
                );
              },
              icon: Icon(Icons.credit_card),
              label: Text("Pay with Card"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}