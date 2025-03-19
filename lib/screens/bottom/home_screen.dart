import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/configs/viewmodels/reg_view_model.dart';
import 'package:v1_micro_finance/configs/widgets/app_drawer.dart';
import 'package:v1_micro_finance/configs/widgets/appbar.dart';
import 'package:v1_micro_finance/screens/dashboard/check_balance_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/deposit_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/help_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/packages_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/policies.dart';
import 'package:v1_micro_finance/screens/dashboard/quick_loan_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/referrals_screen.dart';
import 'package:v1_micro_finance/screens/deposit/balance_screen.dart';
import 'package:v1_micro_finance/screens/policies/about_us.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<UserRegistrationViewModel>(context, listen: false);

    // Fetch initial user data
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   vm.fetchUserData();
    // });

    // Grid items configuration
    final List<Map<String, dynamic>> dashboardItems = [
      {"icon": Icons.add, "label": "Deposit", "screen": const DepositScreen()},
      {
        "icon": Icons.paid_outlined,
        "label": "Check Balance",
        "screen": const CheckBalanceScreen()
      },

      {
        "icon": Icons.credit_card,
        "label": "Quick Loan",
        "screen": const QuickLoanScreen()
      }, //QuickLoanScreen
      {
        "icon": Icons.people,
        "label": "Referrals",
        "screen": const ReferralsScreen()
      }, //ReferralsScreen
      {
        "icon": Icons.card_giftcard,
        "label": "Saving Plan",
        "screen": const PackagesScreen()
      }, //Saving Plan

      {
        "icon": Icons.contact_support,
        "label": "help",
        "screen": const HelpScreen()
      }, //HelpScreen
      {
        "icon": Icons.policy_outlined,
        "label": "Policies",
        "screen": Policies()
      }, //Policies
      {"icon": Icons.info, "label": "About Us", "screen": AboutUs()},
    ];

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 1,
          ),
          itemCount: dashboardItems.length,
          itemBuilder: (context, index) =>
              _buildGridItem(context, dashboardItems[index]),
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => item["screen"] as Widget),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFEF7FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item["icon"] as IconData,
                size: 50, color: const Color(0xFF06426D)),
            const SizedBox(height: 10),
            Text(
              item["label"] as String,
              style: const TextStyle(color: Color(0xFF06426D), fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
