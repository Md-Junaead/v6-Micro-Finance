class BankDepositWithdrawModel {
  final int id;
  final double? withdrawBalance;
  final int accountNumber;
  final String bankName;
  final int routingNumber;
  final int swiftCode;
  final double dipositWithdrawAmount;
  final DateTime requestDate;
  final String generatedOtp;
  final bool otpVerified;
  final DateTime otpGeneratedTime;
  final UserRegistration userRegistration;
  final Balance balance;

  BankDepositWithdrawModel({
    required this.id,
    this.withdrawBalance,
    required this.accountNumber,
    required this.bankName,
    required this.routingNumber,
    required this.swiftCode,
    required this.dipositWithdrawAmount,
    required this.requestDate,
    required this.generatedOtp,
    required this.otpVerified,
    required this.otpGeneratedTime,
    required this.userRegistration,
    required this.balance,
  });

  factory BankDepositWithdrawModel.fromJson(Map<String, dynamic> json) {
    return BankDepositWithdrawModel(
      id: json['id'],
      withdrawBalance: json['withdrawbalance']?.toDouble(),
      accountNumber: json['accountnumber'],
      bankName: json['bankname'],
      routingNumber: json['routingnumber'],
      swiftCode: json['swiftcode'],
      dipositWithdrawAmount: json['dipositwithdrawamount'].toDouble(),
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
  final DateTime? dob;
  final String referralCode;
  final String? nidnumber;
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
    this.nidnumber,
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
      dob: json['dob'] != null ? DateTime.tryParse(json['dob']) : null,
      referralCode: json['referralCode'],
      nidnumber: json['nidnumber'],
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
  final double dipositwithdra;
  final double profitwithdra;
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
      id: json['id'],
      addBalance: json['addBalance'].toDouble(),
      dipositB: json['dipositB'].toDouble(),
      packages: json['packages'],
      profitB: json['profitB'].toDouble(),
      referralB: json['referralB'].toDouble(),
      dipositwithdra: json['dipositwithdra'].toDouble(),
      profitwithdra: json['profitwithdra'].toDouble(),
      date: DateTime.parse(json['date']),
      status: json['status'],
      active: json['active'],
      userRegistration: UserRegistration.fromJson(json['userRegistration']),
      referral: json['referral'],
    );
  }
}
