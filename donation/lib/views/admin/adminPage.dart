import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/controllers/donationController.dart';
import 'package:flutter_application_1/controllers/reportsController.dart';
import 'package:flutter_application_1/controllers/statisticsController.dart';
import 'package:flutter_application_1/models/donationModel.dart';
import 'package:flutter_application_1/views/admin/notification.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:badges/badges.dart' as badges;

DashboardController statiticsController = Get.put(DashboardController());

class AdminPage extends StatefulWidget {
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
   // statiticsController.fetchDashboardSummary();
    _fetchUnreadCount();
  }

  Future<void> _fetchUnreadCount() async {
    final count = await NotificationPage.fetchUnreadCount();
    setState(() {
      unreadCount = count;
    });
  }

  Widget build(BuildContext context) {
    statiticsController.fetchDashboardSummary();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Admin Dashboard',
          style: TextStyle(color: appwhiteColor),
        ),
        backgroundColor: primaryColor,
        actions: [
          // Notification Icon with Badge
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            badgeContent: Text(
              unreadCount.toString(),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            showBadge: unreadCount > 0,
            child: IconButton(
              icon: Icon(Icons.notifications, color: appwhiteColor),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
                // Refresh unread count after returning from NotificationPage
                _fetchUnreadCount();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout, color: appwhiteColor),
            onPressed: () {
              Navigator.pushNamed(context, '/navpage');
            },
          ),
        ],
      ),
      body: Container(
         decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade50, Colors.white],
            ),
         ),
         child: Column(
         
          children: [
            // Key Statistics Card
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(() {
                    if (statiticsController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final summary = statiticsController.summary.value;
                    if (summary == null) {
                      return Center(child: Text('No data available'));
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Statistics',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: appBlackColor,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStatisticItem(
                              title: 'Total Donations',
                              value: summary.totalDonations.toString(),
                              icon: Icons.volunteer_activism,
                              color: Colors.green,
                            ),
                            _buildStatisticItem(
                              title: 'Pending Approvals',
                              value: summary.pendingApprovals.toString(),
                              icon: Icons.pending_actions,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStatisticItem(
                              title: 'Total Users',
                              value: summary.totalUsers.toString(),
                              icon: Icons.people,
                              color: Colors.blue,
                            ),
                            _buildStatisticItem(
                              title: 'Wallet Balance',
                              value: 'ksh ${summary.amount}', // Placeholder for now
                              icon: Icons.account_balance_wallet,
                              color: Colors.purple,
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            // Admin Cards
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(16),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildAdminCard(
                    context,
                    title: 'Manage Donations',
                    icon: Icons.volunteer_activism,
                    onTap: () {
                      Navigator.pushNamed(context, '/manageDonations');
                    },
                  ),
                 _buildAdminCard(
                    context,
                    title: 'Manage Items',
                    icon: Icons.inventory,
                    onTap: () {
                      Navigator.pushNamed(context, '/categoriesAdmin');
                    },
                  ),
                  _buildAdminCard(
                    context,
                    title: 'Wallet',
                    icon: Icons.wallet,
                    onTap: () {
                      Navigator.pushNamed(context, '/manageWallet');
                    },
                  ),
                  
                   _buildAdminCard(
                    context,
                    title: 'Users',
                    icon: Icons.people,
                    onTap: () {
                      Navigator.pushNamed(context, '/manageUsers');
                    },
                  ),
                ],
              ),
            ),
            // Donations Report Card
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Donations Report',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: appBlackColor,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/moneyDonations');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: Icon(Icons.attach_money, color: Colors.white),
                            label: Text('Money Donations',style: TextStyle(color: appwhiteColor),),
                          ),
                         ElevatedButton.icon(
                      onPressed: () async {
                         final ReportsController controller = Get.put(ReportsController());
                          await controller.fetchDonations(); // or any status you want
                               await generateItemDonationsPdf(controller.donations);
                                 },
                           style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                               ),
                   icon: Icon(Icons.card_giftcard, color: Colors.white),
                            label: Text('Item Donations', style: TextStyle(color: appwhiteColor)),
                                      ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
            ),
      );
  }

  Widget _buildStatisticItem({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: secondaryColor.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdminCard(BuildContext context,
      {required String title, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: secondaryColor),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}



Future<void> generateItemDonationsPdf(List<Donation> donations) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      build: (pw.Context context) => [
        pw.Text('Item Donations Report',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 20),
        pw.Table.fromTextArray(
          border: pw.TableBorder.all(),
          cellStyle: pw.TextStyle(fontSize: 10),
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          headers: [
            'Donation ID',
            'User ID',
            'Name',
            'Item',
            'Quantity',
            'Status',
            'Address',
            'Delivery Method',
            'Preferred Date',
            'Preferred Time',
            'Time Donated'
          ],
          data: donations.map((donation) {
            return [
              donation.donationsID,
              donation.userID,
              '${donation.firstName} ${donation.lastName}',
              donation.name,
              donation.quantity.toString(),
              donation.status,
              donation.address,
              donation.deliveryMethod,
              donation.preferredDate,
              donation.preferredTime,
              donation.timestamp, // Assuming this holds timestamp info
            ];
          }).toList(),
        )
      ],
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
