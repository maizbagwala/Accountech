class ExpensesIndividualListModel {
  Data? data;
  String? message;
  bool? success;
  int? status;

  ExpensesIndividualListModel(
      {this.data, this.message, this.success, this.status});

  ExpensesIndividualListModel.fromJson(Map<String, dynamic> json) {
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
  String? eid;
  String? expenseNo;
  int? category;
  String? categoryName;
  int? partyId;
  String? partyName;
  int? partyNo;
  String? paymentMode;
  String? date;
  int? eAmount;
  String? eNotes;
  String? eDocument;
  List<Item>? item;

  Data(
      {this.eid,
        this.expenseNo,
        this.category,
        this.categoryName,
        this.partyId,
        this.partyName,
        this.partyNo,
        this.paymentMode,
        this.date,
        this.eAmount,
        this.eNotes,
        this.eDocument,
        this.item});

  Data.fromJson(Map<String, dynamic> json) {
    eid = json['eid'];
    expenseNo = json['expense_no'];
    category = json['category'];
    categoryName = json['category_name'];
    partyId = json['party_id'];
    partyName = json['party_name'];
    partyNo = json['party_no'];
    paymentMode = json['payment_mode'];
    date = json['date'];
    eAmount = json['e_amount'];
    eNotes = json['e_notes'];
    eDocument = json['e_document'];
    if (json['item'] != null) {
      item = <Item>[];
      json['item'].forEach((v) {
        item!.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eid'] = this.eid;
    data['expense_no'] = this.expenseNo;
    data['category'] = this.category;
    data['category_name'] = this.categoryName;
    data['party_id'] = this.partyId;
    data['party_name'] = this.partyName;
    data['party_no'] = this.partyNo;
    data['payment_mode'] = this.paymentMode;
    data['date'] = this.date;
    data['e_amount'] = this.eAmount;
    data['e_notes'] = this.eNotes;
    data['e_document'] = this.eDocument;
    if (this.item != null) {
      data['item'] = this.item!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  String? name;
  int? qty;
  int? rate;
  int? amount;

  Item({this.name, this.qty, this.rate, this.amount});

  Item.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    qty = json['qty'];
    rate = json['rate'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['qty'] = this.qty;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    return data;
  }
}
