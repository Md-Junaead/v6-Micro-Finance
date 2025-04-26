import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/configs/routes/routes_name.dart';
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch the logged-in user's name from AuthViewModel
    final user = Provider.of<AuthViewModel>(context).user;

    return Drawer(
      backgroundColor: Color(0xFF06426D), // Background color of the drawer
      child: SingleChildScrollView(
        // Makes the drawer scrollable
        child: Column(
          children: [
            // Cross Icon to close the drawer
            Padding(
              padding: EdgeInsets.only(right: 20, top: 20),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the drawer
                  },
                ),
              ),
            ),
            SizedBox(height: 20),

            // Drawer Header Section
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  // Profile Icon
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.person, size: 50, color: Color(0xFF06426D)),
                  ),
                  SizedBox(height: 10),
                  // Username Text - Updated to show logged-in user's name
                  Text(
                    user?.name ?? 'User', // Display actual user name or default
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Menu Section
            _buildMenuItem(context, Icons.account_balance_wallet, 'Deposit',
                () {
              Navigator.pushNamed(
                  context,
                  RoutesName
                      .balanceSaveScreen); // Replace with actual navigation
            }),
            _buildMenuItem(context, Icons.info, 'Package Info', () {
              Navigator.pushNamed(context,
                  RoutesName.packagesScreen); // Replace with actual navigation
            }),
            _buildMenuItem(context, Icons.receipt, 'Statement', () {
              Navigator.pushNamed(context,
                  RoutesName.statementScreen); // Replace with actual navigation
            }),
            _buildSubMenu(context, Icons.arrow_drop_down, 'Withdraw', [
              _buildMenuItem(
                  context, Icons.arrow_circle_down_rounded, 'Deposit Withdraw',
                  () {
                Navigator.pushNamed(
                    context,
                    RoutesName
                        .depositWithdrawScreen); // Replace with actual navigation
              }),
              _buildMenuItem(
                  context, Icons.arrow_circle_down_rounded, 'Profit Withdraw',
                  () {
                Navigator.pushNamed(
                    context,
                    RoutesName
                        .profitWithdrawScreen); // Replace with actual navigation
              }),
              _buildMenuItem(context, Icons.query_stats, 'Status', () {
                Navigator.pushNamed(
                    context,
                    RoutesName
                        .withdrawStatementScreen); // Replace with actual navigation
              }),
            ]),
            _buildMenuItem(context, Icons.link, 'Referral Link', () {
              Navigator.pushNamed(context,
                  RoutesName.referralsScreen); // Replace with actual navigation
            }),
            _buildMenuItem(context, Icons.exit_to_app, 'Log Out', () {
              Navigator.pushNamed(
                  context, '/logout'); // Replace with actual navigation
            }),
          ],
        ),
      ),
    );
  }

  // Method to build each menu item
  Widget _buildMenuItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }

  // Method to build sub-menu with expandable options (for Withdraw)
  Widget _buildSubMenu(BuildContext context, IconData icon, String title,
      List<Widget> subMenuItems) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      children: subMenuItems,
    );
  }
}
