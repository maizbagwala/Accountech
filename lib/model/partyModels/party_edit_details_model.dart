class PartyEditDetailsModel {
  Data? data;
  String? message;
  bool? success;
  int? status;

  PartyEditDetailsModel({this.data, this.message, this.success, this.status});

  PartyEditDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  int? companyId;
  String? partyType;
  String? partyClass;
  String? partyName;
  String? email;
  int? phoneNo;
  String? sameToPhone;
  int? whatsappNo;
  String? gstNo;
  String? panNo;
  String? udhyamAadhar;
  int? billingPincode;
  String? billingState;
  String? billingCity;
  String? billingAddress;
  String? sameToBilling;
  int? shippingPincode;
  String? shippingState;
  String? shippingCity;
  String? shippingAddress;
  int? creditPeriod;
  int? creditLimit;
  int? openingBalance;
  String? crStatus;

  Data(
      {this.userId,
        this.companyId,
        this.partyType,
        this.partyClass,
        this.partyName,
        this.email,
        this.phoneNo,
        this.sameToPhone,
        this.whatsappNo,
        this.gstNo,
        this.panNo,
        this.udhyamAadhar,
        this.billingPincode,
        this.billingState,
        this.billingCity,
        this.billingAddress,
        this.sameToBilling,
        this.shippingPincode,
        this.shippingState,
        this.shippingCity,
        this.shippingAddress,
        this.creditPeriod,
        this.creditLimit,
        this.openingBalance,
        this.crStatus});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    companyId = json['company_id'];
    partyType = json['party_type'];
    partyClass = json['party_class'];
    partyName = json['party_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    sameToPhone = json['same_to_phone'];
    whatsappNo = json['whatsapp_no'];
    gstNo = json['gst_no'];
    panNo = json['pan_no'];
    udhyamAadhar = json['udhyam_aadhar'];
    billingPincode = json['billing_pincode'];
    billingState = json['billing_state'];
    billingCity = json['billing_city'];
    billingAddress = json['billing_address'];
    sameToBilling = json['same_to_billing'];
    shippingPincode = json['shipping_pincode'];
    shippingState = json['shipping_state'];
    shippingCity = json['shipping_city'];
    shippingAddress = json['shipping_address'];
    creditPeriod = json['credit_period'];
    creditLimit = json['credit_limit'];
    openingBalance = json['opening_balance'];
    crStatus = json['cr_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['company_id'] = this.companyId;
    data['party_type'] = this.partyType;
    data['party_class'] = this.partyClass;
    data['party_name'] = this.partyName;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['same_to_phone'] = this.sameToPhone;
    data['whatsapp_no'] = this.whatsappNo;
    data['gst_no'] = this.gstNo;
    data['pan_no'] = this.panNo;
    data['udhyam_aadhar'] = this.udhyamAadhar;
    data['billing_pincode'] = this.billingPincode;
    data['billing_state'] = this.billingState;
    data['billing_city'] = this.billingCity;
    data['billing_address'] = this.billingAddress;
    data['same_to_billing'] = this.sameToBilling;
    data['shipping_pincode'] = this.shippingPincode;
    data['shipping_state'] = this.shippingState;
    data['shipping_city'] = this.shippingCity;
    data['shipping_address'] = this.shippingAddress;
    data['credit_period'] = this.creditPeriod;
    data['credit_limit'] = this.creditLimit;
    data['opening_balance'] = this.openingBalance;
    data['cr_status'] = this.crStatus;
    return data;
  }
}
