import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/configs/widgets/comon_appbar.dart';
import 'package:v1_micro_finance/screens/deposit/balance_view_model.dart';
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';

class BalanceSaveScreen extends StatelessWidget {
  final _amountController = TextEditingController();

  BalanceSaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final balanceViewModel = Provider.of<BalanceViewModel>(context);

    return Scaffold(
      appBar: CommonAppBar(title: "Add Balance"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            if (balanceViewModel.isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color(0xFF06426D), // Set background color to blue
                ),
                onPressed: () async {
                  final amount = int.tryParse(_amountController.text);
                  final user = authViewModel.user;

                  if (amount == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid amount')),
                    );
                  } else if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User not logged in')),
                    );
                  } else {
                    await balanceViewModel.saveBalance(amount, user.id);
                    if (balanceViewModel.errorMessage == null) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ), // Set text color to white
              ),
            if (balanceViewModel.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  balanceViewModel.errorMessage!,
                  style: TextStyle(color: Colors.red[700]),
                ),
              )
          ],
        ),
      ),
    );
  }
}
