
import 'dart:convert';

GetExpenseCategoryModel getExpenseCategoryModelFromMap(String str) => GetExpenseCategoryModel.fromMap(json.decode(str));


class GetExpenseCategoryModel {
  GetExpenseCategoryModel({
    required this.data,
    required this.message,
    required this.success,
    required this.status,
  });

  List<Datum>? data;
  String message;
  bool success;
  int status;

  factory GetExpenseCategoryModel.fromMap(Map<String, dynamic> json) => GetExpenseCategoryModel(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    message: json["message"],
    success: json["success"],
    status: json["status"] ,
  );


}

class Datum {
  Datum({
    required this.id,
    required this.name,
  });

  int? id;
  String? name;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name ,
  };
}
