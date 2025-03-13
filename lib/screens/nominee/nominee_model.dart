import 'dart:convert';
// Import the User model from your sign-in folder instead of redefining it here
import 'package:v1_micro_finance/screens/signin/user_model.dart';

class NomineeModel {
  final int id;
  final String name;
  final String email;
  final String cellNo;
  final DateTime dob;
  final String relationship;
  final User user;

  NomineeModel({
    required this.id,
    required this.name,
    required this.email,
    required this.cellNo,
    required this.dob,
    required this.relationship,
    required this.user,
  });

  factory NomineeModel.fromJson(Map<String, dynamic> json) {
    return NomineeModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      cellNo: json['cellNo'],
      dob: DateTime.parse(json['dob']),
      relationship: json['relationship'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'cellNo': cellNo,
      'dob': dob.toIso8601String(),
      'relationship': relationship,
      'user': user.toJson(),
    };
  }
}

List<NomineeModel> nomineeModelFromJson(String str) => List<NomineeModel>.from(
    json.decode(str).map((x) => NomineeModel.fromJson(x)));

String nomineeModelToJson(List<NomineeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
