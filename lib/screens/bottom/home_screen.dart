// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:v1_micro_finance/configs/viewmodels/reg_view_model.dart';
// import 'package:v1_micro_finance/configs/widgets/app_drawer.dart';
// import 'package:v1_micro_finance/configs/widgets/appbar.dart';
// import 'package:v1_micro_finance/screens/dashboard/help_screen.dart';
// import 'package:v1_micro_finance/screens/dashboard/packages_screen.dart';
// import 'package:v1_micro_finance/screens/dashboard/policies.dart';
// import 'package:v1_micro_finance/screens/dashboard/quick_loan_screen.dart';
// import 'package:v1_micro_finance/screens/dashboard/referrals_screen.dart';
// import 'package:v1_micro_finance/screens/deposit/balance_save.dart';
// import 'package:v1_micro_finance/screens/deposit/balance_screen.dart';
// import 'package:v1_micro_finance/screens/policies/about_us.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Access the registration view model
//     final vm = Provider.of<UserRegistrationViewModel>(context, listen: false);

//     // List of dashboard items with their respective icons and target screens
//     final List<Map<String, dynamic>> dashboardItems = [
//       {"icon": Icons.add, "label": "Deposit", "screen": BalanceSaveScreen()},
//       {
//         "icon": Icons.paid_outlined,
//         "label": "Package",
//         "screen": const BalanceScreen()
//       },
//       {
//         "icon": Icons.credit_card,
//         "label": "Quick Loan",
//         "screen": const QuickLoanScreen()
//       },
//       {
//         "icon": Icons.people,
//         "label": "Referrals",
//         "screen": const ReferralsScreen()
//       },
//       {
//         "icon": Icons.card_giftcard,
//         "label": "Saving Plan",
//         "screen": const PackagesScreen()
//       },
//       {
//         "icon": Icons.contact_support,
//         "label": "help",
//         "screen": const HelpScreen()
//       },
//       {
//         "icon": Icons.policy_outlined,
//         "label": "Policies",
//         "screen": Policies()
//       },
//       {"icon": Icons.info, "label": "About Us", "screen": AboutUs()},
//     ];

//     return Scaffold(
//       appBar: const CustomAppBar(),
//       drawer: const AppDrawer(),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: GridView.builder(
//           // Grid configuration with 2 columns and optimized aspect ratio
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, // 2 items per row
//             mainAxisSpacing: 0, // Vertical spacing between items
//             crossAxisSpacing: 5, // Horizontal spacing between items
//             childAspectRatio:
//                 1.2, // Width/height ratio (1.2:1 makes items wider than tall)
//           ),
//           itemCount: dashboardItems.length,
//           itemBuilder: (context, index) =>
//               _buildGridItem(context, dashboardItems[index]),
//         ),
//       ),
//     );
//   }

//   // Helper function to build grid items
//   Widget _buildGridItem(BuildContext context, Map<String, dynamic> item) {
//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => item["screen"] as Widget),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           color: const Color(0xFFFEF7FF),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(item["icon"] as IconData,
//                 size: 50, // Fixed icon size for consistency
//                 color: const Color(0xFF06426D)),
//             const SizedBox(height: 5), // Spacing between icon and text
//             Text(
//               item["label"] as String,
//               style: const TextStyle(
//                 color: Color(0xFF06426D),
//                 fontSize: 16, // Readable text size
//               ),
//               textAlign: TextAlign.center,
//               maxLines: 2, // Prevent text overflow with line wrapping
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/configs/viewmodels/reg_view_model.dart';
import 'package:v1_micro_finance/configs/widgets/app_drawer.dart';
import 'package:v1_micro_finance/configs/widgets/appbar.dart';
import 'package:v1_micro_finance/screens/dashboard/help_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/packages_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/policies.dart';
import 'package:v1_micro_finance/screens/dashboard/quick_loan_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/referrals_screen.dart';
import 'package:v1_micro_finance/screens/deposit/balance_save.dart';
import 'package:v1_micro_finance/screens/deposit/balance_screen.dart';
import 'package:v1_micro_finance/screens/policies/about_us.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<UserRegistrationViewModel>(context, listen: false);

    final List<Map<String, dynamic>> dashboardItems = [
      {"icon": Icons.add, "label": "Deposit", "screen": BalanceSaveScreen()},
      {
        "icon": Icons.paid_outlined,
        "label": "Package",
        "screen": const BalanceScreen()
      },
      {
        "icon": Icons.credit_card,
        "label": "Quick Loan",
        "screen": const QuickLoanScreen()
      },
      {
        "icon": Icons.people,
        "label": "Referrals",
        "screen": const ReferralsScreen()
      },
      {
        "icon": Icons.card_giftcard,
        "label": "Saving Plan",
        "screen": const PackagesScreen()
      },
      {
        "icon": Icons.contact_support,
        "label": "help",
        "screen": const HelpScreen()
      },
      {
        "icon": Icons.policy_outlined,
        "label": "Policies",
        "screen": Policies()
      },
      {"icon": Icons.info, "label": "About Us", "screen": AboutUs()},
    ];

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        // ✅ Task 2.2: Make screen scrollable
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // ✅ Task 1.1: Align items top-left
            children: [
              Wrap(
                // ✅ Replaces GridView for dynamic layout & no overlapping
                spacing: 5,
                runSpacing: 5, // ✅ Task 1.2: Minimize vertical gaps
                children: dashboardItems
                    .map((item) => SizedBox(
                          width: (MediaQuery.of(context).size.width - 30) /
                              2, // 2 items per row
                          child: _buildGridItem(context, item),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20), // ✅ Spacing between grid and gif
              Center(
                child: Image.asset(
                  "assets/images/home/home_gif.gif", // ✅ Task 2.3: Add gif
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
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
        margin: const EdgeInsets.only(bottom: 5), // ✅ spacing between rows
        decoration: BoxDecoration(
          color: const Color(0xFFFEF7FF),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item["icon"] as IconData,
                size: 50, color: const Color(0xFF06426D)),
            const SizedBox(height: 5),
            Text(
              item["label"] as String,
              style: const TextStyle(
                color: Color(0xFF06426D),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
