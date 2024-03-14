// To parse this JSON data, do
//
//     final companyListModel = companyListModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CompanyListModel companyListModelFromMap(String str) => CompanyListModel.fromMap(json.decode(str));

String companyListModelToMap(CompanyListModel data) => json.encode(data.toMap());

class CompanyListModel {
  CompanyListModel({
   required this.data,
   required this.message,
   required this.success,
   required this.status,
  });

  List<Datum> data;
  String message;
  bool success;
  int status;

  factory CompanyListModel.fromMap(Map<String, dynamic> json) => CompanyListModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    message: json["message"],
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "message": message,
    "success": success,
    "status": status,
  };
}

class Datum {
  Datum({
   required this.id,
   required this.businessName,
   required this.businessLogo,
   required this.industryType,
   required this.businessPhone,
  });

  int id;
  String businessName;
  String businessLogo;
  String industryType;
  int businessPhone;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    businessName: json["business_name"],
    businessLogo: json["business_logo"],
    industryType: json["industry_type"],
    businessPhone: json["business_phone"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "business_name": businessName,
    "business_logo": businessLogo,
    "industry_type": industryType,
    "business_phone": businessPhone,
  };
}
