class ItemBrandResponse {
  List<Data>? data;
  String? message;
  bool? success;
  int? status;

  ItemBrandResponse({this.data, this.message, this.success, this.status});

  ItemBrandResponse.fromJson(Map<String, dynamic> json) {
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
  String? brandName;

  Data({this.id, this.brandName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brand_name'] = brandName;
    return data;
  }
}
