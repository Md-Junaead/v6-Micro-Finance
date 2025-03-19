import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v1_micro_finance/screens/loan/loan_model.dart';

class LoanViewModel with ChangeNotifier {
  List<Loan> _loans = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Loan> get loans => _loans;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Future<void> fetchLoans(int userId) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     final response = await http.get(
  //       Uri.parse('http://108.181.173.121:6060/api/loan/get'),
  //       headers: _authHeaders,
  //     );

  //     if (response.statusCode == 200) {
  //       final allLoans = loanFromJson(response.body);
  //       _loans = allLoans
  //           .where((loan) =>
  //               loan.userRegistration.id == userId) //Error fix require
  //           .toList();
  //       _errorMessage = null;
  //     }
  //   } catch (e) {
  //     _errorMessage = "Failed to load loans";
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<bool> saveLoan({
  //   required double amount,
  //   required int tenure,
  //   required int userId,
  //   required int balanceId,
  // }) async {
  // try {
  //   final response = await http.post(
  //     Uri.parse('http://108.181.173.121:6060/api/loan/save'),
  //     headers: _authHeaders,
  //     body: jsonEncode({
  //       'loanamuont': amount,
  //       'tenure': tenure,
  //       'userRegistration': {'id': userId},
  //       'balance': {'id': balanceId}
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     await fetchLoans(userId);
  //     return true;
  //   }
  //   return false;
  // } catch (e) {
  //   return false;
  // }
  // }

  // In loan_viewmodel.dart, fix the headers method:
  // Map<String, String> get _authHeaders {
  //   final token = SharedPreferences.getInstance().getString('authToken');
  //   return {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  // }
}

extension on Future<SharedPreferences> {
  getString(String s) {}
}
