import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoanViewModel with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _loanSuccess = false;
  double? _eligibleBalance; // ← COMMENT: holds the fetched balance

  double? get eligibleBalance => _eligibleBalance;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get loanSuccess => _loanSuccess;

  /// Public wrapper so the UI can trigger balance fetch
  Future<void> fetchEligibleBalance(int userId) async {
    await _fetchEligibleBalance(userId); // ← UPDATED: made public
  }

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
      final token = prefs.getString("authToken") ?? "";
      if (token.isEmpty) {
        _errorMessage = "Authentication expired. Please login again.";
        return;
      }

      final requestBody = {
        "loanamuont": loanAmount,
        "tenure": tenure,
        "status": "Pending",
        "userRegistration": {"id": userId}
      };
      debugPrint("Attempting loan save with body: $requestBody"); // DEBUG

      final response = await http.post(
        Uri.parse("http://75.119.134.82:6160/api/loan/save"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );
      debugPrint(
          "Loan save response: ${response.statusCode} ${response.body}"); // DEBUG

      if (response.statusCode == 200) {
        _loanSuccess = true;
        // ─── fetch updated balance ────────────────────────────────────────
        await _fetchEligibleBalance(userId); // UPDATED
      } else if (response.statusCode == 403) {
        _handle403Error(response);
      } else {
        _errorMessage = "Server error: ${response.body}";
      }
    } catch (e) {
      _errorMessage = "Network error: $e";
      debugPrint("Exception in saveLoan: $e"); // DEBUG
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── PRIVATE: Fetch eligible balance ─────────────────────────────────────────
  Future<void> _fetchEligibleBalance(int userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("authToken") ?? "";
      final url =
          Uri.parse("http://75.119.134.82:6160/api/loan/getByUser/$userId");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      debugPrint(
          "Balance fetch response: ${response.statusCode} ${response.body}"); // DEBUG

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          final raw = data.first["eligeblebalancey"];
          debugPrint(
              "Raw eligeblebalancey: $raw (${raw.runtimeType})"); // DEBUG
          // handle numeric or string values
          if (raw is num) {
            _eligibleBalance = raw.toDouble();
          } else if (raw is String) {
            _eligibleBalance =
                double.tryParse(raw) ?? 0.0; // UPDATED: parse string
          }
        }
      } else {
        debugPrint("Failed to fetch balance: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching eligible balance: $e"); // DEBUG
    }
    notifyListeners();
  }

  void _handle403Error(http.Response response) {
    try {
      final errorData = jsonDecode(response.body);
      _errorMessage = errorData['message'] ?? "Authorization failed.";
    } catch (_) {
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
