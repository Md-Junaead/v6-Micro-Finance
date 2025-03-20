// loan_card.dart
import 'package:flutter/material.dart';

class LoanCard extends StatelessWidget {
  final double eligibleBalance;
  final double loanAmount;
  final double weeklyPayment;
  final double totalPayment;
  final int tenure;
  final String status;
  final String requestDate;
  final String userName;
  final String userEmail;

  const LoanCard({
    super.key,
    required this.eligibleBalance,
    required this.loanAmount,
    required this.weeklyPayment,
    required this.totalPayment,
    required this.tenure,
    required this.status,
    required this.requestDate,
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(userName),
        subtitle: Text('Loan Amount: \$${loanAmount.toStringAsFixed(2)}'),
        trailing: Text(status),
        onTap: () {
          // Add any onTap logic if needed
        },
      ),
    );
  }
}
