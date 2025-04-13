import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'loan_model.dart';

class LoanListViewModel with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<Loan> _loans = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Loan> get loans => _loans;

  Future<void> fetchUserLoans() async {
    _isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('authToken');
    final userId = prefs.getInt('userId');

    if (userId == null || authToken == null) {
      _errorMessage = "User not authenticated";
      _isLoading = false;
      notifyListeners();
      return;
    }

    final url =
        Uri.parse('http://75.119.134.82:6160/api/loan/getByUser/$userId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      debugPrint('Loan API Response: ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _loans = data.map((json) => Loan.fromJson(json)).toList();
        _errorMessage = null;
      } else {
        _errorMessage = "Failed to load loans (${response.statusCode})";
      }
    } catch (e) {
      _errorMessage = "Error fetching loans: ${e.toString()}";
      debugPrint('Loan fetch error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
