// To parse this JSON data, do
//
//     final partyClassListModel = partyClassListModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PartyClassListModel partyClassListModelFromMap(String str) => PartyClassListModel.fromMap(json.decode(str));

String partyClassListModelToMap(PartyClassListModel data) => json.encode(data.toMap());

class PartyClassListModel {
  PartyClassListModel({
    required this.data,
    required this.message,
    required this.success,
    required this.status,
  });

  List<Datum> data;
  String message;
  bool success;
  int status;

  factory PartyClassListModel.fromMap(Map<String, dynamic> json) => PartyClassListModel(
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
    required this.className,
  });

  int id;
  String className;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    className: json["class_name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "class_name": className,
  };
}
