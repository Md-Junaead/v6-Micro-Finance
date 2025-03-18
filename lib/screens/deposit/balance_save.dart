// balance_save_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'balance_view_model.dart';

class BalanceSaveScreen extends StatefulWidget {
  final String userId;

  const BalanceSaveScreen({super.key, required this.userId});

  @override
  _BalanceSaveScreenState createState() => _BalanceSaveScreenState();
}

class _BalanceSaveScreenState extends State<BalanceSaveScreen> {
  final _controller = TextEditingController();

  // Function to handle deposit action
  void _deposit() async {
    final amount = double.tryParse(_controller.text);
    if (amount != null && amount > 0) {
      try {
        await Provider.of<BalanceViewModel>(context, listen: false)
            .depositBalance(widget.userId, amount);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Deposit successful!')));
        Navigator.pop(context); // Go back to balance screen after deposit
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Deposit failed')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid deposit amount')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Deposit Balance')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Deposit Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _deposit,
              child: Text('Deposit'),
            ),
          ],
        ),
      ),
    );
  }
}
