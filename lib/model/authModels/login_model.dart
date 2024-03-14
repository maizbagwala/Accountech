
import 'dart:convert';

LoginModel loginModelFromMap(String str) => LoginModel.fromMap(json.decode(str));

String loginModelToMap(LoginModel data) => json.encode(data.toMap());

class LoginModel {
  LoginModel({
    required this.data,
    required this.message,
    required this.success,
    required this.status,
  });

  Data? data;
  String message;
  bool success;
  int status;

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
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
    required this.mobileNo,
    required this.isActive,
    required this.name,
  });

  String? mobileNo;
  int isActive;
  String name;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    mobileNo: json["mobile_no"] == null ? null : json["mobile_no"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toMap() => {
    "mobile_no": mobileNo == null ? null : mobileNo,
    "is_active": isActive == null ? null : isActive,
    "name": name == null ? null : name,
  };
}
