import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/controllers/homeController.dart';
import 'package:flutter_application_1/views/categories.dart';

import 'package:flutter_application_1/views/home/homePage.dart';
import 'package:flutter_application_1/views/profile.dart';
import 'package:flutter_application_1/views/status.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'package:google_nav_bar/google_nav_bar.dart';


HomeController homeController = Get.put(HomeController());

class navPage extends StatelessWidget {
  final List<Widget> screens = [
    HomePage(),
    CategoriesPage(),
    Statuspage(),
    ProfilePage(), // Ensure ProfilePage is included here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => screens[homeController.selectedPage.value]),
      bottomNavigationBar: GNav(
        color: secondaryColor,
        backgroundColor: primaryColor.withOpacity(0.2),
        tabBackgroundColor: primaryColor.withOpacity(0.5),
        tabs: [
          GButton(
            icon: Icons.home,
            iconColor: appBlackColor,
            text: 'Home',
          ),
          GButton(
            icon: Icons.category,
            iconColor: appBlackColor,
            text: 'Categories',
          ),
           GButton(
            icon: Icons.chat,
            iconColor: appBlackColor,
            text: 'Status',
          ),
          GButton(
            icon: Icons.person,
            iconColor: appBlackColor,
            text: 'Profile',
          ),
        ],
        selectedIndex: homeController.selectedPage.value,
        onTabChange: (index) {
          homeController.updateselectedpage(index);
        },
      ),
    );
  }
}
