import 'dart:convert';
import 'package:v1_micro_finance/screens/signin/user_model.dart';

class Loan {
  final int id;
  final double eligebleBalance;
  final double loanAmount;
  final double weeklyPay;
  final double totalPay;
  final int tenure;
  final String status;
  final DateTime? requestDate;
  final User user;
  final Balance balance;

  Loan({
    required this.id,
    required this.eligebleBalance,
    required this.loanAmount,
    required this.weeklyPay,
    required this.totalPay,
    required this.tenure,
    required this.status,
    this.requestDate,
    required this.user,
    required this.balance,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      id: json['id'],
      eligebleBalance: (json['eligeblebalancey'] as num).toDouble(),
      loanAmount: (json['loanamuont'] as num).toDouble(),
      weeklyPay: (json['weeklypay'] as num).toDouble(),
      totalPay: (json['totalpay'] as num).toDouble(),
      tenure: json['tenure'],
      status: json['status'],
      requestDate: json['requestdate'] != null
          ? DateTime.parse(json['requestdate'])
          : null,
      user: User.fromJson({
        ...json['userRegistration'],
        'dob': _convertDob(json['userRegistration']['dob']),
      }),
      balance: Balance.fromJson(json['balance']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'eligeblebalancey': eligebleBalance,
        'loanamuont': loanAmount,
        'weeklypay': weeklyPay,
        'totalpay': totalPay,
        'tenure': tenure,
        'status': status,
        'requestdate': requestDate?.toIso8601String(),
        'userRegistration': {
          ...user.toJson(),
          'dob': user.dob != null
              ? DateTime.parse(user.dob!).toIso8601String()
              : null,
        },
        'balance': balance.toJson(),
      };

  static String? _convertDob(dynamic dob) {
    if (dob == null) return null;
    if (dob is DateTime) return dob.toIso8601String();
    if (dob is String) return dob;
    return null;
  }
}

class Balance {
  final int id;
  final double addBalance;
  final double depositBalance;
  final String packages;
  final double profitBalance;
  final double referralBalance;
  final double profitReferralWithdraw;
  final double depositWithdraw;
  final double profitWithdraw;
  final DateTime date;
  final User user;

  Balance({
    required this.id,
    required this.addBalance,
    required this.depositBalance,
    required this.packages,
    required this.profitBalance,
    required this.referralBalance,
    required this.profitReferralWithdraw,
    required this.depositWithdraw,
    required this.profitWithdraw,
    required this.date,
    required this.user,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      id: json['id'],
      addBalance: (json['addBalance'] as num).toDouble(),
      depositBalance: (json['dipositB'] as num).toDouble(),
      packages: json['packages'],
      profitBalance: (json['profitB'] as num).toDouble(),
      referralBalance: (json['referralB'] as num).toDouble(),
      profitReferralWithdraw:
          (json['profitreferralwithdraw'] as num).toDouble(),
      depositWithdraw: (json['dipositwithdra'] as num).toDouble(),
      profitWithdraw: (json['profitwithdra'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      user: User.fromJson({
        ...json['userRegistration'],
        'dob': Loan._convertDob(json['userRegistration']['dob']),
      }),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'addBalance': addBalance,
        'dipositB': depositBalance,
        'packages': packages,
        'profitB': profitBalance,
        'referralB': referralBalance,
        'profitreferralwithdraw': profitReferralWithdraw,
        'dipositwithdra': depositWithdraw,
        'profitwithdra': profitWithdraw,
        'date': date.toIso8601String(),
        'userRegistration': {
          ...user.toJson(),
          'dob': user.dob != null
              ? DateTime.parse(user.dob!).toIso8601String()
              : null,
        },
      };
}

List<Loan> loanFromJson(String str) =>
    List<Loan>.from(json.decode(str).map((x) => Loan.fromJson(x)));
String loanToJson(List<Loan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
