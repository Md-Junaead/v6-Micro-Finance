import 'package:flutter/material.dart';
import 'package:v1_micro_finance/screens/loan/loan_model.dart';

class LoanCard extends StatelessWidget {
  final Loan loan;

  const LoanCard({super.key, required this.loan});

  // Helper method to get status color
  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'pending':
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Information Section
            if (loan.userRegistration != null) ...[
              // Bold user name with email verification
              Text(
                loan.userRegistration!.name ?? 'No Name',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
              ),
              const SizedBox(height: 4),
              // Email verification display
              Row(
                children: [
                  const Icon(Icons.email_outlined,
                      size: 14, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(
                    loan.userRegistration!.email ?? 'No Email',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
              const Divider(height: 24),
            ],

            // Loan Details Section
            _buildDetailRow(
              context,
              icon: Icons.credit_score,
              label: 'Loan ID',
              value: loan.id?.toString() ?? 'N/A',
            ),
            _buildDetailRow(
              context,
              icon: Icons.attach_money,
              label: 'Amount',
              value: '${loan.loanamuont?.toStringAsFixed(2) ?? '0.00'} USD',
            ),
            _buildDetailRow(
              context,
              icon: Icons.calendar_today,
              label: 'Request Date',
              value: loan.requestdate?.split('T').first ?? 'N/A',
            ),
            const SizedBox(height: 8),

            // Status Chip
            Align(
              alignment: Alignment.centerRight,
              child: Chip(
                backgroundColor: _getStatusColor(loan.status).withOpacity(0.1),
                label: Text(
                  loan.status?.toUpperCase() ?? 'UNKNOWN',
                  style: TextStyle(
                    color: _getStatusColor(loan.status),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable detail row widget
  Widget _buildDetailRow(BuildContext context,
      {IconData? icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  TextSpan(
                    text: value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black87,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
