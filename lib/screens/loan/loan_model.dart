import 'dart:convert';
import 'package:v1_micro_finance/configs/models/reg_model.dart';
import 'package:v1_micro_finance/screens/deposit/balance_model.dart';

List<Loan> loanFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Loan>.from(jsonData.map((x) => Loan.fromJson(x)));
}

String loanToJson(List<Loan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Loan {
  final int id;
  final double eligibleBalance;
  final double loanAmount;
  final double weeklyPay;
  final double totalPay;
  final int tenure;
  final String? status;
  final String? requestDate;
  final UserRegistration userRegistration;
  final Balance? balance;

  Loan({
    required this.id,
    required this.eligibleBalance,
    required this.loanAmount,
    required this.weeklyPay,
    required this.totalPay,
    required this.tenure,
    this.status,
    this.requestDate,
    required this.userRegistration,
    this.balance,
  });

  factory Loan.fromJson(Map<String, dynamic> json) => Loan(
        id: json["id"],
        eligibleBalance: (json["eligeblebalancey"] as num).toDouble(),
        loanAmount: (json["loanamuont"] as num).toDouble(),
        weeklyPay: (json["weeklypay"] as num).toDouble(),
        totalPay: (json["totalpay"] as num).toDouble(),
        tenure: json["tenure"],
        status: json["status"],
        requestDate: json["requestdate"],
        userRegistration: UserRegistration.fromJson(json["userRegistration"]),
        balance:
            json["balance"] != null ? Balance.fromJson(json["balance"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "eligeblebalancey": eligibleBalance,
        "loanamuont": loanAmount,
        "weeklypay": weeklyPay,
        "totalpay": totalPay,
        "tenure": tenure,
        "status": status,
        "requestdate": requestDate,
        "userRegistration": userRegistration.toJson(),
        // "balance": balance?.toJson(),
      };
}
