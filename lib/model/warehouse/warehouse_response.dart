class WarehouseResponse {
  List<Data>? data;
  String? message;
  bool? success;
  int? status;

  WarehouseResponse({this.data, this.message, this.success, this.status});

  WarehouseResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['success'] = success;
    data['status'] = status;
    return data;
  }
}

class Data {
  int? id;
  String? warehouseNo;
  String? warehouseName;
  String? inchargeName;
  int? contactNo;
  String? address;

  Data(
      {this.id,
        this.warehouseNo,
        this.warehouseName,
        this.inchargeName,
        this.contactNo,
        this.address});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    warehouseNo = json['warehouse_no'];
    warehouseName = json['warehouse_name'];
    inchargeName = json['incharge_name'];
    contactNo = json['contact_no'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['warehouse_no'] = warehouseNo;
    data['warehouse_name'] = warehouseName;
    data['incharge_name'] = inchargeName;
    data['contact_no'] = contactNo;
    data['address'] = address;
    return data;
  }
}
