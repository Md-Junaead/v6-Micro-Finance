import 'package:flutter/material.dart';
import 'package:v1_micro_finance/configs/widgets/arrow_appbar.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({super.key});

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArrowAppBar(title: "Statement"),
      body: const Center(
        child: Text(
          'All the Statement will show here',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
