// To parse this JSON data, do
//
//     final partyListModel = partyListModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PartyListModel partyListModelFromMap(String str) => PartyListModel.fromMap(json.decode(str));

String partyListModelToMap(PartyListModel data) => json.encode(data.toMap());

class PartyListModel {
  PartyListModel({
    required this.data,
    required this.message,
    required this.success,
    required this.status,
  });

  List<Datum> data;
  String message;
  bool success;
  int status;

  factory PartyListModel.fromMap(Map<String, dynamic> json) => PartyListModel(
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
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.gstNo,
    required this.partyType,
    required this.partyClass,
    required this.openingBalance,
    required this.billingAddress,
  });

  int id;
  String name;
  String email;
  int mobileNo;
  String gstNo;
  String partyType;
  String partyClass;
  int openingBalance;
  String billingAddress;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobileNo: json["mobile_no"],
    gstNo: json["gst_no"],
    partyType: json["party_type"],
    partyClass: json["party_class"],
    openingBalance: json["opening_balance"],
    billingAddress: json["billing_address"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile_no": mobileNo,
    "gst_no": gstNo,
    "party_type": partyType,
    "party_class": partyClass,
    "opening_balance": openingBalance,
    "billing_address": billingAddress,
  };
}
