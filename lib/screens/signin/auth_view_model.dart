// // Login API Here

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:v1_micro_finance/screens/signin/user_model.dart';

// class AuthViewModel with ChangeNotifier {
//   bool _isLoading = false;
//   String? _errorMessage;
//   User? _user;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   User? get user => _user;

//   /// Handles user login
//   Future<void> login(
//       String email, String password, BuildContext context) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     const String loginUrl = "http://108.181.173.121:6161/login";

//     try {
//       final response = await http.post(
//         Uri.parse(loginUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({"email": email, "password": password}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         // print("Login Successful: $data"); // Debugging

//         // Save token & user email securely
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setString("authToken", data['token']);
//         await prefs.setString("loggedInUserEmail", email); // Store email

//         // Fetch User Info
//         await fetchUserInfo(data['token']);

//         // Navigate to Home Screen
//         Navigator.pushReplacementNamed(context, 'BottomNavBar');
//       } else {
//         _errorMessage = "Invalid Email or Password";
//         // print("Login Failed: ${response.body}"); // Debugging
//       }
//     } catch (e) {
//       _errorMessage = "Invalid Email or Password";
//       // print("Login Error: $e"); // Debugging
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   /// Fetches logged-in user's information
//   Future<void> fetchUserInfo(String token) async {
//     const String userApi =
//         "http://108.181.173.121:6161/api/userRegistration/get";
//     debugPrint("Fetching user info with token: ${token.substring(0, 6)}...");

//     try {
//       final response = await http.get(
//         Uri.parse(userApi),
//         headers: {'Authorization': 'Bearer $token'},
//       );

//       debugPrint("User info response: ${response.statusCode}");

//       if (response.statusCode == 200) {
//         final dynamic rawData = jsonDecode(response.body);
//         final prefs = await SharedPreferences.getInstance();
//         final storedEmail = prefs.getString('loggedInUserEmail');

//         User? parsedUser;

//         if (rawData is List) {
//           debugPrint("Received user list (${rawData.length} entries)");
//           final List<Map<String, dynamic>> data =
//               rawData.map((e) => Map<String, dynamic>.from(e)).toList();

//           final match = data.firstWhere(
//             (user) => user['email'] == storedEmail,
//             orElse: () => <String, dynamic>{},
//           );

//           parsedUser = match.isNotEmpty ? User.fromJson(match) : null;
//         } else if (rawData is Map) {
//           debugPrint("Received single user data");
//           final Map<String, dynamic> data = Map<String, dynamic>.from(rawData);
//           parsedUser = User.fromJson(data);
//         }

//         if (parsedUser != null && parsedUser.id != null) {
//           _user = parsedUser;
//           await prefs.setInt("userId", parsedUser.id!);
//           debugPrint("User ID ${parsedUser.id} stored for ${parsedUser.email}");
//         } else {
//           debugPrint(
//               "User data incomplete. ID: ${parsedUser?.id}, Email match: $storedEmail");
//           throw Exception("Invalid user data structure");
//         }
//       } else {
//         debugPrint("User fetch failed: ${response.body}");
//         throw Exception("Failed to fetch user details");
//       }
//     } catch (e) {
//       debugPrint("User info error: $e");
//       rethrow;
//     }
//   }

// //Added to show loan data
//   Future<void> initializeUserSession(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString("authToken");

//     if (token != null && _user == null) {
//       try {
//         await fetchUserInfo(token);
//         if (_user != null) {
//           Navigator.pushReplacementNamed(context, 'BottomNavBar');
//         }
//       } catch (e) {
//         debugPrint("Session initialization error: $e");
//         await logout();
//       }
//     }
//   }

//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove("authToken");
//     await prefs.remove("userId");
//     await prefs.remove("loggedInUserEmail");
//     _user = null;
//     notifyListeners();
//   }

//   /// Fetches logged-in user's information # This one is working fine untill loan come
//   // Future<void> fetchUserInfo(String token) async {
//   //   const String userApi =
//   //       "http://108.181.173.121:6161/api/userRegistration/get";

//   //   try {
//   //     final response = await http.get(
//   //       Uri.parse(userApi),
//   //       headers: {
//   //         'Content-Type': 'application/json',
//   //         'Authorization': 'Bearer $token',
//   //       },
//   //     );

