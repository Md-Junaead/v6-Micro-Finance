import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoanViewModel with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _loanSuccess = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get loanSuccess => _loanSuccess;

  Future<void> saveLoan({
    required int loanAmount,
    required int tenure,
    required int userId,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _loanSuccess = false;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("authToken");

      // Validate token existence
      if (token == null || token.isEmpty) {
        _errorMessage = "Authentication expired. Please login again.";
        debugPrint("Missing auth token");
        return;
      }

      // Construct request body according to API requirements
      final requestBody = {
        "loanamuont": loanAmount,
        "tenure": tenure,
        "status": "Pending",
        "userRegistration": {"id": userId}
      };

      debugPrint("Attempting loan save with:");
      debugPrint("Token: ${token.substring(0, 15)}...");
      debugPrint("Request Body: ${jsonEncode(requestBody)}");

      final response = await http.post(
        Uri.parse("http://108.181.173.121:6161/api/loan/save"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
            requestBody), // Use manual body instead of model.toJson()
      );

      debugPrint("API Response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        _loanSuccess = true;
        debugPrint("Loan saved successfully");
      } else if (response.statusCode == 403) {
        _handle403Error(response);
      } else {
        _errorMessage = "Server error: ${response.body}";
      }
    } catch (e) {
      _errorMessage = "Network error: ${e.toString()}";
      debugPrint("Exception: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _handle403Error(http.Response response) {
    try {
      final errorData = jsonDecode(response.body);
      if (errorData.containsKey('message')) {
        _errorMessage = errorData['message'];
      } else {
        _errorMessage = "Authorization failed. Possible reasons:\n"
            "- Insufficient account balance\n"
            "- Account verification required\n"
            "- Loan limit exceeded";
      }
    } catch (e) {
      _errorMessage = "Forbidden: ${response.body}";
    }

    debugPrint("403 Error Details: $_errorMessage");
  }

  void resetState() {
    _loanSuccess = false;
    _errorMessage = null;
    notifyListeners();
  }
}
