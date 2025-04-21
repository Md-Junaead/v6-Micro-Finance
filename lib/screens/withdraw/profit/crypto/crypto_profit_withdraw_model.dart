class CryptoProfitWithdrawModel {
  final int id;
  final String withdrawBalance;
  final String walletId;
  final String btc;
  final String usdt;
  final double amount;
  final DateTime requestDate;
  final String generatedOtp;
  final bool otpVerified;
  final DateTime otpGeneratedTime;
  final UserRegistration userRegistration;
  final Balance balance;

  CryptoProfitWithdrawModel({
    required this.id,
    required this.withdrawBalance,
    required this.walletId,
    required this.btc,
    required this.usdt,
    required this.amount,
    required this.requestDate,
    required this.generatedOtp,
    required this.otpVerified,
    required this.otpGeneratedTime,
    required this.userRegistration,
    required this.balance,
  });

  factory CryptoProfitWithdrawModel.fromJson(Map<String, dynamic> json) {
    return CryptoProfitWithdrawModel(
      id: json['id'],
      withdrawBalance: json['withdrawbalance'],
      walletId: json['walletid'],
      btc: json['btc'],
      usdt: json['usdt'],
      amount: (json['amount'] as num).toDouble(),
      requestDate: DateTime.parse(json['requestdate']),
      generatedOtp: json['generatedOtp'],
      otpVerified: json['otpVerified'],
      otpGeneratedTime: DateTime.parse(json['otpGeneratedTime']),
      userRegistration: UserRegistration.fromJson(json['userRegistration']),
      balance: Balance.fromJson(json['balance']),
    );
  }
}

class UserRegistration {
  final int id;
  final String userid;
  final String name;
  final String email;
  final String password;
  final String? phoneNo;
  final String? address;
  final String country;
  final String? dob;
  final String referralCode;
  final String? nidNumber;
  final String? passport;
  final bool active;
  final String role;
  final bool enabled;
  final String username;
  final List<Authority> authorities;
  final bool lock;
  final bool accountNonLocked;
  final bool accountNonExpired;
  final bool credentialsNonExpired;

  UserRegistration({
    required this.id,
    required this.userid,
    required this.name,
    required this.email,
    required this.password,
    this.phoneNo,
    this.address,
    required this.country,
    this.dob,
    required this.referralCode,
    this.nidNumber,
    this.passport,
    required this.active,
    required this.role,
    required this.enabled,
    required this.username,
    required this.authorities,
    required this.lock,
    required this.accountNonLocked,
    required this.accountNonExpired,
    required this.credentialsNonExpired,
  });

  factory UserRegistration.fromJson(Map<String, dynamic> json) {
    return UserRegistration(
      id: json['id'],
      userid: json['userid'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNo: json['phoneNo'],
      address: json['address'],
      country: json['country'],
      dob: json['dob'],
      referralCode: json['referralCode'],
      nidNumber: json['nidnumber'],
      passport: json['passport'],
      active: json['active'],
      role: json['role'],
      enabled: json['enabled'],
      username: json['username'],
      authorities: (json['authorities'] as List)
          .map((e) => Authority.fromJson(e))
          .toList(),
      lock: json['lock'],
      accountNonLocked: json['accountNonLocked'],
      accountNonExpired: json['accountNonExpired'],
      credentialsNonExpired: json['credentialsNonExpired'],
    );
  }
}

class Authority {
  final String authority;

  Authority({required this.authority});

  factory Authority.fromJson(Map<String, dynamic> json) {
    return Authority(authority: json['authority']);
  }
}

class Balance {
  final int id;
  final double addBalance;
  final double dipositB;
  final String packages;
  final double profitB;
  final double referralB;
  final double dipositWithdra;
  final double profitWithdra;
  final DateTime date;
  final String status;
  final bool active;
  final UserRegistration userRegistration;
  final dynamic referral;

  Balance({
    required this.id,
    required this.addBalance,
    required this.dipositB,
    required this.packages,
    required this.profitB,
    required this.referralB,
    required this.dipositWithdra,
    required this.profitWithdra,
    required this.date,
    required this.status,
    required this.active,
    required this.userRegistration,
    this.referral,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      id: json['id'],
      addBalance: (json['addBalance'] as num).toDouble(),
      dipositB: (json['dipositB'] as num).toDouble(),
      packages: json['packages'],
      profitB: (json['profitB'] as num).toDouble(),
      referralB: (json['referralB'] as num).toDouble(),
      dipositWithdra: (json['dipositwithdra'] as num).toDouble(),
      profitWithdra: (json['profitwithdra'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      status: json['status'],
      active: json['active'],
      userRegistration: UserRegistration.fromJson(json['userRegistration']),
      referral: json['referral'],
    );
  }
}
