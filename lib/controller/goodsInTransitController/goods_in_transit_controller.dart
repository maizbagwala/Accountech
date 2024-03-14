import 'dart:convert';

import 'package:accountech/common/api_services.dart';
import 'package:accountech/common/my_shared_preferences.dart';
import 'package:accountech/model/goodsInTransit/goods_in_transit_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:http/http.dart';

class GoodsInTransitController extends GetxController {
  var endpoint = ApiServices();
  var goodsInTransitList = <Data>[].obs;
  var isLoading = false.obs;


  var date ="00-00-0000".obs;
  var validityDate ="00-00-0000".obs;
  var goodsInTransitNo ="".obs;
  var salesId ="".obs;
  var partyId ="".obs;
  var architectId ="".obs;
  var note ="".obs;
  var discountPrice ="".obs;
  var discountPercent ="".obs;
  var roundOffPercent ="".obs;
  var roundOffAmount ="".obs;
  var totalAmount = "0".obs;
  var chargeName = "".obs;
  var chargeAmount = "".obs;



  resetVariables(){
    date ="00-00-0000".obs;
    validityDate ="00-00-0000".obs;
    goodsInTransitNo ="".obs;
    salesId ="".obs;
    partyId ="".obs;
    architectId ="".obs;
    note ="".obs;
    discountPrice ="".obs;
    discountPercent ="".obs;
    roundOffPercent ="".obs;
    roundOffAmount ="".obs;
    totalAmount = "0".obs;
    chargeAmount = "".obs;
    chargeName = "".obs;
  }


  Future<dynamic> getGoodsInTransitList() async {
    Uri uri = Uri.parse(endpoint.getGoodsInTransit +
        MySharedPreferences.businessSelectedID.$.toString());
    var response = await http.get(uri);
    try {
      var model = GoodsInTransitModel.fromJson(json.decode(response.body));
      goodsInTransitList.value = model.data!;
      return model;
    } catch (e) {
      return "";
    }
  }

  // Future<dynamic> getExpenseListData(String categoryID) async{
  //   Uri uri = Uri.parse(endpoint.getExpenseListDataEndPoint+categoryID.toString());
  //   var response = await http.get(uri);
  //   try{
  //     return expensesListModelFromMap(response.body);
  //   }catch(e)
  //   {
  //     return "";
  //   }
  //
  // }

