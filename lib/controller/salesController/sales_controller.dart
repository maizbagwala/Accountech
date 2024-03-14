import 'dart:convert';

import 'package:accountech/common/api_services.dart';
import 'package:accountech/common/my_shared_preferences.dart';
import 'package:accountech/model/salesModel/CreateSalesOrderResponse.dart';
import 'package:accountech/model/salesModel/charges_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/state_manager.dart';

import 'package:http/http.dart';

class SalesController extends GetxController {

  var date="00/00/0000".obs;
  var validityDate="00/00/0000".obs;
  var orderNo = ''.obs;
  var selectedDate = ''.obs;
  var selectedPartyId = ''.obs;
  var dateCount = ''.obs;
  var range = ''.obs;
  var rangeCount = ''.obs;
  var managerId= 0.obs;
  var architectId= 0.obs;
  var additionalChargesList=<ChargesModel>[].obs ;
  var discountInPercent=0.0.obs;
  var discountInAmount=0.0.obs;
  var roundOfInPercent=0.0.obs;
  var roundOfInAmount=0.0.obs;
  var notes="".obs;
  var terms="".obs;

  updateValidityDate(date){
    validityDate.value=date;
  }
  updateDate(d){
    date.value=d;
  }
  updateOrderNo(String no){
    orderNo.value=no;
  }
  updateManagerId(v){
    managerId.value=v;
  }
  updateArchitectId(v){
    architectId.value=v;
  }

  var endpoint=ApiServices();

  Future<CreateSalesOrderResponse> createSalesOrder(
      String salesOrderNo,
      String salesOrderDate,
      String paymentTerms,
      String dueDate,
      String billTo,
      String salesManager,
      String architect,
      String partyId,
      String notes,
      String termsCondition,
      // String upiId,
      String discountPercent,
      String discountAmount,
      String roundOff,
      String roundOffAmt,
      // String totalAmount,
      // String fullPaid,
      // String receivedAmtMode,
      // String receivedAmount,
      // String balanceAmount,
      // String accountNo,
      // String holderName,
      // String ifscCode,
      // String bankName,
      // String signatureImg
      ) async {
    Uri uri = Uri.parse(endpoint.createSalesOrderEndPoint);

    Map<String, String> body = {
      'user_id': "${MySharedPreferences.userID.$}",
      'company_id': "${MySharedPreferences.businessSelectedID.$}",
      "sales_order_no": salesOrderNo,
      "sales_order_date": salesOrderDate,
      "payment_terms": paymentTerms,
      "due_date": dueDate,
      "bill_from": "${MySharedPreferences.businessSelectedID.$}",
      "bill_to": billTo,
      "sales_manager": salesManager,
      "architect": architect,
      "party_id": partyId,
      "notes": notes,
      "terms_condition": termsCondition,
      "upi_id": "upiId",
      "discount_percent": discountPercent,
      "discount_amount": discountAmount,
      "round_off": roundOff,
      "round_off_amt": roundOffAmt,
      "total_amount": "0",
      "full_paid": "fullPaid",
      "received_amt_mode": "receivedAmtMode",
      "received_amount": "0",
      "balance_amount": "0",
      "account_no": "accountNo",
      "holder_name": "holderName",
      "ifsc_code": "ifscCode",
      "bank_name": "bankName",
      "signature_img": "img",
      "charge_name": additionalChargesList.map((e) => e.chargeName.toString()).join(","),
      "charge_amount": additionalChargesList.map((e) => e.amount.toString()).join(","),
    };

    print("Create Party");
    print("url: $uri\n");
    print(body);

    final jsonBody = json.encode(body);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var encoding = Encoding.getByName('utf-8');

    var res =
        await post(uri, headers: headers, body: jsonBody, encoding: encoding);
    try {
      if (kDebugMode) {
        print(res.body);
      }

      return CreateSalesOrderResponse.fromJson(json.decode(res.body));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return CreateSalesOrderResponse.fromJson(json.decode(""));
    }
  }
}
