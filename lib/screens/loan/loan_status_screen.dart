import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:v1_micro_finance/screens/loan/loan_list_viewmodel.dart';
import 'package:v1_micro_finance/screens/loan/loan_model.dart';

class LoanStatusScreen extends StatefulWidget {
  const LoanStatusScreen({Key? key}) : super(key: key);

  @override
  _LoanStatusScreenState createState() => _LoanStatusScreenState();
}

class _LoanStatusScreenState extends State<LoanStatusScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<LoanListViewModel>(context, listen: false)
            .fetchUserLoans());
  }

  /// Formats the request date to (Day/Month/Year). If parsing fails, returns the original string.
  String formatRequestDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  /// Formats a double value to 2 decimal places. If null, returns 'N/A'.
  String formatDouble(double? value) {
    return value != null ? value.toStringAsFixed(2) : 'N/A';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Loan Requests"),
      ),
      body: Consumer<LoanListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          if (viewModel.loans.isEmpty) {
            return const Center(child: Text("No loan requests found."));
          }

          return ListView.builder(
            itemCount: viewModel.loans.length,
            itemBuilder: (context, index) {
              Loan loan = viewModel.loans[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Eligible Balance: ${formatDouble(loan.eligeblebalancey)}"),
                      const SizedBox(height: 4),
                      Text("Loan Amount: ${loan.loanamuont ?? 'N/A'}"),
                      const SizedBox(height: 4),
                      Text("Weekly Pay: ${formatDouble(loan.weeklypay)}"),
                      const SizedBox(height: 4),
                      Text("Total Pay: ${formatDouble(loan.totalpay)}"),
                      const SizedBox(height: 4),
                      Text("Tenure: ${loan.tenure ?? 'N/A'}"),
                      const SizedBox(height: 4),
                      Text("Status: ${loan.status ?? 'N/A'}"),
                      const SizedBox(height: 4),
                      Text(
                          "Request Date: ${formatRequestDate(loan.requestdate)}"),
                      const SizedBox(height: 4),
                      Text(
                        "Name: ${loan.userRegistration?.name ?? 'N/A'}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text("Email: ${loan.userRegistration?.email ?? 'N/A'}"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
