
import 'dart:convert';

PlaceOfSupplyModel placeOfSupplyModelFromMap(String str) => PlaceOfSupplyModel.fromMap(json.decode(str));

String placeOfSupplyModelToMap(PlaceOfSupplyModel data) => json.encode(data.toMap());

class PlaceOfSupplyModel {
  PlaceOfSupplyModel({
   required this.data,
   required this.message,
   required this.success,
   required this.status,
  });

  List<Datum> data;
  String message;
  bool success;
  int status;

  factory PlaceOfSupplyModel.fromMap(Map<String, dynamic> json) => PlaceOfSupplyModel(
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
   required this.placeName,
  });

  int id;
  String placeName;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    placeName: json["place_name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "place_name": placeName,
  };
}
