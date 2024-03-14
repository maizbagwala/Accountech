
import 'dart:convert';

IndustryTypeModel industryTypeModelFromMap(String str) => IndustryTypeModel.fromMap(json.decode(str));

String industryTypeModelToMap(IndustryTypeModel data) => json.encode(data.toMap());

class IndustryTypeModel {
  IndustryTypeModel({
    required this.data,
    required this.message,
    required this.success,
    required this.status,
  });

  List<Datum> data;
  String message;
  bool success;
  int status;

  factory IndustryTypeModel.fromMap(Map<String, dynamic> json) => IndustryTypeModel(
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
    required this.industryType,
  });

  int id;
  String industryType;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    industryType: json["industry_type"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "industry_type": industryType,
  };
}
