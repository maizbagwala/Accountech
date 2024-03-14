// To parse this JSON data, do
//
//     final expensesListModel = expensesListModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ExpensesListModel expensesListModelFromMap(String str) => ExpensesListModel.fromMap(json.decode(str));

String expensesListModelToMap(ExpensesListModel data) => json.encode(data.toMap());

class ExpensesListModel {
  ExpensesListModel({
    required this.data,
    required this.message,
    required this.success,
    required this.status,
  });

  List<Datum> data;
  String message;
  bool success;
  int status;

  factory ExpensesListModel.fromMap(Map<String, dynamic> json) => ExpensesListModel(
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
    required this.date,
    required this.expenseNo,
    required this.category,
    required this.categoryName,
    required this.amount,
  });

  int id;
  String date;
  String expenseNo;
  int category;
  String categoryName;
  int amount;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    date: json["date"],
    expenseNo: json["expense_no"],
    category: json["category"],
    categoryName: json["category_name"],
    amount: json["amount"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "date": date,
    "expense_no": expenseNo,
    "category": category,
    "category_name": categoryName,
    "amount": amount,
  };
}
