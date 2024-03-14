import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../common/api_services.dart';
import '../../model/cashBankModel/cash_bank_response_model.dart';
import 'package:http/http.dart' as http;


class CashAndBankController extends GetxController {
  var endpoint = ApiServices();

  var isLoading = false.obs;
  var cashInHandList = <Data>[].obs;
  var bankList = <Data>[].obs;
  var totalList = <Data>[].obs;

  getCashInHand() async {
    Uri uri = Uri.parse("${endpoint.getCashInHand}?payment_type=cash");
    print("${endpoint.getCashInHand}?payment_type=cash");
    isLoading.value = true;
    var response = await http.get(uri);
    try {
      print("GetCashInHand: \n${response.body}");
      if (response.statusCode == 200) {
        var model = CashBankResponseModel.fromJson(json.decode(response.body));
        cashInHandList.value = model.data!;
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      return "";
    }
  }
  getBank() async {
    Uri uri = Uri.parse("${endpoint.getBank}?payment_type=bank");
    print("${endpoint.getBank}?payment_type=bank");
    isLoading.value = true;
    var response = await http.get(uri);
    try {
      print("getBank: \n${response.body}");
      if (response.statusCode == 200) {
        var model = CashBankResponseModel.fromJson(json.decode(response.body));
        bankList.value = model.data!;
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      return "";
    }
  }
  getTotal() async {
    Uri uri = Uri.parse(endpoint.getTotal);
    print(endpoint.getTotal);
    isLoading.value = true;
    var response = await http.get(uri);
    try {
      print("getTotal: \n${response.body}");
      if (response.statusCode == 200) {
        var model = CashBankResponseModel.fromJson(json.decode(response.body));
        totalList.value = model.data!;
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      return "";
    }
  }

  addOrReduce() async {
    Uri uri = Uri.parse("${endpoint.getCashInHand}?payment_type=cash");
    print("${endpoint.getCashInHand}?payment_type=cash");
    isLoading.value = true;
    var response = await http.get(uri);
    try {
      print("GetCashInHand: \n${response.body}");
      if (response.statusCode == 200) {
        var model = CashBankResponseModel.fromJson(json.decode(response.body));
        cashInHandList.value = model.data!;
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      return "";
    }
  }

  Future<dynamic> addMoney(type,partyid,date,ptype,pInNumber,notes) async {
    Uri uri = Uri.parse(endpoint.addMoney);
    Map<String, String> body = {
      'add_or_reduce': 'add',
      'type_of_transaction': type,
      'payment_date': date,
      'payment_type': ptype,
      'payment_in_number': pInNumber,
      'notes': notes
    };

    if(type=="sales"){
      body["party_id"]=partyid;
    }

    final jsonBody = json.encode(body);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var encoding = Encoding.getByName('utf-8');
    isLoading.value = true;

    var res = await http.post(uri,
        headers: headers, body: jsonBody, encoding: encoding);
    try {
      if (kDebugMode) {
        print(res.body);
      }
      isLoading.value = false;

      return json.decode(res.body);
    } catch (e) {
      return "";
    }
  }
}
