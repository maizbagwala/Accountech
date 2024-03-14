// To parse this JSON data, do
//
//     final businessDetailsModel = businessDetailsModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BusinessDetailsModel businessDetailsModelFromMap(String str) => BusinessDetailsModel.fromMap(json.decode(str));

String businessDetailsModelToMap(BusinessDetailsModel data) => json.encode(data.toMap());

class BusinessDetailsModel {
  BusinessDetailsModel({
    required this.data,
    required this.message,
    required this.success,
    required this.status,
  });

  Data? data;
  String message;
  bool success;
  int status;

  factory BusinessDetailsModel.fromMap(Map<String, dynamic> json) => BusinessDetailsModel(
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
    required this.id,
    required this.businessName,
    required this.businessLogo,
    required this.businessPhone,
    required this.businessType,
    required this.industryType,
    required this.billingAddress,
    required this.gstNumber,
    required this.placeOfSupply,
    required this.upiId,
    required this.paymentTerms,
    required this.signatureImg,
  });

  int? id;
  String? businessName;
  String? businessLogo;
  int? businessPhone;
  String? businessType;
  int? industryType;
  String? billingAddress;
  String? gstNumber;
  int? placeOfSupply;
  String? upiId;
  String? paymentTerms;
  String? signatureImg;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    businessName: json["business_name"] == null ? null : json["business_name"],
    businessLogo: json["business_logo"] == null ? null : json["business_logo"],
    businessPhone: json["business_phone"] == null ? null : json["business_phone"],
    businessType: json["business_type"] == null ? null : json["business_type"],
    industryType: json["industry_type"] == null ? null : json["industry_type"],
    billingAddress: json["billing_address"] == null ? null : json["billing_address"],
    gstNumber: json["gst_number"] == null ? null : json["gst_number"],
    placeOfSupply: json["place_of_supply"] == null ? null : json["place_of_supply"],
    upiId: json["upi_id"] == null ? null : json["upi_id"],
    paymentTerms: json["payment_terms"] == null ? null : json["payment_terms"],
    signatureImg: json["signature_img"] == null ? null : json["signature_img"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "business_name": businessName == null ? null : businessName,
    "business_logo": businessLogo == null ? null : businessLogo,
    "business_phone": businessPhone == null ? null : businessPhone,
    "business_type": businessType == null ? null : businessType,
    "industry_type": industryType == null ? null : industryType,
    "billing_address": billingAddress == null ? null : billingAddress,
    "gst_number": gstNumber == null ? null : gstNumber,
    "place_of_supply": placeOfSupply == null ? null : placeOfSupply,
    "upi_id": upiId == null ? null : upiId,
    "payment_terms": paymentTerms == null ? null : paymentTerms,
    "signature_img": signatureImg == null ? null : signatureImg,
  };
}
