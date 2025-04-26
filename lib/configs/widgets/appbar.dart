// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';
// import 'package:v1_micro_finance/screens/deposit/balance_view_model.dart';
// import 'package:v1_micro_finance/screens/deposit/balance_model.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({super.key});

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight + 50);

//   @override
//   Widget build(BuildContext context) {
//     final authVm = Provider.of<AuthViewModel>(context);

//     return Stack(
//       children: [
//         const _AppBarBackground(),
//         Positioned(
//           top: 30,
//           left: 90,
//           right: 30,
//           bottom: 12,
//           child: Row(
//             children: [
//               const CircleAvatar(
//                 backgroundColor: Colors.white,
//                 child: Icon(Icons.person, size: 30, color: Color(0xFF06426D)),
//               ),
//               const SizedBox(width: 12),
//               _UserInfo(
//                 name: authVm.user?.name ?? 'Loading...',
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _AppBarBackground extends StatelessWidget {
//   const _AppBarBackground();

//   @override
//   Widget build(BuildContext context) {
//     return PreferredSize(
//       preferredSize: const Size.fromHeight(kToolbarHeight),
//       child: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white, size: 45),
//         backgroundColor: const Color(0xFF06426D),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
//         ),
//       ),
//     );
//   }
// }

// class _UserInfo extends StatefulWidget {
//   final String name;

//   const _UserInfo({
//     required this.name,
//   });

//   @override
//   _UserInfoState createState() => _UserInfoState();
// }

// class _UserInfoState extends State<_UserInfo> {
//   bool _isBalanceVisible = false;

//   Future<void> _fetchAndToggleBalance() async {
//     if (!_isBalanceVisible) {
//       final prefs = await SharedPreferences.getInstance();
//       final userId = prefs.getInt('userId');
//       if (userId != null) {
//         final balanceVm = Provider.of<BalanceViewModel>(context, listen: false);
//         await balanceVm.fetchBalances(userId);
//       }
//     }
//     setState(() {
//       _isBalanceVisible = !_isBalanceVisible;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final balanceVm = Provider.of<BalanceViewModel>(context);
//     final List<Balance> sortedBalances = List.from(balanceVm.balances)
//       ..sort((a, b) => b.date.compareTo(a.date));
//     final latestBalance =
//         sortedBalances.isNotEmpty ? sortedBalances.first : null;
//     final balanceValue = latestBalance?.dipositB.toStringAsFixed(2) ?? '0.00';

//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(widget.name,
//               style: const TextStyle(color: Colors.white, fontSize: 18)),
//           const SizedBox(height: 5),
//           GestureDetector(
//             onTap: _fetchAndToggleBalance,
//             child: Bounce(
//               duration: const Duration(milliseconds: 01),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 01),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                 decoration: BoxDecoration(
//                   // color: const Color(0xFFE1E8ED),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: AnimatedCrossFade(
//                   firstChild: const Text(
//                     "Check Balance",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                   secondChild: Text(
//                     _isBalanceVisible ? "\$$balanceValue" : "",
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   crossFadeState: _isBalanceVisible
//                       ? CrossFadeState.showSecond
//                       : CrossFadeState.showFirst,
//                   duration: const Duration(milliseconds: 01),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Importing necessary Flutter and external packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart'; // For Bounce animation
import 'package:shared_preferences/shared_preferences.dart'; // For local storage
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart'; // Auth ViewModel
import 'package:v1_micro_finance/screens/deposit/balance_view_model.dart'; // Balance ViewModel
import 'package:v1_micro_finance/screens/deposit/balance_model.dart'; // Balance Model

// CustomAppBar is a reusable app bar widget with user info and balance toggle
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  // Set custom height for the AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 50);

  @override
  Widget build(BuildContext context) {
    // Access AuthViewModel to retrieve user information
    final authVm = Provider.of<AuthViewModel>(context);

    return Stack(
      children: [
        const _AppBarBackground(), // Custom AppBar background with rounded corners
        // Positioned user avatar and info over the AppBar
        Positioned(
          top: 30,
          left: 90,
          right: 30,
          bottom: 12,
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 30, color: Color(0xFF06426D)),
              ),
              const SizedBox(width: 12),
              // Display user's name and balance toggle widget
              _UserInfo(
                name: authVm.user?.name ?? 'Loading...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Private widget to render AppBar background styling
class _AppBarBackground extends StatelessWidget {
  const _AppBarBackground();

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 45),
        backgroundColor: const Color(0xFF06426D),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
    );
  }
}

// Widget to display user's name and toggling balance feature
class _UserInfo extends StatefulWidget {
  final String name;

  const _UserInfo({
    required this.name,
  });

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<_UserInfo> {
  bool _isBalanceVisible = false; // Tracks visibility of the balance

  // Fetch user balance from SharedPreferences and toggle visibility
  Future<void> _fetchAndToggleBalance() async {
    if (!_isBalanceVisible) {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId');
      if (userId != null) {
        final balanceVm = Provider.of<BalanceViewModel>(context, listen: false);
        await balanceVm.fetchBalances(userId); // API call to get balance list
      }
    }
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final balanceVm = Provider.of<BalanceViewModel>(context);

    // Get latest balance from the fetched balance list
    final List<Balance> sortedBalances = List.from(balanceVm.balances)
      ..sort((a, b) => b.date.compareTo(a.date)); // Sort by most recent
    final latestBalance =
        sortedBalances.isNotEmpty ? sortedBalances.first : null;
    final balanceValue = latestBalance?.dipositB.toStringAsFixed(2) ?? '0.00';

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display user's name
          Text(widget.name,
              style: const TextStyle(color: Colors.white, fontSize: 18)),
          const SizedBox(height: 5),
          // Tapping this toggles balance visibility
          GestureDetector(
            onTap: _fetchAndToggleBalance,
            child: Bounce(
              duration: const Duration(milliseconds: 01), // Animation on tap
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 01), // Smooth container
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  // color: const Color(0xFFE1E8ED), // Optional background
                  borderRadius: BorderRadius.circular(15),
                ),
                // Crossfade between "Check Balance" and actual balance value
                child: AnimatedCrossFade(
                  firstChild: const Text(
                    "Check Balance",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  secondChild: Text(
                    _isBalanceVisible ? "\$$balanceValue" : "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Set balance text color to white
                    ),
                  ),
                  crossFadeState: _isBalanceVisible
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 01),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
