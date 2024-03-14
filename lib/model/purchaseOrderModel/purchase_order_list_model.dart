class PurchaseOrderListModel {
  List<Data>? data;
  String? message;
  bool? success;
  int? status;

  PurchaseOrderListModel({this.data, this.message, this.success, this.status});

  PurchaseOrderListModel.fromJson(Map<String, dynamic> json) {
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
  int? partyName;
  int? purchaseOrderNo;
  String? dueIn;
  int? amount;

  Data(
      {this.id, this.partyName, this.purchaseOrderNo, this.dueIn, this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partyName = json['party_name'];
    purchaseOrderNo = json['purchase_order_no'];
    dueIn = json['due_in'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['party_name'] = partyName;
    data['purchase_order_no'] = purchaseOrderNo;
    data['due_in'] = dueIn;
    data['amount'] = amount;
    return data;
  }
}
