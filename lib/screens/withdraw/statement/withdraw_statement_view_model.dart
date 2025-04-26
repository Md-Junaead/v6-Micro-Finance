// File: lib/viewmodels/withdraw_statement_view_model.dart
import 'package:flutter/foundation.dart';
import 'package:v1_micro_finance/screens/withdraw/statement/transactions_repository.dart';

class WithdrawStatementViewModel extends ChangeNotifier {
  final TransactionsRepository _repository;
  List<RecentRequest> statements = [];
  bool isLoading = false;
  String? error;

  WithdrawStatementViewModel(this._repository);

  /// Fetch statements for logged in user
  Future<void> fetchStatements(int userId) async {
    isLoading = true;
    error = null;
    notifyListeners();
    debugPrint('[ViewModel] Starting fetchStatements for user $userId');
    try {
      statements = await _repository.fetchRecentRequests(userId);
      debugPrint('[ViewModel] Fetched ${statements.length} records');
    } catch (e) {
      error = e.toString();
      debugPrint('[ViewModel] Error: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
