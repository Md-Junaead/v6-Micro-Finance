import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v1_micro_finance/screens/loan/loan_model.dart';
import 'package:v1_micro_finance/screens/signin/user_model.dart';

class LoanViewModel with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  Loan? _currentLoan;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Loan? get currentLoan => _currentLoan;

  /// Submits a new loan application
  Future<void> submitLoan({
    required int loanAmount,
    required int tenure,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Get auth token and user data
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final userEmail = prefs.getString('loggedInUserEmail');

      if (token == null || userEmail == null) {
        _errorMessage = "User not authenticated";
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Get user ID and balance ID (you might need to adjust these based on your user model)
      final currentUser = await _getCurrentUser(token, userEmail);
      if (currentUser == null) {
        _errorMessage = "User data not found";
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Create loan payload
      final loanPayload = {
        "loanamuont": loanAmount,
        "tenure": tenure,
        "status": "Pending",
        "userRegistration": {
          "id": currentUser.id,
        },
        "balance": {
          "id": currentUser.balance?.id ??
              0 // Adjust based on your balance ID retrieval
        }
      };

      // Send POST request
      final response = await http.post(
        Uri.parse('http://108.181.173.121:6161/api/loan/save'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(loanPayload),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _currentLoan = Loan.fromJson(data);
        Navigator.pop(context, true); // Return to previous screen with success
      } else {
        _errorMessage = "Loan application failed: ${response.body}";
      }
    } catch (e) {
      _errorMessage = "Error submitting loan: ${e.toString()}";
      debugPrint("Loan Submission Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<User?> _getCurrentUser(String token, String email) async {
    try {
      final response = await http.get(
        Uri.parse('http://108.181.173.121:6161/api/userRegistration/get'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          return data.firstWhere(
            (user) => user['email'] == email,
            orElse: () => null,
          );
        }
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
    return null;
  }
}
