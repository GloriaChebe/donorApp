import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/views/categories.dart';
import 'package:flutter_application_1/views/donate.dart';
import 'package:flutter_application_1/views/payment.dart';

class UrgentProduct {
  final String name;
  final String imageUrl;
  
  UrgentProduct({required this.name, required this.imageUrl});
}

class DonatedProduct {
  final String name;
  
  
  DonatedProduct({required this.name, });
}

class HomePage extends StatelessWidget {
  final List<UrgentProduct> urgentProducts = [
    UrgentProduct(name: "Money", imageUrl: "/images/money1.jpeg"),
    UrgentProduct(name: "Mangoes", imageUrl: "assets/images/mangoes.png"),
    UrgentProduct(name: "Cow skin", imageUrl: "assets/images/skin.png"),
    UrgentProduct(name: "Solar Panels", imageUrl: "assets/images/solar_panels.png"),
    
  ];
  
  final List<DonatedProduct> topDonatedProducts = [
    DonatedProduct(name: "Oranges", ),
    DonatedProduct(name: "Banana Stems", ),
    DonatedProduct(name: "Honey", ),
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
            
            // Urgent Products - Horizontal Scroll with Images
            SizedBox(
              height: 200, // Increased height to fit the content and avoid overflow
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8),
                itemCount: urgentProducts.length,
                itemBuilder: (context, index) {
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
                              urgentProducts[index].imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.image, color: Colors.blue);
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          urgentProducts[index].name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            if (urgentProducts[index].name == "Money") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PaymentPage()),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DonatePage(
                                    itemName: urgentProducts[index].name,
                                  ),
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
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 250,
                    child: PodiumChart(topProducts: topDonatedProducts),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Continue to Make Donation Button
           // Continue to Make Donation Button
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Continue to Make Donation",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(width: 12),
      GestureDetector(
        onTap: () {
          // Navigate to the CategoriesPage or the appropriate page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoriesPage()),
          );
        },
        child: Icon(
          Icons.arrow_forward,
          size: 36,
          color: secondaryColor , // Optional: Add color to the arrow
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
}

// Podium Chart Widget
class PodiumChart extends StatelessWidget {
  final List<DonatedProduct> topProducts;
  
  PodiumChart({required this.topProducts});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Base platform
        Positioned(
          bottom: 0,
          child: Container(
            width: 300,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Second place
            PodiumBar(
              height: 140,
              color: Colors.amber.shade400,
              rank: 2,
              productName: topProducts[1].name,
             
            ),
            SizedBox(width: 8),
            // First place (tallest in the middle)
            PodiumBar(
              height: 200,
              color: primaryColor,
              rank: 1,
              productName: topProducts[0].name,
              
            ),
            SizedBox(width: 8),
            // Third place
            PodiumBar(
              height: 120,
              color: Colors.teal.shade400,
              rank: 3,
              productName: topProducts[2].name,
             
            ),
          ],
        ),
      ],
    );
  }
}

// Podium Bar Widget
class PodiumBar extends StatelessWidget {
  final double height;
  final Color color;
  final int rank;
  final String productName;
 

  PodiumBar({
    required this.height,
    required this.color,
    required this.rank,
    required this.productName,
  
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Product name on top
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: secondaryColor.withOpacity(0.02),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Text(
            productName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(height: 6),
       
        // Podium bar
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              "$rank",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}