import 'dart:convert';

import 'package:accountech/common/api_services.dart';
import 'package:accountech/common/my_shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../../model/creditNoteModel/credit_note_list_model.dart';


class CreditNoteController extends GetxController {
  var endpoint = ApiServices();
  var creditNoteList = <Data>[].obs;
  var isLoading = false.obs;


  var date ="00-00-0000".obs;
  var validityDate ="00-00-0000".obs;
  var creditNoteNo ="".obs;


  resetVariables(){
    date ="00-00-0000".obs;
    validityDate ="00-00-0000".obs;
    creditNoteNo ="".obs;
  }


  Future<dynamic> getCreditNoteList() async {
    Uri uri = Uri.parse(endpoint.getCreditNote +
        MySharedPreferences.businessSelectedID.$.toString());
    debugPrint("id is ${endpoint.getCreditNote}${MySharedPreferences.businessSelectedID.$.toString()}");

    var response = await http.get(uri);
    try {
      var model = CreditNoteListModel.fromJson(json.decode(response.body));
      creditNoteList.value = model.data!;
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

  Future<dynamic> deleteCreditNote(String id) async {
    debugPrint("id is ${endpoint.deleteCreditNote}$id");
    Uri uri = Uri.parse(endpoint.deleteCreditNote + id.toString());
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

//
// Future<dynamic> addExpense(
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
//   var uri = Uri.parse(endpoint.addExpenseEndPoint);
//   var request = MultipartRequest("POST", uri);
//
//
//   debugPrint("      $partyID\n$categoryID \n$expenseNo\n$paymentMode\n$eDate\n$itemName\n$qty\n$rate\n$totalAmount\n$eAmount\n$eNotes");
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
