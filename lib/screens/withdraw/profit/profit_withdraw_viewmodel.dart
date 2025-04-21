// deposit_viewmodel.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// ViewModel for handling both Bank and Crypto withdrawals
class ProfitWithdrawViewmodel with ChangeNotifier {
  // Tab index for toggling between Bank and Crypto
  int _activeTabIndex = 0;

  // Loading and error state
  bool _isLoading = false;
  String? _errorMessage;

  // Bank withdrawal form controllers
  final Map<String, TextEditingController> _bankControllers = {
    'accountNumber': TextEditingController(),
    'bankName': TextEditingController(),
    'routingNumber': TextEditingController(),
    'swiftCode': TextEditingController(),
    'amount': TextEditingController(),
  };

  // Crypto withdrawal data and form controllers
  final Map<String, dynamic> _cryptoData = {
    'walletId': TextEditingController(),
    'amount': TextEditingController(),
    'type': 'BTC', // Default crypto type
  };

  // Getters for state
  int get activeTabIndex => _activeTabIndex;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, TextEditingController> get bankControllers => _bankControllers;
  Map<String, dynamic> get cryptoData => _cryptoData;

  /// Change tab between Bank and Crypto
  void changeTab(int index) {
    _activeTabIndex = index;
    _errorMessage = null;
    notifyListeners();
  }

  /// Set crypto type (e.g. BTC, ETH)
  void setCryptoType(String type) {
    _cryptoData['type'] = type;
    notifyListeners();
  }

  /// Submit bank withdrawal request to the API
  Future<void> submitBankWithdrawal() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final userId = prefs.getInt('userId');

      // Debugging auth data
      debugPrint('Token: $token, User ID: $userId');

      if (token == null || userId == null) {
        throw Exception('Authentication required');
      }

      // Construct request body for bank withdrawal
      final requestBody = {
        'accountnumber': int.parse(_bankControllers['accountNumber']!.text),
        'bankname': _bankControllers['bankName']!.text,
        'routingnumber': int.parse(_bankControllers['routingNumber']!.text),
        'swiftcode': int.parse(_bankControllers['swiftCode']!.text),
        'dipositwithdrawamount': double.parse(_bankControllers['amount']!.text),
        'userRegistration': {'id': userId},
      };

      debugPrint('Bank Withdrawal Request Body: $requestBody');

      // Send HTTP POST request
      final response = await http.post(
        Uri.parse('http://75.119.134.82:6160/api/ProfitWithdrawalBank/save'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint(
          'Bank Withdrawal Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to submit bank withdrawal: ${response.body}');
      }

      _clearBankForm(); // Clear form on success
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('Bank Withdrawal Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Submit crypto withdrawal request to the API
  Future<void> submitCryptoWithdrawal() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final userId = prefs.getInt('userId');

      // Debugging auth data
      debugPrint('Token: $token, User ID: $userId');

      if (token == null || userId == null) {
        throw Exception('Authentication required');
      }

      // Construct request body for crypto withdrawal
      final body = {
        'walletid': _cryptoData['walletId']!.text,
        'amount': double.parse(_cryptoData['amount']!.text),
        'userRegistration': {'id': userId},
      };

      // Add crypto type field dynamically (e.g., "btc": amount)
      body[_cryptoData['type'].toLowerCase()] = _cryptoData['amount']!.text;

      debugPrint('Crypto Withdrawal Request Body: $body');

      // Send HTTP POST request
      final response = await http.post(
        Uri.parse('http://75.119.134.82:6160/api/withdraw/CryptoProfit/save'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      debugPrint(
          'Crypto Withdrawal Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to submit crypto withdrawal: ${response.body}');
      }

      _clearCryptoForm(); // Clear form on success
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('Crypto Withdrawal Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clear bank form after submission
  void _clearBankForm() {
    _bankControllers.values.forEach((controller) => controller.clear());
  }

  /// Clear crypto form after submission
  void _clearCryptoForm() {
    _cryptoData['walletId']!.clear();
    _cryptoData['amount']!.clear();
    _cryptoData['type'] = 'BTC';
  }

  /// Dispose all controllers when ViewModel is destroyed
  @override
  void dispose() {
    _bankControllers.values.forEach((controller) => controller.dispose());
    _cryptoData['walletId']!.dispose();
    _cryptoData['amount']!.dispose();
    super.dispose();
  }
}
