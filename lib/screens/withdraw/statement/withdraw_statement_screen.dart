// File: lib/views/withdraw_statement_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:v1_micro_finance/screens/withdraw/statement/transactions_repository.dart';
import 'package:v1_micro_finance/screens/withdraw/statement/withdraw_statement_view_model.dart';

class WithdrawStatementScreen extends StatefulWidget {
  @override
  _WithdrawStatementScreenState createState() =>
      _WithdrawStatementScreenState();
}

class _WithdrawStatementScreenState extends State<WithdrawStatementScreen> {
  late final WithdrawStatementViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = WithdrawStatementViewModel(TransactionsRepository());
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final userId = await _loadUserId();
      debugPrint('[Screen] Loaded userId: $userId');
      viewModel.fetchStatements(userId);
    });
  }

  Future<int> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WithdrawStatementViewModel>.value(
      value: viewModel,
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
          'Withdraw Statements',
          style: TextStyle(color: Colors.white),
        )),
        body: Consumer<WithdrawStatementViewModel>(
          builder: (context, model, _) {
            if (model.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (model.error != null) {
              return Center(child: Text('Error: ${model.error}'));
            }
            if (model.statements.isEmpty) {
              return const Center(child: Text('No requests found'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: model.statements.length,
              itemBuilder: (context, index) {
                final req = model.statements[index];
                final formattedDate =
                    DateFormat('yyyy-MM-dd').format(req.requestDate);
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          req.sourceType.contains('Crypto')
                              ? Icons.account_balance_wallet
                              : Icons.account_balance,
                          color: Color(0xFF06426D),
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                req.sourceType,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              if (req.sourceType.contains('Bank')) ...[
                                Text('Bank Name: ${req.raw['bankname']}'),
                                Text(
                                    'Account Number: ${req.raw['accountnumber']}'),
                                Text(
                                    'Routing Number: ${req.raw['routingnumber']}'),
                                Text('Swift Code: ${req.raw['swiftcode']}'),
                              ] else if (req.sourceType.contains('Crypto')) ...[
                                Builder(builder: (ctx) {
                                  final btc = req.raw['btc']?.toString();
                                  final usdt = req.raw['usdt']?.toString();
                                  final currency = (btc != null && btc != '0')
                                      ? 'BTC'
                                      : 'USDT';
                                  final value = currency == 'BTC' ? btc : usdt;
                                  return Text('$currency: $value');
                                }),
                                Text('Wallet ID: ${req.raw['walletid']}'),
                              ],
                              const SizedBox(height: 8),
                              Text('Amount: ${req.amount}'),
                              Text('Date: $formattedDate'),
                              Text('Status: ${req.status}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
