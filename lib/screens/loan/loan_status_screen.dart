import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:v1_micro_finance/configs/widgets/comon_appbar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Loan Status"),
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
                        "Name: ${loan.userRegistration?.name ?? 'N/A'}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text("Email: ${loan.userRegistration?.email ?? 'N/A'}"),
                      const SizedBox(height: 14),
                      Text(
                          "Eligible Balance: ${loan.eligeblebalancey ?? 'N/A'}"),
                      const SizedBox(height: 4),
                      Text("Loan Amount: ${loan.loanamuont ?? 'N/A'}"),
                      const SizedBox(height: 4),
                      Text("Weekly Pay: ${loan.weeklypay ?? 'N/A'}"),
                      const SizedBox(height: 4),
                      Text("Total Pay: ${loan.totalpay ?? 'N/A'}"),
                      const SizedBox(height: 4),
                      Text("Tenure: ${loan.tenure ?? 'N/A'}"),
                      const SizedBox(height: 4),
                      Text("Status: ${loan.status ?? 'N/A'}"),
                      const SizedBox(height: 4),
                      Text(
                          "Request Date: ${formatRequestDate(loan.requestdate)}"),
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
