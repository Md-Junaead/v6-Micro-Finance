import 'dart:convert';

Loan loanFromJson(String str) => Loan.fromJson(json.decode(str));

String loanToJson(Loan data) => json.encode(data.toJson());

class Loan {
  int id;
  double eligebleBalance;
  double loanAmount;
  double weeklyPay;
  double totalPay;
  int tenure;
  String? status;
  String? requestDate;
  UserRegistration userRegistration;
  Balance? balance;

  Loan({
    required this.id,
    required this.eligebleBalance,
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
        eligebleBalance: (json["eligeblebalancey"] as num).toDouble(),
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
        "eligeblebalancey": eligebleBalance,
        "loanamuont": loanAmount,
        "weeklypay": weeklyPay,
        "totalpay": totalPay,
        "tenure": tenure,
        "status": status,
        "requestdate": requestDate,
        "userRegistration": userRegistration.toJson(),
        "balance": balance?.toJson(),
      };
}

class UserRegistration {
  int id;
  String userId;
  String name;
  String email;
  String? phoneNo;
  String? address;
  String country;
  bool active;
  String role;

  UserRegistration({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    this.phoneNo,
    this.address,
    required this.country,
    required this.active,
    required this.role,
  });

  factory UserRegistration.fromJson(Map<String, dynamic> json) =>
      UserRegistration(
        id: json["id"],
        userId: json["userid"],
        name: json["name"],
        email: json["email"],
        phoneNo: json["phoneNo"],
        address: json["address"],
        country: json["country"],
        active: json["active"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userId,
        "name": name,
        "email": email,
        "phoneNo": phoneNo,
        "address": address,
        "country": country,
        "active": active,
        "role": role,
      };
}

class Balance {
  int id;
  double addBalance;
  double deposit;
  String packages;
  double profit;
  double referral;
  double depositWithdraw;
  double profitWithdraw;
  String date;
  UserRegistration userRegistration;

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
        deposit: (json["dipositB"] as num).toDouble(),
        packages: json["packages"],
        profit: (json["profitB"] as num).toDouble(),
        referral: (json["referralB"] as num).toDouble(),
        depositWithdraw: (json["dipositwithdra"] as num).toDouble(),
        profitWithdraw: (json["profitwithdra"] as num).toDouble(),
        date: json["date"],
        userRegistration: UserRegistration.fromJson(json["userRegistration"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "addBalance": addBalance,
        "dipositB": deposit,
        "packages": packages,
        "profitB": profit,
        "referralB": referral,
        "dipositwithdra": depositWithdraw,
        "profitwithdra": profitWithdraw,
        "date": date,
        "userRegistration": userRegistration.toJson(),
      };
}
