// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  UserModel({
    required this.data,
    required this.message,
    required this.success,
    required this.status,
  });

  Data? data;
  String message;
  bool success;
  int status;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : data!.toMap(),
    "message": message == null ? null : message,
    "success": success == null ? null : success,
    "status": status == null ? null : status,
  };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.mobileNo,
    required this.panNo,
    required this.uImage,
    required this.email,
    required this.emailVerifiedAt,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.profileImage,
    required this.accessToken,
  });

  int? id;
  String? name;
  String? mobileNo;
  String? panNo;
  String? uImage;
  String? email;
  String? emailVerifiedAt;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? profileImage;
  String? accessToken;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    mobileNo: json["mobile_no"] == null ? null : json["mobile_no"],
    panNo: json["pan_no"],
    uImage: json["u_image"] == null ? null : json["u_image"],
    email: json["email"] == null ? null : json["email"],
    emailVerifiedAt: json["email_verified_at"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    profileImage: json["profile_image"] == null ? null : json["profile_image"],
    accessToken: json["access_token"] == null ? null : json["access_token"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "mobile_no": mobileNo == null ? null : mobileNo,
    "pan_no": panNo,
    "u_image": uImage == null ? null : uImage,
    "email": email == null ? null : email,
    "email_verified_at": emailVerifiedAt,
    "is_active": isActive == null ? null : isActive,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "profile_image": profileImage == null ? null : profileImage,
    "access_token": accessToken == null ? null : accessToken,
  };
}
