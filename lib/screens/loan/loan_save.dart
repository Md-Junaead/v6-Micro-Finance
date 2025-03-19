import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:v1_micro_finance/screens/loan/loan_view_model.dart';
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';

class LoanSaveScreen extends StatefulWidget {
  @override
  _LoanSaveScreenState createState() => _LoanSaveScreenState();
}

class _LoanSaveScreenState extends State<LoanSaveScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _tenureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    final vm = context.watch<LoanViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('New Loan Application')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Loan Amount'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _tenureController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Tenure (weeks)'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              // ElevatedButton(
              //     onPressed: () => _submitLoan(auth, vm),
              //     child: Text('Submit Application')),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _submitLoan(AuthViewModel auth, LoanViewModel vm) async {
  //   if (!_formKey.currentState!.validate()) return;

  //   final amount = double.tryParse(_amountController.text);
  //   final tenure = int.tryParse(_tenureController.text);
  //   // final balanceId = auth.userBalance?.id;

  //   if (amount == null || tenure == null || balanceId == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Invalid input or missing balance')));
  //     return;
  //   }

  //   final success = await vm.saveLoan(
  //     amount: amount,
  //     tenure: tenure,
  //     userId: auth.user!.id,
  //     balanceId: balanceId,
  //   );

  //   if (success) Navigator.pop(context);
  // }
}
