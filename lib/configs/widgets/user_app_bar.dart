import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';

class UserAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UserAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch the logged-in user's name from AuthViewModel
    final user = Provider.of<AuthViewModel>(context).user;

    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight +
          MediaQuery.of(context).size.height * 0.03), // Dynamic height
      child: AppBar(
        automaticallyImplyLeading: false, // Disables back button
        iconTheme: const IconThemeData(
          color: Colors.white, // Icon color customization
          size: 30, // Icon size
        ),
        centerTitle: true, // Centers the title
        title: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height *
                  0.02), // Adjusts the title's vertical position
          child: Text(
            'Welcome, ${user?.name ?? 'User'}', // Displays welcome text with user's name
            style: const TextStyle(
              color: Colors.white, // White text color
              fontSize: 30, // Title font size
              fontWeight: FontWeight.bold, // Bold title
            ),
          ),
        ),
        backgroundColor: const Color(0xFF06426D), // Blue background color
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15)), // Rounded bottom corners
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + 20); // Adjusted height
}
