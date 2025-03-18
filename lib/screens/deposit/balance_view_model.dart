// balance_view_model.dart

import 'package:flutter/material.dart';
import 'balance_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BalanceViewModel extends ChangeNotifier {
  Balance? _balance;

  Balance? get balance => _balance;

  // Fetch balance from the API
  Future<void> fetchBalance(String userId) async {
    final response = await http.get(Uri.parse(
        'http://108.181.173.121:6060/api/Balance/get?userId=$userId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _balance = Balance.fromJson(data);
      notifyListeners(); // Notify UI to rebuild
    } else {
      throw Exception('Failed to load balance');
    }
  }

  // Deposit function to save balance
  Future<void> depositBalance(String userId, double amount) async {
    final response = await http.post(
      Uri.parse('http://108.181.173.121:6060/api/Balance/save'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userId': userId,
        'dipositB': amount,
      }),
    );

    if (response.statusCode == 200) {
      // Assuming balance was successfully saved, refetch it
      fetchBalance(userId);
    } else {
      throw Exception('Failed to deposit balance');
    }
  }
}
