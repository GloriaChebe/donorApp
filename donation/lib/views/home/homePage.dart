import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/donatedProduct.dart';
import 'package:flutter_application_1/models/urgentProduct.dart';

import 'package:flutter_application_1/views/donate.dart';
import 'package:flutter_application_1/views/home/podiumChart.dart';
import 'package:flutter_application_1/views/payment.dart';
import 'package:flutter_application_1/views/categories.dart';
import 'package:flutter_application_1/configs/constants.dart';

class HomePage extends StatelessWidget {
  final List<UrgentProduct> urgentProducts = [
    UrgentProduct(name: "Money", imageUrl: "assets/images/money1.jpeg"),
    UrgentProduct(name: "Mangoes", imageUrl: "assets/images/mangoes.png"),
    UrgentProduct(name: "Cow skin", imageUrl: "assets/images/skin.png"),
    UrgentProduct(name: "Solar Panels", imageUrl: "assets/images/solar_panels.png"),
  ];

  final List<DonatedProduct> topDonatedProducts = [
    DonatedProduct(name: "Oranges"),
    DonatedProduct(name: "Banana Stems"),
    DonatedProduct(name: "Honey"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Welcome Gloria!",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header for Most Required Items
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                "Most Required Items",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // Urgent Products - Horizontal Scroll
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8),
                itemCount: urgentProducts.length,
                itemBuilder: (context, index) {
                  return _buildUrgentProductCard(context, urgentProducts[index]);
                },
              ),
            ),

            SizedBox(height: 24),

            // Ranking Podium Section
            Container(
              padding: EdgeInsets.all(16),
              color: appwhiteColor.withOpacity(0.1),
              child: Column(
                children: [
                  Text(
                    "Most Donated Products",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  PodiumChart(topProducts: topDonatedProducts),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Continue to Make Donation Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Continue to Make Donation",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CategoriesPage()),
                      );
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      size: 36,
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUrgentProductCard(BuildContext context, UrgentProduct product) {
    return Container(
      width: 140,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image, color: Colors.blue);
                },
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            product.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              if (product.name == "Money") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPage()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DonatePage(itemName: product.name),
                  ),
                );
              }
            },
            child: Text("Donate"),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: appwhiteColor,
              textStyle: TextStyle(fontWeight: FontWeight.bold),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }
}