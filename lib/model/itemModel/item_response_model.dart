class ItemResponseModel {
  List<Data>? data;
  String? message;
  bool? success;
  int? status;

  ItemResponseModel({this.data, this.message, this.success, this.status});

  ItemResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? itemId;
  String? itemCode;
  int? stockQty;
  int? category;
  int? salesPrice;
  int? purchasePrice;

  Data(
      {this.itemId,
        this.itemCode,
        this.stockQty,
        this.category,
        this.salesPrice,
        this.purchasePrice});

  Data.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemCode = json['item_code'];
    stockQty = json['stock_qty'];
    category = json['category'];
    salesPrice = json['sales_price'];
    purchasePrice = json['purchase_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['item_code'] = this.itemCode;
    data['stock_qty'] = this.stockQty;
    data['category'] = this.category;
    data['sales_price'] = this.salesPrice;
    data['purchase_price'] = this.purchasePrice;
    return data;
  }
}
