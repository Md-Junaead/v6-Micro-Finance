// balance_model.dart

class Balance {
  final int id;
  final double addBalance;
  final double dipositB;
  final String packages;
  final double profitB;
  final double referralB;
  final double profitreferralwithdraw;
  final double dipositwithdra;
  final double profitwithdra;
  final String date;
  final UserRegistration userRegistration;

  Balance({
    required this.id,
    required this.addBalance,
    required this.dipositB,
    required this.packages,
    required this.profitB,
    required this.referralB,
    required this.profitreferralwithdraw,
    required this.dipositwithdra,
    required this.profitwithdra,
    required this.date,
    required this.userRegistration,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      id: json['id'],
      addBalance: json['addBalance'].toDouble(),
      dipositB: json['dipositB'].toDouble(),
      packages: json['packages'],
      profitB: json['profitB'].toDouble(),
      referralB: json['referralB'].toDouble(),
      profitreferralwithdraw: json['profitreferralwithdraw'].toDouble(),
      dipositwithdra: json['dipositwithdra'].toDouble(),
      profitwithdra: json['profitwithdra'].toDouble(),
      date: json['date'],
      userRegistration: UserRegistration.fromJson(json['userRegistration']),
    );
  }
}

class UserRegistration {
  final int id;
  final String userid;
  final String name;
  final String email;
  final String phoneNo;
  final String address;
  final String country;
  final String dob;
  final String referralCode;

  UserRegistration({
    required this.id,
    required this.userid,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.country,
    required this.dob,
    required this.referralCode,
  });

  factory UserRegistration.fromJson(Map<String, dynamic> json) {
    return UserRegistration(
      id: json['id'],
      userid: json['userid'],
      name: json['name'],
      email: json['email'],
      phoneNo: json['phoneNo'] ?? '',
      address: json['address'] ?? '',
      country: json['country'],
      dob: json['dob'] ?? '',
      referralCode: json['referralCode'],
    );
  }
}