  Future<dynamic> deleteGoodsInTransit(String id) async {
    debugPrint("id is ${endpoint.getGoodsInTransit}$id");
    Uri uri = Uri.parse(endpoint.getGoodsInTransit + id.toString());
    var response = await http.Request("DELETE", uri).send();
    try {
      return response.stream.bytesToString();
    } catch (e) {
      throw "";
    }
  }
// Future<dynamic> getExpenseIndividualItemData(String expenseID) async{
//   Uri uri = Uri.parse(endpoint.expenseDetailEndPoint+expenseID.toString());
//   print("get expense details  $uri");
//   var response = await http.get(uri);
//   print(response.body);
//   try{
//     return ExpensesIndividualListModel.fromJson(json.decode(response.body));
//   }catch(e)
//   {
//     return "";
//   }
//
// }


Future<dynamic> addGoodsInTransit(
  String goods_in_transit_no,
  String goods_in_transit_date,
  String payment_terms,
  String due_date,
  String bill_from,
  String bill_to,
  String sales_manager,
  String architect,
  String party_id,
  String notes,
  String terms_condition,
  String upi_id,
  String discount_percent,
  String discount_amount,
  String round_off,
  String round_off_amt,
  String total_amount,
  String full_paid,
  String received_amt_mode,
  String received_amount,
  String balance_amount,
  String charge_name,
  String charge_amount,
  String account_no,
  String holder_name,
  String ifsc_code,
  String bank_name,
  String signature_img
    ) async {
  var uri = Uri.parse(endpoint.addExpenseEndPoint);
  var request = MultipartRequest("POST", uri);


  debugPrint("request is ${request.fields.toString()}");

  // if(eDocument!=null)
  // {
  //   String myProfilePic = eDocument.path.split("/").last;
  //   var profilePicStream = ByteStream(DelegatingStream(eDocument.openRead()));
  //   var profilePicLength = await eDocument.length();
  //   var profilePicMultipartFileSign = http.MultipartFile(
  //       'e_document', profilePicStream, profilePicLength,
  //       filename: myProfilePic);
  //   request.files.add(profilePicMultipartFileSign);
  // }

  debugPrint("request is ${request.fields.toString()}");

  Map<String, String> headers = {
    "Accept": "application/json",
  };
  request.headers.addAll(headers);

  request.fields['user_id'] = MySharedPreferences.userID.$.toString();
  request.fields['company_id'] = MySharedPreferences.businessSelectedID.$.toString();
  request.fields['goods_in_transit_no'] = goods_in_transit_no.toString();
  request.fields['goods_in_transit_date'] = goods_in_transit_date.toString();
  request.fields['payment_terms'] = payment_terms.toString();
  request.fields['due_date'] = due_date.toString();
  request.fields['bill_from'] = bill_from.toString();
  request.fields['bill_to'] = bill_to.toString();
  request.fields['sales_manager'] = sales_manager.toString();
  request.fields['architect'] = architect.toString();
  request.fields['party_id'] = party_id.toString();
  request.fields['notes'] = notes.toString();
  request.fields['terms_condition'] = terms_condition.toString();
  request.fields['upi_id'] = upi_id.toString();
  request.fields['discount_percent'] = discount_percent.toString();
  request.fields['discount_amount'] = discount_amount.toString();
  request.fields['round_off'] = round_off.toString();
  request.fields['round_off_amt'] = round_off_amt.toString();
  request.fields['total_amount'] = total_amount.toString();
  request.fields['full_paid'] = full_paid.toString();
  request.fields['received_amt_mode'] = received_amt_mode.toString();
  request.fields['received_amount'] = received_amount.toString();
  request.fields['balance_amount'] = balance_amount.toString();
  request.fields['charge_name'] = charge_name.toString();
  request.fields['charge_amount'] = charge_amount.toString();
  request.fields['account_no'] = account_no.toString();
  request.fields['holder_name'] = holder_name.toString();
  request.fields['ifsc_code'] = ifsc_code.toString();
  request.fields['bank_name'] = bank_name.toString();
  // request.fields['signature_img'] = signature_img.toString();


  debugPrint("request is ${request.fields.toString()}");

  var response = await request.send();
  try {
    var res = await http.Response.fromStream(response);

    debugPrint("response is ${res.body}");
    return res.body;

  }catch(e)
  {
    debugPrint("${e.toString()}");
    return "";
  }

}
// Future<dynamic> editExpense(
//     String expenseID,
//     String partyID,
//     String categoryID,
//     String expenseNo,
//     String paymentMode,
//     String eDate,
//     String itemName,
//     String qty,
//     String rate,
//     String totalAmount,
//     String eAmount,
//     String eNotes,
//     File? eDocument,
//     ) async {
//   var uri = Uri.parse(endpoint.editExpenseEndPoint+expenseID);
//   var request = MultipartRequest("POST", uri);
//
//
//   debugPrint("request is ${request.fields.toString()}");
//
//   if(eDocument!=null)
//   {
//     String myProfilePic = eDocument.path.split("/").last;
//     var profilePicStream = ByteStream(DelegatingStream(eDocument.openRead()));
//     var profilePicLength = await eDocument.length();
//     var profilePicMultipartFileSign = http.MultipartFile(
//         'e_document', profilePicStream, profilePicLength,
//         filename: myProfilePic);
//     request.files.add(profilePicMultipartFileSign);
//   }
//
//   debugPrint("request is ${request.fields.toString()}");
//
//   Map<String, String> headers = {
//     "Accept": "application/json",
//   };
//   request.headers.addAll(headers);
//
//   request.fields['user_id'] = MySharedPreferences.userID.$.toString();
//   request.fields['company_id'] = MySharedPreferences.businessSelectedID.$.toString();
//   request.fields['party_id'] = partyID.toString();
//   request.fields['category_id'] = categoryID.toString();
//   request.fields['expense_no'] = expenseNo.toString();
//   request.fields['payment_mode'] = paymentMode.toString();
//   request.fields['e_date'] = eDate.toString();
//   request.fields['item_name'] = itemName.toString();
//   request.fields['qty'] = qty.toString();
//   request.fields['rate'] = rate.toString();
//   request.fields['total_amount'] = totalAmount.toString();
//   request.fields['e_amount'] = eAmount.toString();
//   request.fields['e_notes'] = eNotes.toString();
//
//
//   debugPrint("request is ${request.fields.toString()}");
//
//   var response = await request.send();
//   try {
//     var res = await http.Response.fromStream(response);
//
//     debugPrint("response is ${res.body}");
//     return addExpenseResModelFromMap(res.body);
//
//   }catch(e)
//   {
//     debugPrint("${e.toString()}");
//     return "";
//   }
//
// }

//
// Future<dynamic> addExpanseCategory(category) async {
//   Uri uri = Uri.parse(endpoint.addExpenseCategoryEndPoint);
//   Map<String, String> body = {
//     'user_id': "${MySharedPreferences.userID.$}",
//     'company_id': "${MySharedPreferences.businessSelectedID.$}",
//     'expense_name': category,
//   };
//
//   final jsonBody = json.encode(body);
//   Map<String, String> headers = {'Content-Type': 'application/json'};
//   var encoding = Encoding.getByName('utf-8');
//   isLoading.value = true;
//
//   var res = await http.post(uri,
//       headers: headers, body: jsonBody, encoding: encoding);
//   try {
//     if (kDebugMode) {
//       print(res.body);
//     }
//     isLoading.value = false;
//
//     return json.decode(res.body);
//   } catch (e) {
//     return "";
//   }
// }
}
