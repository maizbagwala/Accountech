

import 'dart:convert';

BusinessTypeModel businessTypeModelFromMap(String str) => BusinessTypeModel.fromMap(json.decode(str));

String businessTypeModelToMap(BusinessTypeModel data) => json.encode(data.toMap());

class BusinessTypeModel {
  BusinessTypeModel({
  required this.data,
  required this.message,
  required this.success,
  required this.status,
  });

  List<Datum> data;
  String message;
  bool success;
  int status;

  factory BusinessTypeModel.fromMap(Map<String, dynamic> json) => BusinessTypeModel(
    data:  List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    message: json["message"],
    success: json["success"],
    status: json["status"] ,
  );

  Map<String, dynamic> toMap() => {
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "message": message  ,
    "success": success ,
    "status": status,
  };
}

class Datum {
  Datum({
  required this.id,
  required this.businessType,
  });

  int id;
  String businessType;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    businessType: json["business_type"] ,
  );

  Map<String, dynamic> toMap() => {
    "id": id ,
    "business_type": businessType ,
  };
}
