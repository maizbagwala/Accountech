// To parse this JSON data, do
//
//     final addExpenseResModel = addExpenseResModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddExpenseResModel addExpenseResModelFromMap(String str) => AddExpenseResModel.fromMap(json.decode(str));

String addExpenseResModelToMap(AddExpenseResModel data) => json.encode(data.toMap());

class AddExpenseResModel {
  AddExpenseResModel({
    required this.data,
    required this.message,
    required this.success,
    required this.status,
  });

  Data data;
  String message;
  bool success;
  int status;

  factory AddExpenseResModel.fromMap(Map<String, dynamic> json) => AddExpenseResModel(
    data: Data.fromMap(json["data"]),
    message: json["message"],
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": data.toMap(),
    "message": message,
    "success": success,
    "status": status,
  };
}

class Data {
  Data({
    required this.id,
  });

  int id;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
  };
}
