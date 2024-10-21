// ignore: unused_import
import 'dart:convert';

// Define the UserModel class
class UserModel {
  User user;
  String accessToken; // You may need this depending on your use case
  String refreshToken; // You may need this depending on your use case

  UserModel({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: User.fromJson(json),
        accessToken: json["accessToken"] ?? '',
        refreshToken: json["refreshToken"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

// Define the User class
class User {
  String id;
  String userId;
  String userPrefix;
  String userFname;
  String userLname;
  String userName;
  String role;
  String userPhone;
  String userEmail;

  User({
    required this.id,
    required this.userId,
    required this.userPrefix,
    required this.userFname,
    required this.userLname,
    required this.userName,
    required this.role,
    required this.userPhone,
    required this.userEmail,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] ?? '',
        userId: json["user_id"] ?? '',
        userPrefix: json["user_prefix"] ?? '',
        userFname: json["user_Fname"] ?? '',
        userLname: json["user_Lname"] ?? '',
        userName: json["user_name"] ?? '',
        role: json["role"] ?? '',
        userPhone: json["user_phone"] ?? '',
        userEmail: json["user_email"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "user_prefix": userPrefix,
        "user_Fname": userFname,
        "user_Lname": userLname,
        "user_name": userName,
        "role": role,
        "user_phone": userPhone,
        "user_email": userEmail,
      };
}
