class PinCodeResponse {
  List<Data>? data;
  String? message;
  bool? success;
  int? status;

  PinCodeResponse({this.data, this.message, this.success, this.status});

  PinCodeResponse.fromJson(Map<String, dynamic> json) {
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
  int? pinCode;
  String? area;
  String? city;
  String? state;

  Data({this.id, this.pinCode, this.area, this.city, this.state});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pinCode = json['pin_code'];
    area = json['area'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pin_code'] = pinCode;
    data['area'] = area;
    data['city'] = city;
    data['state'] = state;
    return data;
  }
}
