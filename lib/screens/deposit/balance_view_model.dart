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

    const url = 'http://108.181.173.121:6161/api/Balance/save';

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
  Future<void> fetchBalances() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    const url = 'http://108.181.173.121:6161/api/Balance/get';

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
        _errorMessage = null;
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

// This viewmodel is working to sent Balance to server
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class BalanceViewModel with ChangeNotifier {
//   bool _isLoading = false;
//   String? _errorMessage;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;

//   Future<void> saveBalance(int addBalance, int userId) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     const url = 'http://108.181.173.121:6161/api/Balance/save';

//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('authToken');

//       if (token == null) {
//         _errorMessage = 'Authentication required';
//         _isLoading = false;
//         notifyListeners();
//         return;
//       }

//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode({
//           'addBalance': addBalance,
//           'userRegistration': {'id': userId}
//         }),
//       );

//       debugPrint('Status: ${response.statusCode}, Body: ${response.body}');

//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         _errorMessage = null;
//       } else {
//         _errorMessage = 'Failed to save balance: ${response.body}';
//       }
//     } catch (e) {
//       _errorMessage = 'Connection error: $e';
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
