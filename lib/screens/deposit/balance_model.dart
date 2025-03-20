// import 'package:v1_micro_finance/screens/signin/user_model.dart';

// class Balance {
//   final int id;
//   final int addBalance;
//   final int dipositB;
//   final String packages;
//   final double profitB;
//   final int referralB;
//   final int dipositwithdra;
//   final int profitwithdra;
//   final DateTime date;
//   final String status;
//   final bool active;
//   final User userRegistration;
//   final dynamic referral;

//   Balance({
//     required this.id,
//     required this.addBalance,
//     required this.dipositB,
//     required this.packages,
//     required this.profitB,
//     required this.referralB,
//     required this.dipositwithdra,
//     required this.profitwithdra,
//     required this.date,
//     required this.status,
//     required this.active,
//     required this.userRegistration,
//     this.referral,
//   });

//   factory Balance.fromJson(Map<String, dynamic> json) {
//     return Balance(
//       id: json['id'] as int,
//       addBalance: json['addBalance'] as int,
//       dipositB: json['dipositB'] as int,
//       packages: json['packages'] as String,
//       profitB: json['profitB'] as double,
//       referralB: json['referralB'] as int,
//       dipositwithdra: json['dipositwithdra'] as int,
//       profitwithdra: json['profitwithdra'] as int,
//       date: DateTime.parse(json['date'] as String),
//       status: json['status'] as String,
//       active: json['active'] as bool,
//       userRegistration: User.fromJson(json['userRegistration']),
//       referral: json['referral'],
//     );
//   }
// }

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
    required this.userRegistration,
    this.referral,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      id: json['id'] as int,
      // Changed: convert double to int if needed
      addBalance: json['addBalance'] is int
          ? json['addBalance']
          : (json['addBalance'] as double)
              .toInt(), // Changed to handle double values
      // Changed: convert double to int if needed
      dipositB: json['dipositB'] is int
          ? json['dipositB']
          : (json['dipositB'] as double)
              .toInt(), // Changed to handle double values
      packages: json['packages'] as String,
      profitB: json['profitB'] as double,
      // Changed: convert double to int if needed
      referralB: json['referralB'] is int
          ? json['referralB']
          : (json['referralB'] as double)
              .toInt(), // Changed to handle double values
      // Changed: convert double to int if needed
      dipositwithdra: json['dipositwithdra'] is int
          ? json['dipositwithdra']
          : (json['dipositwithdra'] as double)
              .toInt(), // Changed to handle double values
      // Changed: convert double to int if needed
      profitwithdra: json['profitwithdra'] is int
          ? json['profitwithdra']
          : (json['profitwithdra'] as double)
              .toInt(), // Changed to handle double values
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
      userRegistration: User.fromJson(json['userRegistration']),
      referral: json['referral'],
    );
  }

  toJson() {}
}
