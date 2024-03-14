
import 'dart:convert';

RegisterModel registerModelFromMap(String str) => RegisterModel.fromMap(json.decode(str));

String registerModelToMap(RegisterModel data) => json.encode(data.toMap());

class RegisterModel {
  RegisterModel({
    required this.data,
    required this.message,
    required this.success,
    required this.status,
  });

  Data? data;
  String? message;
  bool? success;
  int? status;

  factory RegisterModel.fromMap(Map<String, dynamic> json) => RegisterModel(
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
    message: json["message"],
    success: json["success"],
    status: json["status"] ,
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : data!.toMap(),
    "message": message ,
    "success": success ,
    "status": status ,
  };
}

class Data {
  Data({

    required this.mobileNo,

  });


  String? mobileNo;


  factory Data.fromMap(Map<String, dynamic> json) => Data(

    mobileNo: json["mobile_no"],

  );

  Map<String, dynamic> toMap() => {

    "mobile_no": mobileNo,

  };
}
