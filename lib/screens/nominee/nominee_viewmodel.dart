import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v1_micro_finance/screens/nominee/nominee_model.dart';

class NomineeViewModel with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  // List holding the nominee(s) retrieved from the API.
  // We expect only one nominee per user.
  List<NomineeModel> _nominees = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<NomineeModel> get nominees => _nominees;

  // Fetch nominees for the logged-in user, filtering locally to ensure uniqueness.
  Future<void> fetchNominees(int userId) async {
    _isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');

    if (token == null) {
      _handleError('Not authenticated');
      return;
    }

    try {
      // Call the API to get nominees (ideally the API returns only the user's nominee)
      final response = await http.get(
        Uri.parse('http://108.181.173.121:6060/api/nominee/get?userId=$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Decode the response into a list of nominees.
        List<NomineeModel> allNominees = nomineeModelFromJson(response.body);
        // Filter locally to ensure that only nominees belonging to the logged-in user are retained.
        _nominees =
            allNominees.where((nominee) => nominee.user.id == userId).toList();
        _errorMessage = null;
      } else {
        _handleError('Failed to load nominees: ${response.statusCode}');
      }
    } catch (e) {
      _handleError('Error fetching nominees: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Save a new nominee, ensuring that only one nominee is saved per user.
  Future<bool> saveNominee({
    required String name,
    required String email,
    required String cellNo,
    required DateTime dob,
    required String relationship,
    required int userId,
  }) async {
    // Prevent saving a new nominee if one already exists.
    if (_nominees.isNotEmpty) {
      _handleError('Nominee already exists for this user.');
      return false;
    }

    _isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');

    if (token == null) {
      _handleError('Not authenticated');
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse('http://108.181.173.121:6060/api/nominee/save'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'cellNo': cellNo,
          'dob': dob.toIso8601String(),
          'relationship': relationship,
          'user': {'id': userId}
        }),
      );

      if (response.statusCode == 200) {
        // Refresh the nominee data after saving.
        await fetchNominees(userId);
        return true;
      } else {
        _handleError('Failed to save nominee: ${response.body}');
        return false;
      }
    } catch (e) {
      _handleError('Error saving nominee: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Internal method to handle errors.
  void _handleError(String message) {
    _errorMessage = message;
    _isLoading = false;
    notifyListeners();
  }
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:v1_micro_finance/screens/nominee/nominee_model.dart';

// class NomineeViewModel with ChangeNotifier {
//   bool _isLoading = false;
//   String? _errorMessage;
//   List<NomineeModel> _nominees = [];

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   List<NomineeModel> get nominees => _nominees;

//   // Fetch nominees for logged-in user
//   Future<void> fetchNominees(int userId) async {
//     _isLoading = true;
//     notifyListeners();

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('authToken');

//     if (token == null) {
//       _handleError('Not authenticated');
//       return;
//     }

//     try {
//       final response = await http.get(
//         Uri.parse('http://108.181.173.121:6060/api/nominee/get?userId=$userId'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         _nominees = nomineeModelFromJson(response.body);
//         _errorMessage = null;
//       } else {
//         _handleError('Failed to load nominees: ${response.statusCode}');
//       }
//     } catch (e) {
//       _handleError('Error fetching nominees: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Save new nominee
//   Future<bool> saveNominee({
//     required String name,
//     required String email,
//     required String cellNo,
//     required DateTime dob,
//     required String relationship,
//     required int userId,
//   }) async {
//     _isLoading = true;
//     notifyListeners();

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('authToken');

//     if (token == null) {
//       _handleError('Not authenticated');
//       return false;
//     }

//     try {
//       final response = await http.post(
//         Uri.parse('http://108.181.173.121:6060/api/nominee/save'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode({
//           'name': name,
//           'email': email,
//           'cellNo': cellNo,
//           'dob': dob.toIso8601String(),
//           'relationship': relationship,
//           'user': {'id': userId}
//         }),
//       );

//       if (response.statusCode == 200) {
//         await fetchNominees(userId);
//         return true;
//       } else {
//         _handleError('Failed to save nominee: ${response.body}');
//         return false;
//       }
//     } catch (e) {
//       _handleError('Error saving nominee: $e');
//       return false;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   void _handleError(String message) {
//     _errorMessage = message;
//     _isLoading = false;
//     notifyListeners();
//   }
// }
