import 'package:flutter/material.dart';
import 'package:v1_micro_finance/configs/widgets/arrow_appbar.dart';

// Verification Screen

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArrowAppBar(title: "Notification"),
      body: Center(
        child: Text('All The Notification will show here'),
      ),
    );
  }
}