//   //     if (response.statusCode == 200) {
//   //       final data = jsonDecode(response.body);

//   //       // Retrieve stored email of logged-in user
//   //       SharedPreferences prefs = await SharedPreferences.getInstance();
//   //       String? userEmail = prefs.getString("loggedInUserEmail");

//   //       if (userEmail == null) {
//   //         print("User email not found in local storage.");
//   //         return;
//   //       }

//   //       // Handling List or Map response and filtering the correct user
//   //       if (data is List) {
//   //         // Find the correct user from the list based on email
//   //         final userJson = data.firstWhere(
//   //           (user) => user['email'] == userEmail,
//   //           orElse: () => null, // Prevents errors if user is not found
//   //         );

//   //         if (userJson != null) {
//   //           _user = User.fromJson(userJson);
//   //           // print("User Info Fetched: $_user"); // Debugging
//   //         } else {
//   //           print("No matching user found for email: $userEmail");
//   //         }
//   //       } else if (data is Map<String, dynamic>) {
//   //         // If API directly returns a single user
//   //         _user = User.fromJson(data);
//   //         // print("User Info Fetched: $_user"); // Debugging
//   //       } else {
//   //         print("Unexpected API response format.");
//   //       }
//   //     } else {
//   //       // print("Failed to Fetch User Info: ${response.body}"); // Debugging
//   //     }
//   //   } catch (e) {
//   //     // print("User Info Fetch Error: $e"); // Debugging
//   //   }

//   //   notifyListeners();
//   // }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v1_micro_finance/screens/signin/user_model.dart';

class AuthViewModel with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  User? _user;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get user => _user;

  /// Handles user login
  Future<void> login(
      String email, String password, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    const String loginUrl = "http://108.181.173.121:6160/login";

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint("Login Successful: $data");

        // Save token & user email securely
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("authToken", data['token']);
        await prefs.setString("loggedInUserEmail", email);

        // Fetch User Info and store user ID securely
        await fetchUserInfo(data['token']);

        // Navigate to Home Screen (or LoanStatusScreen)
        Navigator.pushReplacementNamed(context, 'BottomNavBar');
      } else {
        _errorMessage = "Invalid Email or Password";
        debugPrint("Login Failed: ${response.body}");
      }
    } catch (e) {
      _errorMessage = "Invalid Email or Password";
      debugPrint("Login Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Fetches logged-in user's information
  Future<void> fetchUserInfo(String token) async {
    const String userApi =
        "http://108.181.173.121:6160/api/userRegistration/get";
    debugPrint("Fetching user info with token: ${token.substring(0, 6)}...");

    try {
      final response = await http.get(
        Uri.parse(userApi),
        headers: {'Authorization': 'Bearer $token'},
      );

      debugPrint("User info response: ${response.statusCode}");

      if (response.statusCode == 200) {
        final dynamic rawData = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        final storedEmail = prefs.getString('loggedInUserEmail');

        User? parsedUser;
        if (rawData is List) {
          debugPrint("Received user list (${rawData.length} entries)");
          final List<Map<String, dynamic>> data =
              rawData.map((e) => Map<String, dynamic>.from(e)).toList();
          final match = data.firstWhere(
            (user) => user['email'] == storedEmail,
            orElse: () => <String, dynamic>{},
          );
          parsedUser = match.isNotEmpty ? User.fromJson(match) : null;
        } else if (rawData is Map) {
          debugPrint("Received single user data");
          final Map<String, dynamic> data = Map<String, dynamic>.from(rawData);
          parsedUser = User.fromJson(data);
        }

        if (parsedUser != null && parsedUser.id != null) {
          _user = parsedUser;
          await prefs.setInt("userId", parsedUser.id!);
          debugPrint("User ID ${parsedUser.id} stored for ${parsedUser.email}");
        } else {
          debugPrint(
              "User data incomplete. ID: ${parsedUser?.id}, Email match: $storedEmail");
          throw Exception("Invalid user data structure");
        }
      } else {
        debugPrint("User fetch failed: ${response.body}");
        throw Exception("Failed to fetch user details");
      }
    } catch (e) {
      debugPrint("User info error: $e");
      rethrow;
    }
  }
}
