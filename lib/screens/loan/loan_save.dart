import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/configs/widgets/comon_appbar.dart';
import 'package:v1_micro_finance/screens/loan/loan_view_model.dart';
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';

class LoanSaveScreen extends StatefulWidget {
  const LoanSaveScreen({super.key});

  @override
  State<LoanSaveScreen> createState() => _LoanSaveScreenState();
}

class _LoanSaveScreenState extends State<LoanSaveScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  int? _selectedTenure;

  @override
  void initState() {
    super.initState();
    // ─── FETCH ELIGIBLE BALANCE ON SCREEN LOAD ──────────────────────────────
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authVm = Provider.of<AuthViewModel>(context, listen: false);
      final loanVm = Provider.of<LoanViewModel>(context, listen: false);
      final userId = authVm.user?.id;
      if (userId != null) {
        loanVm.fetchEligibleBalance(userId); // UPDATED: trigger initial fetch
      }
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final loanViewModel = Provider.of<LoanViewModel>(context);

    return Scaffold(
      appBar: CommonAppBar(title: "Loan Request"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // ─── DISPLAY THE USER'S ELIGIBLE BALANCE ────────────────────────────
              Text(
                'Eligible Balance: '
                '${loanViewModel.eligibleBalance?.toStringAsFixed(2) ?? '0.00'}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              // ───────────────────────────────────────────────────────────────────────

              // Tenure Selection...
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Select Tenure:", style: TextStyle(fontSize: 16)),
                  RadioListTile<int>(
                    title: const Text("26 Weeks"),
                    value: 26,
                    groupValue: _selectedTenure,
                    onChanged: (value) =>
                        setState(() => _selectedTenure = value),
                  ),
                  RadioListTile<int>(
                    title: const Text("52 Weeks"),
                    value: 52,
                    groupValue: _selectedTenure,
                    onChanged: (value) =>
                        setState(() => _selectedTenure = value),
                  ),
                ],
              ),

              // Loan Amount Input...
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Loan Amount",
                  hintText: "Enter amount",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please enter amount";
                  if (int.tryParse(value) == null) return "Invalid number";
                  return null;
                },
              ),

              const SizedBox(height: 20),
              if (loanViewModel.isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF06426D),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        _selectedTenure != null) {
                      final userId = authViewModel.user?.id;
                      if (userId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("User not found")),
                        );
                        return;
                      }

                      await loanViewModel.saveLoan(
                        loanAmount: int.parse(_amountController.text),
                        tenure: _selectedTenure!,
                        userId: userId,
                      );

                      if (loanViewModel.loanSuccess) {
                        _amountController.clear();
                        setState(() => _selectedTenure = null);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Loan application successful!")),
                        );
                      } else if (loanViewModel.errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(loanViewModel.errorMessage!)),
                        );
                      }
                    } else if (_selectedTenure == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select tenure")),
                      );
                    }
                  },
                  child: const Text(
                    "Submit Application",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
