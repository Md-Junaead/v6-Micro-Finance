import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/screens/loan/loan_view_model.dart';

class LoanSaveScreen extends StatefulWidget {
  const LoanSaveScreen({super.key});

  @override
  _LoanSaveScreenState createState() => _LoanSaveScreenState();
}

class _LoanSaveScreenState extends State<LoanSaveScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  int _selectedTenure = 26; // Default to 26 weeks
  bool _termsAccepted = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loanViewModel = Provider.of<LoanViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply for Loan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tenure Selection
                _buildTenureRadioGroup(),
                const SizedBox(height: 20),

                // Loan Amount Input
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Loan Amount',
                    prefixText: '\৳ ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter loan amount';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Terms Checkbox
                CheckboxListTile(
                  title: const Text('I agree to terms and conditions'),
                  value: _termsAccepted,
                  onChanged: (value) =>
                      setState(() => _termsAccepted = value ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 30),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loanViewModel.isLoading ? null : _submitForm,
                    child: loanViewModel.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Submit Application'),
                  ),
                ),

                // Error Message
                if (loanViewModel.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      loanViewModel.errorMessage!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTenureRadioGroup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Tenure Period:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        RadioListTile<int>(
          title: const Text('26 Weeks (6 Months)'),
          value: 26,
          groupValue: _selectedTenure,
          onChanged: (value) => setState(() => _selectedTenure = value!),
        ),
        RadioListTile<int>(
          title: const Text('52 Weeks (1 Year)'),
          value: 52,
          groupValue: _selectedTenure,
          onChanged: (value) => setState(() => _selectedTenure = value!),
        ),
      ],
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept terms and conditions')),
      );
      return;
    }

    final loanAmount = int.tryParse(_amountController.text);
    if (loanAmount == null) return;

    final loanViewModel = Provider.of<LoanViewModel>(context, listen: false);
    loanViewModel.submitLoan(
      loanAmount: loanAmount,
      tenure: _selectedTenure,
      context: context,
    );
  }
}
