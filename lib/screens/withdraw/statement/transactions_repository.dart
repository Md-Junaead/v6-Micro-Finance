// File: lib/data/transactions_repository.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Unified model for recent requests from any source
class RecentRequest {
  final int id;
  final String sourceType; // e.g. "BankTransaction", "CryptoDeposit", etc.
  final double amount;
  final DateTime requestDate;
  final String status; // current status of the request
  final Map<String, dynamic> raw;

  RecentRequest({
    required this.id,
    required this.sourceType,
    required this.amount,
    required this.requestDate,
    required this.status,
    required this.raw,
  });
}

class TransactionsRepository {
  static const _baseUrl = 'http://75.119.134.82:6160';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<List<RecentRequest>> fetchRecentRequests(int userId) async {
    final token = await _getToken();
    if (token == null) {
      debugPrint('[Repository] Auth token not found');
      throw Exception('Authentication token missing');
    }

    final client = http.Client();
    final endpoints = {
      'BankTransaction': '/api/transactions/getByUser/$userId',
      'CryptoDeposit': '/api/CryptoDeposit/getByUser/$userId',
      'BankProfit': '/api/ProfitWithdrawalBank/getByUser/$userId',
      'CryptoProfit': '/api/CryptoProfit/getByUser/$userId',
    };
    List<RecentRequest> all = [];

    for (final entry in endpoints.entries) {
      final type = entry.key;
      final url = Uri.parse(_baseUrl + entry.value);
      try {
        debugPrint('[Repository] Fetching $type from $url');
        final response = await client.get(
          url,
          headers: {'Authorization': 'Bearer $token'},
        );
        if (response.statusCode == 200) {
          final List<dynamic> data = jsonDecode(response.body);
          for (final item in data) {
            final date = DateTime.parse(item['requestdate']);
            final amountField = item['dipositwithdrawamount'] ?? item['amount'];
            final amount = (amountField is num)
                ? amountField.toDouble()
                : double.tryParse(amountField.toString()) ?? 0.0;
            final status = item['status']?.toString() ?? 'Unknown';
            all.add(RecentRequest(
              id: item['id'],
              sourceType: type,
              amount: amount,
              requestDate: date,
              status: status,
              raw: Map<String, dynamic>.from(item),
            ));
          }
        } else {
          debugPrint(
              '[Repository] Error fetching $type: ${response.statusCode}');
        }
      } catch (e) {
        debugPrint('[Repository] Exception fetching $type: $e');
      }
    }

    // Sort by requestDate descending
    all.sort((a, b) => b.requestDate.compareTo(a.requestDate));
    return all;
  }
}
