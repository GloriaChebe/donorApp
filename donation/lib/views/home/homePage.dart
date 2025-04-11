import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/itemController.dart';
import 'package:flutter_application_1/controllers/mostDonated.dart';
import 'package:flutter_application_1/models/donatedProduct.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/models/urgentProduct.dart';

import 'package:flutter_application_1/views/donate.dart';
import 'package:flutter_application_1/views/home/podiumChart.dart';
import 'package:flutter_application_1/views/payment.dart';
import 'package:flutter_application_1/views/categories.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
var storage= GetStorage();

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 String role =storage.read('role')??"";

    String firstName =storage.read('firstName')??"";

       String userID =storage.read('userID')??"";

 ItemController itemController = Get.put(ItemController());

 TopDonationController mostDonatedController = Get.put(TopDonationController());

  @override
  //init
  void initState() {
    super.initState();
    // Fetch data when the widget is first builts
    itemController.fetchUrgentDonationItems();
    mostDonatedController.fetchTopDonations();
  }
  Widget build(BuildContext context) {
    //itemController.fetchDonationItems();
   
    print("home"+role);
    print("home"+firstName);
     print("home"+userID);
    itemController.fetchUrgentDonationItems();
    mostDonatedController.fetchTopDonations();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Welcome $firstName!",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
         if(role.compareTo("1")==0) IconButton(
            icon: Icon(Icons.admin_panel_settings, color: appwhiteColor),
            onPressed: () {
              Navigator.pushNamed(context, '/admin');
            },
          ),
         
        ],
       
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
              height: 201,
              child: Obx(() {
                if (itemController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (itemController.urgentItems.isEmpty) {
                  return Center(child: Text("No urgent items available"));
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  itemCount: itemController.urgentItems.length,
                  itemBuilder: (context, index) {
                    return _buildUrgentProductCard(context, itemController.urgentItems[index]);
                  },
                );
              }),
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
                  Obx(() {
                    if (mostDonatedController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (mostDonatedController.topItems.isEmpty) {
                      return Center(child: Text("No donated products available"));
                    }
                    return PodiumChart(topProducts: mostDonatedController.topItems);
                  }),
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

  Widget _buildUrgentProductCard(BuildContext context, DonationItem product) {
    return Container(
      width: 145,
      
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
            // child: ClipRRect(
            //   borderRadius: BorderRadius.circular(8),
            //   child: Image.network('https://sanerylgloann.co.ke/donorApp/itemImages/'+product.image,
            //     fit: BoxFit.cover,
            //     errorBuilder: (context, error, stackTrace) {
            //       return Icon(Icons.image, color: Colors.blue);
            //     },
            //   ),
            // ),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
       imageUrl: "https://sanerylgloann.co.ke/donorApp/itemImages/"+product.image,
       progressIndicatorBuilder: (context, url, downloadProgress) => 
               CircularProgressIndicator(value: downloadProgress.progress),
       errorWidget: (context, url, error) => Icon(Icons.error),
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
                    builder: (context) => DonatePage(itemName: product.name,itemsID: product.itemsID,  ),
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