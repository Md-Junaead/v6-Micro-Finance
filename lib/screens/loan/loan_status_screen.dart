import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/configs/widgets/comon_appbar.dart';
import 'package:v1_micro_finance/screens/loan/loan_card.dart';
import 'package:v1_micro_finance/screens/loan/loan_list_viewmodel.dart';

class LoanStatusScreen extends StatefulWidget {
  const LoanStatusScreen({super.key});

  @override
  State<LoanStatusScreen> createState() => _LoanStatusScreenState();
}

class _LoanStatusScreenState extends State<LoanStatusScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch loans after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoanListViewModel>().fetchUserLoans();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Loan Status"),
      body: Consumer<LoanListViewModel>(
        builder: (context, model, _) {
          // Loading state
          if (model.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          }

          // Error state
          if (model.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  model.errorMessage!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.red,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          // Empty state
          if (model.loans.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.credit_card_off,
                      size: 50, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No Loan Applications Found',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            );
          }

          // Success state - Loan list
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: model.loans.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final loan = model.loans[index];
              return LoanCard(loan: loan);
            },
          );
        },
      ),
    );
  }
}
