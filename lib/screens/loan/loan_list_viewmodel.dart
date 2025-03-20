import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v1_micro_finance/screens/loan/loan_model.dart';

class LoanListViewModel with ChangeNotifier {
  List<Loan> _loans = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Loan> get loans => _loans;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Fetches loans for the currently logged in user
  Future<void> fetchUserLoans() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("authToken");
      final storedUserId = prefs.getInt("userId");

      // Validate stored credentials
      if (token == null || storedUserId == null) {
        _errorMessage = "Authentication required";
        debugPrint("Auth data missing - Token: $token, UserID: $storedUserId");
        return;
      }

      debugPrint("Fetching loans for stored user ID: $storedUserId");

      final response = await http.get(
        Uri.parse(
            "http://108.181.173.121:6161/api/loan/get?userId=$storedUserId"),
        headers: {'Authorization': 'Bearer $token'},
      );

      debugPrint("API Response: ${response.statusCode} ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        _loans = responseData.map((json) => Loan.fromJson(json)).toList();
      } else {
        _handleErrorResponse(response);
      }
    } catch (e) {
      _errorMessage = "Failed to load loans: ${e.toString()}";
      debugPrint("Loan fetch error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _handleErrorResponse(http.Response response) {
    switch (response.statusCode) {
      case 401:
        _errorMessage = "Session expired. Please login again.";
        break;
      case 403:
        _errorMessage = "Access denied. Verify your account status.";
        break;
      case 404:
        _errorMessage = "No loan records found";
        break;
      default:
        _errorMessage = "Server error: ${response.body.substring(0, 100)}...";
    }
    debugPrint("API Error: $_errorMessage");
  }

  void clearData() {
    _loans = [];
    _errorMessage = null;
    notifyListeners();
  }

  // Optional helper to get stored user ID
  static Future<int?> getStoredUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("userId");
  }
}
