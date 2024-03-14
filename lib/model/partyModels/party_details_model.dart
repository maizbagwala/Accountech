class PartyDetailsModel {
  Data? data;
  String? message;
  bool? success;
  int? status;

  PartyDetailsModel({this.data, this.message, this.success, this.status});

  PartyDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? name;
  int? phoneNo;
  String? email;
  String? category;
  int? openingBalance;
  String? gstIn;
  String? billingAddress;
  String? shippingAddress;
  int? creditPeriod;
  int? creditLimit;

  Data(
      {this.name,
        this.phoneNo,
        this.email,
        this.category,
        this.openingBalance,
        this.gstIn,
        this.billingAddress,
        this.shippingAddress,
        this.creditPeriod,
        this.creditLimit});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNo = json['phone_no'];
    email = json['email'];
    category = json['category'];
    openingBalance = json['opening_balance'];
    gstIn = json['gst_in'];
    billingAddress = json['billing_address'];
    shippingAddress = json['shipping_address'];
    creditPeriod = json['credit_period'];
    creditLimit = json['credit_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone_no'] = this.phoneNo;
    data['email'] = this.email;
    data['category'] = this.category;
    data['opening_balance'] = this.openingBalance;
    data['gst_in'] = this.gstIn;
    data['billing_address'] = this.billingAddress;
    data['shipping_address'] = this.shippingAddress;
    data['credit_period'] = this.creditPeriod;
    data['credit_limit'] = this.creditLimit;
    return data;
  }
}
