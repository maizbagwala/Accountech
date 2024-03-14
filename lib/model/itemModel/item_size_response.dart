class ItemSizeResponse {
  List<Data>? data;
  String? message;
  bool? success;
  int? status;

  ItemSizeResponse({this.data, this.message, this.success, this.status});

  ItemSizeResponse.fromJson(Map<String, dynamic> json) {
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
  String? sizeName;

  Data({this.id, this.sizeName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sizeName = json['size_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['size_name'] = sizeName;
    return data;
  }
}
