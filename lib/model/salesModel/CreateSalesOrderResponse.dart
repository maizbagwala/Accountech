class CreateSalesOrderResponse {
  Data? data;
  String? message;
  bool? success;
  int? status;

  CreateSalesOrderResponse(
      {this.data, this.message, this.success, this.status});

  CreateSalesOrderResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['success'] = success;
    data['status'] = status;
    return data;
  }
}

class Data {
  String? userId;
  String? companyId;
  String? salesOrderNo;
  String? salesOrderDate;
  String? paymentTerms;
  String? dueDate;
  String? billFrom;
  String? billTo;
  String? salesManager;
  String? architect;
  String? partyId;
  String? notes;
  String? termsConditions;
  String? bankDetails;
  String? upiId;
  String? discountPercent;
  String? discountAmount;
  String? roundOff;
  String? roundOffAmt;
  String? totalAmount;
  String? fullPaid;
  String? receivedAmtMode;
  String? receivedAmount;
  String? balanceAmount;
  String? signatureImg;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.userId,
        this.companyId,
        this.salesOrderNo,
        this.salesOrderDate,
        this.paymentTerms,
        this.dueDate,
        this.billFrom,
        this.billTo,
        this.salesManager,
        this.architect,
        this.partyId,
        this.notes,
        this.termsConditions,
        this.bankDetails,
        this.upiId,
        this.discountPercent,
        this.discountAmount,
        this.roundOff,
        this.roundOffAmt,
        this.totalAmount,
        this.fullPaid,
        this.receivedAmtMode,
        this.receivedAmount,
        this.balanceAmount,
        this.signatureImg,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    companyId = json['company_id'];
    salesOrderNo = json['sales_order_no'];
    salesOrderDate = json['sales_order_date'];
    paymentTerms = json['payment_terms'];
    dueDate = json['due_date'];
    billFrom = json['bill_from'];
    billTo = json['bill_to'];
    salesManager = json['sales_manager'];
    architect = json['architect'];
    partyId = json['party_id'];
    notes = json['notes'];
    termsConditions = json['terms_conditions'];
    bankDetails = json['bank_details'];
    upiId = json['upi_id'];
    discountPercent = json['discount_percent'];
    discountAmount = json['discount_amount'];
    roundOff = json['round_off'];
    roundOffAmt = json['round_off_amt'];
    totalAmount = json['total_amount'];
    fullPaid = json['full_paid'];
    receivedAmtMode = json['received_amt_mode'];
    receivedAmount = json['received_amount'];
    balanceAmount = json['balance_amount'];
    signatureImg = json['signature_img'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['company_id'] = companyId;
    data['sales_order_no'] = salesOrderNo;
    data['sales_order_date'] = salesOrderDate;
    data['payment_terms'] = paymentTerms;
    data['due_date'] = dueDate;
    data['bill_from'] = billFrom;
    data['bill_to'] = billTo;
    data['sales_manager'] = salesManager;
    data['architect'] = architect;
    data['party_id'] = partyId;
    data['notes'] = notes;
    data['terms_conditions'] = termsConditions;
    data['bank_details'] = bankDetails;
    data['upi_id'] = upiId;
    data['discount_percent'] = discountPercent;
    data['discount_amount'] = discountAmount;
    data['round_off'] = roundOff;
    data['round_off_amt'] = roundOffAmt;
    data['total_amount'] = totalAmount;
    data['full_paid'] = fullPaid;
    data['received_amt_mode'] = receivedAmtMode;
    data['received_amount'] = receivedAmount;
    data['balance_amount'] = balanceAmount;
    data['signature_img'] = signatureImg;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
