import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Admin Dashboard',
          style: TextStyle(color: appwhiteColor),
        ),
        backgroundColor: primaryColor,
        actions: [
          // Notification Icon
          IconButton(
            icon: Icon(Icons.notifications, color: appwhiteColor),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          
          IconButton(
            icon: Icon(Icons.logout, color: appwhiteColor),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
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
                  child: Column(
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
                            value: '120',
                            icon: Icons.volunteer_activism,
                            color: Colors.green,
                          ),
                          _buildStatisticItem(
                            title: 'Pending Approvals',
                            value: '15',
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
                            title: 'Total Donors',
                            value: '85',
                            icon: Icons.people,
                            color: Colors.blue,
                          ),
                          _buildStatisticItem(
                            title: 'Wallet Balance     ',
                            value: '\$1,250',
                            icon: Icons.account_balance_wallet,
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ],
                  ),
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
                      Navigator.pushNamed(context, '/manageItems');
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