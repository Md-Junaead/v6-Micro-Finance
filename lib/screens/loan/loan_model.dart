class Loan {
  int? id;
  double? eligeblebalancey;
  // int? eligeblebalancey;
  int? loanamuont;
  double? weeklypay;
  double? totalpay;
  int? tenure;
  String? status;
  String? requestdate;
  UserRegistration? userRegistration;
  Balance? balance;

  Loan({
    this.id,
    this.eligeblebalancey,
    this.loanamuont,
    this.weeklypay,
    this.totalpay,
    this.tenure,
    this.status,
    this.requestdate,
    this.userRegistration,
    this.balance,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    try {
      // print("ID Type: ${json["id"]?.runtimeType}");
      // print("eligeblebalancey Type: ${json["eligeblebalancey"]?.runtimeType}");
      // print("loanamuont Type: ${json["loanamuont"]?.runtimeType}");
      // print("weeklypay Type: ${json["weeklypay"]?.runtimeType}");
      // print("totalpay Type: ${json["totalpay"]?.runtimeType}");
      // print("tenure Type: ${json["tenure"]?.runtimeType}");
      return Loan(
        id: json["id"] as int?,
        eligeblebalancey: _toDouble(json["eligeblebalancey"]),
        loanamuont: _toInt(json["loanamuont"]),
        weeklypay: json["weeklypay"]?.toDouble(),
        totalpay: json["totalpay"]?.toDouble(),
        tenure: json["tenure"],
        status: json["status"],
        requestdate: json["requestdate"],
        userRegistration: json["userRegistration"] == null
            ? null
            : UserRegistration.fromJson(json["userRegistration"]),
        balance:
            json["balance"] == null ? null : Balance.fromJson(json["balance"]),
      );
    } catch (e, stacktrace) {
      print("Loan fetch error: $e");
      print(stacktrace);
      return Loan(); // Return an empty object to avoid crashes
    }
  }
  static List<Loan> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Loan.fromJson(json)).toList();
  }

  static double? _toDouble(dynamic value) =>
      value is num ? value.toDouble() : null;
  static int? _toInt(dynamic value) => value is num ? value.toInt() : null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "eligeblebalancey": eligeblebalancey,
        "loanamuont": loanamuont,
        "weeklypay": weeklypay,
        "totalpay": totalpay,
        "tenure": tenure,
        "status": status,
        "requestdate": requestdate,
        "userRegistration": userRegistration?.toJson(),
        "balance": balance?.toJson(),
      };
}

class UserRegistration {
  int? id;
  String? userid;
  String? name;
  String? email;
  String? password;
  String? phoneNo;
  String? address;
  String? country;
  String? dob;
  String? referralCode;
  String? nidnumber;
  dynamic passport;
  bool? active;
  String? role;
  bool? enabled;
  List<Authority>? authorities;
  bool? lock;
  bool? accountNonLocked;
  String? username;
  bool? accountNonExpired;
  bool? credentialsNonExpired;

  UserRegistration({
    this.id,
    this.userid,
    this.name,
    this.email,
    this.password,
    this.phoneNo,
    this.address,
    this.country,
    this.dob,
    this.referralCode,
    this.nidnumber,
    this.passport,
    this.active,
    this.role,
    this.enabled,
    this.authorities,
    this.lock,
    this.accountNonLocked,
    this.username,
    this.accountNonExpired,
    this.credentialsNonExpired,
  });

  factory UserRegistration.fromJson(Map<String, dynamic> json) =>
      UserRegistration(
        id: json["id"],
        userid: json["userid"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phoneNo: json["phoneNo"],
        address: json["address"],
        country: json["country"],
        dob: json["dob"],
        referralCode: json["referralCode"],
        nidnumber: json["nidnumber"],
        passport: json["passport"],
        active: json["active"],
        role: json["role"],
        enabled: json["enabled"],
        authorities: json["authorities"] == null
            ? []
            : List<Authority>.from(
                json["authorities"]!.map((x) => Authority.fromJson(x))),
        lock: json["lock"],
        accountNonLocked: json["accountNonLocked"],
        username: json["username"],
        accountNonExpired: json["accountNonExpired"],
        credentialsNonExpired: json["credentialsNonExpired"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "name": name,
        "email": email,
        "password": password,
        "phoneNo": phoneNo,
        "address": address,
        "country": country,
        "dob": dob,
        "referralCode": referralCode,
        "nidnumber": nidnumber,
        "passport": passport,
        "active": active,
        "role": role,
        "enabled": enabled,
        "authorities": authorities == null
            ? []
            : List<dynamic>.from(authorities!.map((x) => x.toJson())),
        "lock": lock,
        "accountNonLocked": accountNonLocked,
        "username": username,
        "accountNonExpired": accountNonExpired,
        "credentialsNonExpired": credentialsNonExpired,
      };
}

class Balance {
  int? id;
  int? addBalance;
  int? dipositB;
  String? packages;
  double? profitB;
  int? referralB;
  int? dipositwithdra;
  int? profitwithdra;
  String? date;
  String? status;
  bool? active;
  UserRegistration? userRegistration;
  dynamic referral;

  Balance({
    this.id,
    this.addBalance,
    this.dipositB,
    this.packages,
    this.profitB,
    this.referralB,
    this.dipositwithdra,
    this.profitwithdra,
    this.date,
    this.status,
    this.active,
    this.userRegistration,
    this.referral,
  });

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        id: json["id"],
        addBalance: json["addBalance"],
        dipositB: json["dipositB"],
        packages: json["packages"],
        profitB: json["profitB"]?.toDouble(),
        referralB: json["referralB"],
        dipositwithdra: json["dipositwithdra"],
        profitwithdra: json["profitwithdra"],
        date: json["date"],
        status: json["status"],
        active: json["active"],
        userRegistration: json["userRegistration"] == null
            ? null
            : UserRegistration.fromJson(json["userRegistration"]),
        referral: json["referral"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "addBalance": addBalance,
        "dipositB": dipositB,
        "packages": packages,
        "profitB": profitB,
        "referralB": referralB,
        "dipositwithdra": dipositwithdra,
        "profitwithdra": profitwithdra,
        "date": date,
        "status": status,
        "active": active,
        "userRegistration": userRegistration?.toJson(),
        "referral": referral,
      };
}

class Authority {
  String? authority;

  Authority({
    this.authority,
  });

  factory Authority.fromJson(Map<String, dynamic> json) => Authority(
        authority: json["authority"],
      );

  Map<String, dynamic> toJson() => {
        "authority": authority,
      };
}
