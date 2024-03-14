import 'dart:convert';

import 'package:accountech/common/api_services.dart';
import 'package:accountech/common/my_shared_preferences.dart';
import 'package:accountech/model/authModels/user_model.dart';
import 'package:accountech/model/commonModels/pincode_response.dart';
import 'package:accountech/model/expenseModel/expense_category_model.dart';
import 'package:accountech/model/expenseModel/expense_list_data_model.dart';
import 'package:accountech/model/partyModels/CreatePartyResponse.dart';
import 'package:accountech/model/partyModels/delete_party_response.dart';
import 'package:accountech/model/partyModels/party_class_list_model.dart';
import 'package:accountech/model/partyModels/party_details_model.dart';
import 'package:accountech/model/partyModels/party_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:async/async.dart';
import 'package:accountech/model/commonModels/pincode_response.dart' as pincode;

import 'package:http/http.dart';

import '../../model/partyModels/party_edit_details_model.dart';

class PartyController extends GetxController {
  var apiEndpoint = ApiServices();
  var isLoading = false.obs;

  var partyList = [].obs;
  var pinCode1 = pincode.Data().obs;
  var pinCode2 = pincode.Data().obs;

  resetVariable(){

  }
  Future<dynamic> searchParty(String search) async {
    Uri uri = Uri.parse(
        "${apiEndpoint.getSearchPartyEndPoint}${MySharedPreferences.businessSelectedID.$}?search=$search");
    var response = await http.get(uri);
    try {
      print("SearchParty: \n" + response.body);
      var model = partyListModelFromMap(response.body);
      partyList.value = model.data;
      return model;
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> getParty() async {
    Uri uri = Uri.parse(
        "${apiEndpoint.getSearchPartyEndPoint}${MySharedPreferences.businessSelectedID.$}");
    var response = await http.get(uri);
    try {
      print("GetParty: \n" + response.body);

      var model= partyListModelFromMap(response.body);
      partyList.value=model.data;
      return model;

    } catch (e) {
      return "";
    }
  }

  Future<dynamic> deleteParty(id) async {
    Uri uri = Uri.parse("${apiEndpoint.deletePartyEndPoint}?id=$id");
    isLoading.value = true;
    var response = await http.get(uri);
    isLoading.value = false;
    try {
      print("DeleteParty: \n" + response.body);
      return DeletePartyResponse.fromJson(json.decode(response.body));
    } catch (e) {
      return "";
    }
  }



  Future<dynamic> getPartyDetails(String id) async {
    Uri uri = Uri.parse("${apiEndpoint.getPartyDetailsEndPoint}$id");

    print("URL: $uri");
    var response = await http.get(uri);
    try {
      print("GetPartyDetails: \n" + response.body);
      return PartyDetailsModel.fromJson(json.decode(response.body));
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> getPartyEditDetails(String id) async {
    Uri uri = Uri.parse("${apiEndpoint.getPartyEditDetailsEndPoint}$id");

    print("URL: $uri");
    var response = await http.get(uri);
    try {
      print("GetPartyDetails: \n" + response.body);
      return PartyEditDetailsModel.fromJson(json.decode(response.body));
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> getPartyClass() async {
    Uri uri = Uri.parse(apiEndpoint.getPartyClassEndPoint);
    var response = await http.get(uri);
    try {
      return partyClassListModelFromMap(response.body);
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> getCityStateFromPincode(String pincode) async {
    Uri uri = Uri.parse("${apiEndpoint.getCityStateEndPoint}?pin_code=$pincode");

    print("URL: $uri");
    var response = await http.get(uri);
    try {
      print("getCityStateEndPoint: \n" + response.body);
      var model=PinCodeResponse.fromJson(json.decode(response.body));
      return model.data!;
    } catch (e) {
      return "";
    }
  }

  Future<CreatePartyResponse> createParty(
    String partyType,
    String partyClass,
    String partyName,
    String email,
    String phoneNo,
    String sameToPhone,
    String whatsappNo,
    String gstNo,
    String panNo,
    String udhyamAadhar,
    String billingPincode,
    String billingAddress,
    String sameToBilling,
    String shippingPincode,
    String shippingAddress,
    String creditPeriod,
    String creditLimit,
    String openingBalance,
    String crStatus,
  ) async {
    Uri uri = Uri.parse(apiEndpoint.createPartyEndPoint);

    Map<String, String> body = {
      'user_id': "${MySharedPreferences.userID.$}",
      'company_id': "${MySharedPreferences.businessSelectedID.$}",
      'party_type': partyType,
      'p_class': partyClass,
      'party_name': partyName,
      'email': email,
      'phone_no': phoneNo,
      'same_to_phone': sameToPhone,
      'whatsapp_no': whatsappNo,
      'gst_no': gstNo,
      'pan_no': panNo,
      'udhyam_aadhar': udhyamAadhar,
      'billing_pincode': billingPincode,
      'billing_address': billingAddress,
      'same_to_billing': sameToBilling,
      'shipping_pincode': shippingPincode,
      'shipping_address': shippingAddress,
      'credit_period': creditPeriod,
      'credit_limit': creditLimit,
      'opening_balance': openingBalance,
      'cr_status': crStatus,
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

      return CreatePartyResponse.fromJson(json.decode(res.body));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return CreatePartyResponse.fromJson(json.decode(""));
    }
  }


  Future<CreatePartyResponse> editParty(
      String partyId,
      String partyType,
      String partyClass,
      String partyName,
      String email,
      String phoneNo,
      String sameToPhone,
      String whatsappNo,
      String gstNo,
      String panNo,
      String udhyamAadhar,
      String billingPincode,
      String billingAddress,
      String sameToBilling,
      String shippingPincode,
      String shippingAddress,
      String creditPeriod,
      String creditLimit,
      String openingBalance,
      String crStatus,
      ) async {
    Uri uri = Uri.parse(apiEndpoint.editPartyEndPoint);

    Map<String, String> body = {
      'party_id': partyId,
      'party_type': partyType,
      'p_class': partyClass,
      'party_name': partyName,
      'email': email,
      'phone_no': phoneNo,
      'same_to_phone': sameToPhone,
      'whatsapp_no': whatsappNo,
      'gst_no': gstNo,
      'pan_no': panNo,
      'udhyam_aadhar': udhyamAadhar,
      'billing_pincode': billingPincode,
      'billing_address': billingAddress,
      'same_to_billing': sameToBilling,
      'shipping_pincode': shippingPincode,
      'shipping_address': shippingAddress,
      'credit_period': creditPeriod,
      'credit_limit': creditLimit,
      'opening_balance': openingBalance,
      'cr_status': crStatus,
    };

    print("Edit Party");
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

      return CreatePartyResponse.fromJson(json.decode(res.body));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return CreatePartyResponse.fromJson(json.decode(""));
    }
  }
}
