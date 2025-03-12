import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/configs/widgets/comon_appbar.dart';
import 'package:v1_micro_finance/screens/bottom/home_screen.dart';
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart'; // Import your Edit screen here

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch the user data from AuthViewModel
    final user = Provider.of<AuthViewModel>(context).user;

    // If user data is not available, show a loading indicator
    return Scaffold(
      appBar: CommonAppBar(title: "User Info"),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildUserInfoRow(Icons.person, "Name", user.name),
                        _buildUserInfoRow(Icons.email, "Email", user.email),
                        _buildUserInfoRow(
                            Icons.phone, "Phone", user.phoneNo ?? 'N/A'),
                        _buildUserInfoRow(
                            Icons.home, "Address", user.address ?? 'N/A'),
                        _buildUserInfoRow(
                            Icons.location_on, "Country", user.country),
                        _buildUserInfoRow(Icons.calendar_today, "Date of Birth",
                            user.dob ?? 'N/A'),
                        _buildUserInfoRow(Icons.card_membership, "NID Number",
                            user.nidnumber ?? 'N/A'),
                        _buildUserInfoRow(Icons.account_box, "Passport",
                            user.passport ?? 'N/A'),
                        // Edit Button at the bottom
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to the Edit screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen(), // The Edit screen
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color(0xFF06426D), // Background color
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32.0, vertical: 12.0),
                                textStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              child: const Text("Edit",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  // Helper method to create user info rows inside the card
  Widget _buildUserInfoRow(IconData icon, String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Color(0xFF06426D),
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "$title: $value",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:v1_micro_finance/configs/widgets/comon_appbar.dart';
// import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';

// class UserInfoScreen extends StatelessWidget {
//   const UserInfoScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Fetch the user data from AuthViewModel
//     final user = Provider.of<AuthViewModel>(context).user;

//     // If user data is not available, show a loading indicator
//     return Scaffold(
//       appBar: CommonAppBar(title: "User Info"),
//       body: user == null
//           ? Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Displaying all user information here
//                     Text("Name: ${user.name}", style: TextStyle(fontSize: 18)),
//                     Text("Email: ${user.email}",
//                         style: TextStyle(fontSize: 18)),
//                     Text("Phone: ${user.phoneNo ?? 'N/A'}",
//                         style: TextStyle(fontSize: 18)),
//                     Text("Address: ${user.address ?? 'N/A'}",
//                         style: TextStyle(fontSize: 18)),
//                     Text("Country: ${user.country}",
//                         style: TextStyle(fontSize: 18)),
//                     Text("Date of Birth: ${user.dob ?? 'N/A'}",
//                         style: TextStyle(fontSize: 18)),
//                     Text("NID Number: ${user.nidnumber ?? 'N/A'}",
//                         style: TextStyle(fontSize: 18)),
//                     Text("Passport: ${user.passport ?? 'N/A'}",
//                         style: TextStyle(fontSize: 18)),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
