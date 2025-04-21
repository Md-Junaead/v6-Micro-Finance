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
//     debugPrint("Login method called"); // Added debug statement
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();
//     debugPrint("Loading state set to true"); // Added debug statement

//     const String loginUrl = "http://75.119.134.82:6160/login";

//     try {
//       final response = await http.post(
//         Uri.parse(loginUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({"email": email, "password": password}),
//       );
//       debugPrint("Login request sent"); // Added debug statement

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         debugPrint("Login Successful: $data");

//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setString("authToken", data['token']);
//         await prefs.setString("loggedInUserEmail", email);
//         debugPrint("Auth token and email saved"); // Added debug statement

//         await fetchUserInfo(data['token']);
//         debugPrint("User info fetched successfully"); // Added debug statement

//         Navigator.pushReplacementNamed(context, 'BottomNavBar');
//         debugPrint("Navigated to BottomNavBar"); // Added debug statement
//       } else {
//         _errorMessage = "Invalid Email or Password";
//         debugPrint("Login Failed: ${response.body}");
//       }
//     } catch (e) {
//       _errorMessage = "Invalid Email or Password";
//       debugPrint("Login Error: $e");
//     }

//     _isLoading = false;
//     notifyListeners();
//     debugPrint("Loading state set to false"); // Added debug statement
//   }

//   /// Fetches logged-in user's information
//   Future<void> fetchUserInfo(String token) async {
//     debugPrint("Fetching user info..."); // Added debug statement
//     const String userApi = "http://75.119.134.82:6160/api/userRegistration/get";

//     try {
//       final response = await http.get(
//         Uri.parse(userApi),
//         headers: {'Authorization': 'Bearer $token'},
//       );
//       debugPrint("User info request sent"); // Added debug statement

//       if (response.statusCode == 200) {
//         final dynamic rawData = jsonDecode(response.body);
//         debugPrint(
//             "User info response received: $rawData"); // Added debug statement

//         final prefs = await SharedPreferences.getInstance();
//         final storedEmail = prefs.getString('loggedInUserEmail');
//         debugPrint(
//             "Stored email retrieved: $storedEmail"); // Added debug statement

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

// // Add to AuthViewModel class
//   Future<void> updateUserInfo(
//     int userId,
//     String phone,
//     String address,
//     String dob,
//     String country,
//   ) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     final String updateUrl =
//         "http://75.119.134.82:6160/api/userRegistration/update/$userId";

//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('authToken');

//       if (token == null) {
//         _errorMessage = "Authentication token missing";
//         throw Exception("Auth token not found");
//       }

//       debugPrint("Attempting update for user $userId");
//       debugPrint("Payload: ${jsonEncode({
//             'phoneNo': phone,
//             'address': address,
//             'country': country,
//             'dob': dob,
//           })}");

//       final response = await http.put(
//         Uri.parse(updateUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode({
//           'phoneNo': phone,
//           'address': address,
//           'country': country,
//           'dob': dob,
//         }),
//       );

//       debugPrint("Update response status: ${response.statusCode}");
//       debugPrint("Response body: ${response.body}");

//       if (response.statusCode == 200) {
//         debugPrint("Update successful, refreshing user data...");
//         await fetchUserInfo(token);
//       } else {
//         _errorMessage = _parseError(response.body);
//         throw Exception("Update failed with status ${response.statusCode}");
//       }
//     } on Exception catch (e) {
//       debugPrint("Update error: $e");
//       _errorMessage ??= "An error occurred. Please try again.";
//       rethrow;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   String _parseError(String responseBody) {
//     try {
//       final dynamic data = jsonDecode(responseBody);
//       return data['message'] ?? 'Unknown error occurred';
//     } catch (e) {
//       return 'Failed to process error message';
//     }
//   }
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
  String? _token;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get user => _user;

  // Added to initialize authentication state on app start
  Future<void> init() async {
    debugPrint("Initializing AuthViewModel");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    if (token != null) {
      debugPrint("Found stored token, attempting to fetch user info");
      try {
        await fetchUserInfo(token);
        _token = token; // Set session token if fetch succeeds
        debugPrint("User info fetched successfully, user is logged in");
      } catch (e) {
        debugPrint("Failed to initialize with stored token: $e");
        // Clear invalid token and related data
        await prefs.remove('authToken');
        await prefs.remove('loggedInUserEmail');
        await prefs.remove('userId');
        _user = null;
      }
    } else {
      debugPrint("No stored token found");
      _user = null;
    }
    notifyListeners();
  }

  /// Handles user login
  Future<void> login(String email, String password, bool rememberMe,
      BuildContext context) async {
    debugPrint("Login method called");
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    debugPrint("Loading state set to true");

    const String loginUrl = "http://75.119.134.82:6160/login";

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );
      debugPrint("Login request sent");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint("Login Successful: $data");

        // Store token in memory for current session
        _token = data['token'];

        // Store in SharedPreferences only if rememberMe is true
        if (rememberMe) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("authToken", data['token']);
          await prefs.setString("loggedInUserEmail", email);
          debugPrint("Auth token and email saved");
        }

        await fetchUserInfo(data['token']);
        debugPrint("User info fetched successfully");

        Navigator.pushReplacementNamed(context, 'BottomNavBar');
        debugPrint("Navigated to BottomNavBar");
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
    debugPrint("Loading state set to false");
  }

  /// Fetches logged-in user's information
  Future<void> fetchUserInfo(String token) async {
    debugPrint("Fetching user info...");
    const String userApi = "http://75.119.134.82:6160/api/userRegistration/get";

    try {
      final response = await http.get(
        Uri.parse(userApi),
        headers: {'Authorization': 'Bearer $token'},
      );
      debugPrint("User info request sent");

      if (response.statusCode == 200) {
        final dynamic rawData = jsonDecode(response.body);
        debugPrint("User info response received: $rawData");

        final prefs = await SharedPreferences.getInstance();
        final storedEmail = prefs.getString('loggedInUserEmail');
        debugPrint("Stored email retrieved: $storedEmail");

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

  Future<void> updateUserInfo(
    int userId,
    String phone,
    String address,
    String dob,
    String country,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final String updateUrl =
        "http://75.119.134.82:6160/api/userRegistration/update/$userId";

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');

      if (token == null) {
        _errorMessage = "Authentication token missing";
        throw Exception("Auth token not found");
      }

      debugPrint("Attempting update for user $userId");
      debugPrint("Payload: ${jsonEncode({
            'phoneNo': phone,
            'address': address,
            'country': country,
            'dob': dob,
          })}");

      final response = await http.put(
        Uri.parse(updateUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'phoneNo': phone,
          'address': address,
          'country': country,
          'dob': dob,
        }),
      );

      debugPrint("Update response status: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200) {
        debugPrint("Update successful, refreshing user data...");
        await fetchUserInfo(token);
      } else {
        _errorMessage = _parseError(response.body);
        throw Exception("Update failed with status ${response.statusCode}");
      }
    } on Exception catch (e) {
      debugPrint("Update error: $e");
      _errorMessage ??= "An error occurred. Please try again.";
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _parseError(String responseBody) {
    try {
      final dynamic data = jsonDecode(responseBody);
      return data['message'] ?? 'Unknown error occurred';
    } catch (e) {
      return 'Failed to process error message';
    }
  }
}
