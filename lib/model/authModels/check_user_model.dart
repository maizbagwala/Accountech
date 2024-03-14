// To parse this JSON data, do
//
//     final checkUserModel = checkUserModelFromMap(jsonString);

import 'dart:convert';

CheckUserModel checkUserModelFromMap(String str) => CheckUserModel.fromMap(json.decode(str));

String checkUserModelToMap(CheckUserModel data) => json.encode(data.toMap());

class CheckUserModel {
  CheckUserModel({
    required this.data,
    required this.message,
    required this.success,
    required this.status,
  });

  Data? data;
  String message;
  bool success;
  int status;

  factory CheckUserModel.fromMap(Map<String, dynamic> json) => CheckUserModel(
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
  });

  String? mobileNo;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    mobileNo: json["mobile_no"] == null ? null : json["mobile_no"],
  );

  Map<String, dynamic> toMap() => {
    "mobile_no": mobileNo == null ? null : mobileNo,
  };
}
