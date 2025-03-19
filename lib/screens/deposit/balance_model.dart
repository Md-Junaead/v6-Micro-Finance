import 'dart:convert';
import 'package:v1_micro_finance/configs/models/reg_model.dart';

List<Balance> balanceFromJson(String str) =>
    List<Balance>.from(json.decode(str).map((x) => Balance.fromJson(x)));

class Balance {
  final int id;
  final double addBalance;
  final double deposit;
  final String packages;
  final double profit;
  final double referral;
  final double depositWithdraw;
  final double profitWithdraw;
  final DateTime date;
  final UserRegistration userRegistration;

  Balance({
    required this.id,
    required this.addBalance,
    required this.deposit,
    required this.packages,
    required this.profit,
    required this.referral,
    required this.depositWithdraw,
    required this.profitWithdraw,
    required this.date,
    required this.userRegistration,
  });

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        id: json["id"],
        addBalance: (json["addBalance"] as num).toDouble(),
        deposit: (json['dipositB'] as num?)?.toDouble() ??
            0.0, // Handling possible null values
        profit: (json['profitB'] as num?)?.toDouble() ?? 0.0,
        packages: json["packages"],
        referral: (json["referralB"] as num?)?.toDouble() ?? 0.0,
        depositWithdraw: (json["dipositwithdra"] as num?)?.toDouble() ?? 0.0,
        profitWithdraw: (json["profitwithdra"] as num?)?.toDouble() ?? 0.0,
        date: json["date"] != null
            ? DateTime.parse(json["date"])
            : DateTime.now(),
        userRegistration:
            UserRegistration.fromJson(json["userRegistration"] ?? {}),
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "addBalance": addBalance,
      "dipositB": deposit,
      "profitB": profit,
      "packages": packages,
      "referralB": referral,
      "dipositwithdra": depositWithdraw,
      "profitwithdra": profitWithdraw,
      "date": date.toIso8601String(),
      "userRegistration": userRegistration.toJson(),
    };
  }
}

// import 'dart:convert';

// import 'package:v1_micro_finance/configs/models/reg_model.dart';

// List<Balance> balanceFromJson(String str) =>
//     List<Balance>.from(json.decode(str).map((x) => Balance.fromJson(x)));

// class Balance {
//   final int id;
//   final double addBalance;
//   final double deposit;
//   final String packages;
//   final double profit;
//   final double referral;
//   final double depositWithdraw;
//   final double profitWithdraw;
//   final DateTime date;
//   final UserRegistration userRegistration;

//   Balance({
//     required this.id,
//     required this.addBalance,
//     required this.deposit,
//     required this.packages,
//     required this.profit,
//     required this.referral,
//     required this.depositWithdraw,
//     required this.profitWithdraw,
//     required this.date,
//     required this.userRegistration,
//   });

//   factory Balance.fromJson(Map<String, dynamic> json) => Balance(
//         id: json["id"],
//         addBalance: (json["addBalance"] as num).toDouble(),
//         deposit:
//             (json['dipositB'] as num).toDouble(), // Note the correct JSON key
//         profit: (json['profitB'] as num).toDouble(),
//         packages: json["packages"],
//         referral: (json["referralB"] as num).toDouble(),
//         depositWithdraw: (json["dipositwithdra"] as num).toDouble(),
//         profitWithdraw: (json["profitwithdra"] as num).toDouble(),
//         date: DateTime.parse(json["date"]),
//         userRegistration: UserRegistration.fromJson(json["userRegistration"]),
//       );

//   toJson() {}
// }
