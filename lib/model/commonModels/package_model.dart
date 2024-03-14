
import 'dart:convert';

PackageModel packageModelFromMap(String str) => PackageModel.fromMap(json.decode(str));

String packageModelToMap(PackageModel data) => json.encode(data.toMap());

class PackageModel {
  PackageModel({
   required this.data,
   required this.message,
   required this.success,
   required this.status,
  });

  List<Datum> data;
  String message;
  bool success;
  int status;

  factory PackageModel.fromMap(Map<String, dynamic> json) => PackageModel(
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
   required this.packageId,
   required this.packageName,
   required this.packageAmount,
   required this.packageDescription,
   required this.packageType,
  });

  int packageId;
  String packageName;
  String packageAmount;
  String packageDescription;
  String packageType;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    packageId: json["package_id"],
    packageName: json["package_name"],
    packageAmount: json["package_amount"],
    packageDescription: json["package_description"],
    packageType: json["package_type"],
  );

  Map<String, dynamic> toMap() => {
    "package_id": packageId,
    "package_name": packageName,
    "package_amount": packageAmount,
    "package_description": packageDescription,
    "package_type": packageType,
  };
}
