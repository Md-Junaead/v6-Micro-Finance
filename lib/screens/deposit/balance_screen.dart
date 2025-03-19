// balance_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'balance_view_model.dart';

class BalanceScreen extends StatelessWidget {
  final String userId;

  BalanceScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    // Fetch the balance from the view model
    return FutureBuilder(
      future: Provider.of<BalanceViewModel>(context, listen: false)
          .fetchBalance(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final balance = Provider.of<BalanceViewModel>(context).balance;
        if (balance == null) {
          return Center(child: Text('No balance data available'));
        }

        return Scaffold(
          appBar: AppBar(title: Text('Balance Details')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // children: [
              //   Text("Add Balance: \$${balance.addBalance}",
              //       style: TextStyle(fontSize: 20)),
              //   SizedBox(height: 10),
              //   // Text("Deposit Balance: \$${balance.dipositB}",
              //       style: TextStyle(fontSize: 20)),
              //   SizedBox(height: 10),
              //   Text("Packages: ${balance.packages}",
              //       style: TextStyle(fontSize: 20)),
              //   SizedBox(height: 10),
              //   Text("Profit Balance: \$${balance.profitB}",
              //       style: TextStyle(fontSize: 20)),
              // ],
            ),
          ),
        );
      },
    );
  }
}
