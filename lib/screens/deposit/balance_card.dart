import 'package:flutter/material.dart';
import 'package:v1_micro_finance/screens/deposit/balance_model.dart';
import 'package:v1_micro_finance/screens/signin/user_model.dart';

class BalanceCard extends StatelessWidget {
  final User? user;
  final Balance balance;

  const BalanceCard({super.key, required this.user, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // TASK 2 UPDATE START: Add size constraints
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600, // Limits card width on large screens
          minWidth: 300, // Ensures minimum readable width
        ),
        // TASK 2 UPDATE END
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // TASK 2 UPDATE: Shrink-wrap content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('Name', user?.name ?? 'N/A'),
              _buildInfoRow('Email', user?.email ?? 'N/A'),
              const Divider(height: 30),
              _buildBalanceRow('Deposit', '${balance.dipositB} USD'),
              _buildBalanceRow('Package', balance.packages),
              _buildBalanceRow('Profit', '${balance.profitB} USD'),
            ],
          ),
        ),
      ),
    );
  }

  // Rest of the methods remain unchanged
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.blueGrey)),
        ],
      ),
    );
  }

  Widget _buildBalanceRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Text(value,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
        ],
      ),
    );
  }
}
