// balance_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/configs/widgets/comon_appbar.dart';
import 'package:v1_micro_finance/screens/deposit/balance_card.dart';
import 'package:v1_micro_finance/screens/deposit/balance_model.dart';
import 'package:v1_micro_finance/screens/deposit/balance_view_model.dart';
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId != null) {
      await Provider.of<BalanceViewModel>(context, listen: false)
          .fetchBalances(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final balanceViewModel = Provider.of<BalanceViewModel>(context);

    return Scaffold(
      appBar: CommonAppBar(title: "Balance Overview"),
      body: _buildBody(authViewModel, balanceViewModel),
    );
  }

  Widget _buildBody(AuthViewModel auth, BalanceViewModel balanceVm) {
    if (balanceVm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (balanceVm.errorMessage != null) {
      return Center(child: Text('Error: ${balanceVm.errorMessage}'));
    }

    if (balanceVm.balances.isEmpty) {
      return const Center(child: Text('No balance records found'));
    }

    // TASK 1 UPDATE START: Sort balances by date descending and get latest
    final sortedBalances = List<Balance>.from(balanceVm.balances)
      ..sort((a, b) => b.date.compareTo(a.date));
    final latestBalance = sortedBalances.first;
    // TASK 1 UPDATE END

    final user = auth.user;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BalanceCard(
          user: user, balance: latestBalance), // Updated to use latestBalance
    );
  }
}
