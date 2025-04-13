import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'balance_model.dart';

class BalanceViewModel with ChangeNotifier {
  List<Balance> _balances = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Balance> get balances => _balances;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Saves the new balance for a given user.
  Future<void> saveBalance(int addBalance, int userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    const url = 'http://75.119.134.82:6160/api/Balance/save';

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) {
        _errorMessage = 'Authentication required';
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'addBalance': addBalance,
          'userRegistration': {'id': userId}
        }),
      );

      debugPrint('Status: ${response.statusCode}, Body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to save balance: ${response.body}';
      }
    } catch (e) {
      _errorMessage = 'Connection error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Fetches the user's balance history from the API.
  Future<void> fetchBalances(int userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url = 'http://75.119.134.82:6160/api/Balance/getByUser/$userId';

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) {
        _errorMessage = 'Authentication required';
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      debugPrint(
          'Balance API Response: ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        _balances = responseData.map((json) => Balance.fromJson(json)).toList();

        // TASK 1 UPDATE: Sort balances by date descending during fetch
        _balances.sort((a, b) => b.date.compareTo(a.date));

        _errorMessage = null;

        debugPrint('Sorted balances: ${_balances.map((b) => b.date)}');
      } else {
        _errorMessage = 'Failed to load balances: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Connection error: $e';
      debugPrint('Balance Fetch Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
