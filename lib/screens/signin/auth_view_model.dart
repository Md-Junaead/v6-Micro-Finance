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

// Add to AuthViewModel class
  Future<void> updateUserInfo(
    String phone,
    String address,
    String dob,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    debugPrint('Starting user update...');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final userId = prefs.getInt('userId');

      debugPrint('Retrieved userId: $userId, token exists: ${token != null}');

      if (token == null || userId == null) {
        throw Exception('Authentication required');
      }

      final updateUrl =
          "http://108.181.173.121:6160/api/userRegistration/update/";

      final requestBody = jsonEncode({
        "phoneNo": phone,
        "address": address,
        "dob": dob,
        "user": {"id": userId}
      });

      debugPrint('Sending update request: $requestBody');

      final response = await http.put(
        Uri.parse(updateUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: requestBody,
      );

      debugPrint('Update response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final updatedUser = User.fromJson(jsonDecode(response.body));
        _user = updatedUser;
        debugPrint('User data updated successfully');

        // Update SharedPreferences if needed
        await prefs.setString('userData', jsonEncode(updatedUser.toJson()));
      } else {
        final errorData = jsonDecode(response.body);
        _errorMessage = errorData['message'] ?? 'Update failed';
        throw Exception(_errorMessage);
      }
    } catch (e) {
      debugPrint('Update error: $e');
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
