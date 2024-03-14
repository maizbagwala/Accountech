class CashBankResponseModel {
  List<Data>? data;
  String? message;
  bool? success;
  int? status;

  CashBankResponseModel(
      {this.data, this.message, this.success, this.status});

  CashBankResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  String? addOrReduce;
  String? typeOfTransaction;
  int? partyId;
  String? paymentDate;
  String? paymentType;
  int? paymentInNumber;

  Data(
      {this.id,
        this.addOrReduce,
        this.typeOfTransaction,
        this.partyId,
        this.paymentDate,
        this.paymentType,
        this.paymentInNumber});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addOrReduce = json['add_or_reduce'];
    typeOfTransaction = json['type_of_transaction'];
    partyId = json['party_id'];
    paymentDate = json['payment_date'];
    paymentType = json['payment_type'];
    paymentInNumber = json['payment_in_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['add_or_reduce'] = this.addOrReduce;
    data['type_of_transaction'] = this.typeOfTransaction;
    data['party_id'] = this.partyId;
    data['payment_date'] = this.paymentDate;
    data['payment_type'] = this.paymentType;
    data['payment_in_number'] = this.paymentInNumber;
    return data;
  }
}
