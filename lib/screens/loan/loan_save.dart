import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/screens/loan/loan_view_model.dart';
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';

class LoanSaveScreen extends StatefulWidget {
  const LoanSaveScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoanSaveScreenState createState() => _LoanSaveScreenState();
}

class _LoanSaveScreenState extends State<LoanSaveScreen> {
  final _formKey = GlobalKey<FormState>();
  double _loanAmount = 0;
  int _tenure = 0;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final loanViewModel = Provider.of<LoanViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Apply for Loan")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Loan Amount"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return "Enter valid amount";
                  }
                  return null;
                },
                onSaved: (value) => _loanAmount = double.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Tenure (weeks)"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return "Enter valid tenure";
                  }
                  return null;
                },
                onSaved: (value) => _tenure = int.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (authViewModel.user != null) {
                      await loanViewModel.saveLoan(
                        loanAmount: _loanAmount,
                        tenure: _tenure,
                        userId: authViewModel.user!.id,
                      );
                      if (loanViewModel.errorMessage == null) {
                        Navigator.pop(context);
                      }
                    }
                  }
                },
                child: Text("Submit Application"),
              ),
              if (loanViewModel.errorMessage != null)
                Text(loanViewModel.errorMessage!,
                    style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
