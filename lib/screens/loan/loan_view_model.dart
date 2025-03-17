import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v1_micro_finance/screens/loan/loan_model.dart';

class LoanViewModel with ChangeNotifier {
  List<Loan> _loans = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters for state access
  List<Loan> get loans => _loans;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchLoans(int userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("authToken");

    if (token == null) {
      _errorMessage = "User not authenticated";
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      final response = await http.get(
        Uri.parse("http://108.181.173.121:6060/api/loan/get"),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Loan> allLoans = data.map((json) => Loan.fromJson(json)).toList();
        _loans = allLoans.where((loan) => loan.user.id == userId).toList();
        _errorMessage = null;
      } else {
        _errorMessage = "Failed to load loans: ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = "Error fetching loans: $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveLoan({
    required double loanAmount,
    required int tenure,
    required int userId,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("authToken");

    try {
      final response = await http.post(
        Uri.parse("http://108.181.173.121:6060/api/loan/save"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'loanamuont': loanAmount,
          'tenure': tenure,
          'userRegistration': {'id': userId},
        }),
      );

      if (response.statusCode == 200) {
        await fetchLoans(userId);
        _errorMessage = null;
      } else {
        _errorMessage = "Failed to save loan: ${response.body}";
      }
    } catch (e) {
      _errorMessage = "Error saving loan: $e";
    }

    _isLoading = false;
    notifyListeners();
  }
}
