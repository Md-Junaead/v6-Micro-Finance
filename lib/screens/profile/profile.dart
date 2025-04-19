import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/screens/auth/logout.dart';
import 'package:v1_micro_finance/screens/dashboard/referrals_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/help_screen.dart';
import 'package:v1_micro_finance/configs/widgets/user_app_bar.dart';
import 'package:v1_micro_finance/screens/nominee/nominee_screen.dart';
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';
import 'package:v1_micro_finance/screens/signin/user_info_screen.dart';

// ignore: must_be_immutable
class UserProfile extends StatelessWidget {
  // Updated buttons list with new entry
  final List<Map<String, dynamic>> buttons = [
    {
      "title": "My Account",
      "icon": Icons.person,
      "screen": UserInfoScreen(),
    },
    {
      "title": "Nominee",
      "icon": Icons.group,
      "screen": NomineeScreen(),
    },
    // {
    //   "title": "Nominee Save",
    //   "icon": Icons.group_add,
    //   "screen": NomineeSaveScreen(),
    // },
    // {
    //   "title": "Update Nominee",
    //   "icon": Icons.edit,
    //   "onTap": (BuildContext context) {
    //     final auth = Provider.of<AuthViewModel>(context, listen: false);
    //     final nomineeVM = Provider.of<NomineeViewModel>(context, listen: false);
    //     nomineeVM.fetchNominees(auth.user!.id);
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (_) => UpdateNomineeScreen()),
    //     );
    //   },
    // },
    {
      "title": "Refer & Earn",
      "icon": Icons.people,
      "screen": ReferralsScreen(),
    },
    {
      "title": "Help Center",
      "icon": Icons.help,
      "screen": HelpScreen(),
    },
    {"title": "Logout", "icon": Icons.logout, "screen": Logout()},
  ];

  UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthViewModel>(context).user;

    return Scaffold(
      appBar: UserAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...buttons.map((button) {
                  return GestureDetector(
                    onTap: () {
                      if (button.containsKey('onTap')) {
                        // Execute custom onTap if provided
                        button['onTap'](context);
                      } else {
                        // Default navigation behavior
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => button["screen"],
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFF06426D),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(
                              button['icon'],
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              button['title'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
