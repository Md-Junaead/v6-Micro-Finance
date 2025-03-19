import 'package:v1_micro_finance/screens/signin/user_model.dart';

class Balance {
  final int id;
  final int addBalance;
  final int dipositB;
  final String packages;
  final double profitB;
  final int referralB;
  final int dipositwithdra;
  final int profitwithdra;
  final DateTime date;
  final String status;
  final bool active;
  final User userRegistration;
  final dynamic referral;

  Balance({
    required this.id,
    required this.addBalance,
    required this.dipositB,
    required this.packages,
    required this.profitB,
    required this.referralB,
    required this.dipositwithdra,
    required this.profitwithdra,
    required this.date,
    required this.status,
    required this.active,
    required this.userRegistration,
    this.referral,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      id: json['id'] as int,
      addBalance: json['addBalance'] as int,
      dipositB: json['dipositB'] as int,
      packages: json['packages'] as String,
      profitB: json['profitB'] as double,
      referralB: json['referralB'] as int,
      dipositwithdra: json['dipositwithdra'] as int,
      profitwithdra: json['profitwithdra'] as int,
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
      active: json['active'] as bool,
      userRegistration: User.fromJson(json['userRegistration']),
      referral: json['referral'],
    );
  }
}
