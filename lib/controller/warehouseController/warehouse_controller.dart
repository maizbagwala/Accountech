import 'package:accountech/model/warehouse/create_warehouse_response.dart' as CreateWarehouse;
import 'package:accountech/model/warehouse/warehouse_response.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:accountech/common/api_services.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:accountech/model/commonModels/pincode_response.dart' as pc;

import '../../common/my_shared_preferences.dart';
import '../../model/commonModels/delete_response.dart';



class WarehouseController extends GetxController{

  var warehouseList=<Data>[].obs;
  var endpoint=ApiServices();


  var warehouseCode="".obs;
  var warehouseName="".obs;
  var inchargeName="".obs;
  var contactNo="".obs;
  var pincode="".obs;
  var cityState = pc.Data().obs;
  var state="1".obs;
  var city="1".obs;
  var address="".obs;

  var isLoading =false.obs;

  resetVariable(){
   warehouseCode.value="";
    warehouseName.value="";
     inchargeName.value="";
     contactNo.value="";
     pincode.value="";
     cityState.value = pc.Data();
     state.value="1";
     city.value="1";
     address.value="";
  }

  getWarehouse() async {
    Uri uri = Uri.parse("${endpoint.getWarehouse}${MySharedPreferences.businessSelectedID.$}");
    print(endpoint.getWarehouse);
    isLoading.value = true;
    var response = await http.get(uri);
    try {
      print("getWarehouse: \n${response.body}");
      if (response.statusCode == 200) {
        var model = WarehouseResponse.fromJson(json.decode(response.body));
        print(model);
        warehouseList.value = model.data!;
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      return "";
    }
  }

  Future<CreateWarehouse.CreateWarehouseResponse> createWarehouse(
  String warehouseNo,
  String warehouseName,
  String inchargeName,
  String mobileNo,
  String pincode,
  String state,
  String city,
  String address,
      ) async {
    Uri uri = Uri.parse(endpoint.createWarehouse);

    Map<String, String> body = {
      'user_id': "${MySharedPreferences.userID.$}",
      'company_id': "${MySharedPreferences.businessSelectedID.$}",
      'warehouse_no': warehouseNo,
      'warehouse_name': warehouseName,
      'incharge_name': inchargeName,
      'mobile_no': mobileNo,
      'pincode': pincode,
      'state': state,
      'city': city,
      'address': address
    };

    print("Create warehouse");
    print("url: $uri\n");
    print(body);

    final jsonBody = json.encode(body);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var encoding = Encoding.getByName('utf-8');

    isLoading.value=true;
    var res =
    await post(uri, headers: headers, body: jsonBody, encoding: encoding);
    try {
      if (kDebugMode) {
        print(res.body);
      }
      isLoading.value=false;
      return CreateWarehouse.CreateWarehouseResponse.fromJson(json.decode(res.body));
    } catch (e) {
      isLoading.value=false;
      if (kDebugMode) {
        print(e);
      }
      return CreateWarehouse.CreateWarehouseResponse.fromJson(json.decode(""));
    }
  }

  Future<CreateWarehouse.CreateWarehouseResponse> editWarehouse(
      String id,
      String warehouseNo,
      String warehouseName,
      String inchargeName,
      String mobileNo,
      String pincode,
      String state,
      String city,
      String address,
      ) async {
    Uri uri = Uri.parse("${endpoint.editWarehouse}$id");

    Map<String, String> body = {
      'warehouse_no': warehouseNo,
      'warehouse_name': warehouseName,
      'incharge_name': inchargeName,
      'mobile_no': mobileNo,
      'pincode': pincode,
      'state': state,
      'city': city,
      'address': address
    };

    print("Edit warehouse");
    print("url: $uri\n");
    print(body);

    final jsonBody = json.encode(body);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var encoding = Encoding.getByName('utf-8');

    isLoading.value=true;
    var res =
    await post(uri, headers: headers, body: jsonBody, encoding: encoding);
    try {
      if (kDebugMode) {
        print(res.body);
      }
      isLoading.value=false;
      return CreateWarehouse.CreateWarehouseResponse.fromJson(json.decode(res.body));
    } catch (e) {
      isLoading.value=false;
      if (kDebugMode) {
        print(e);
      }
      return CreateWarehouse.CreateWarehouseResponse.fromJson(json.decode(""));
    }
  }

  Future<dynamic> deleteWarehouse(id) async {
    Uri uri = Uri.parse("${endpoint.deleteWarehouse}$id");
    isLoading.value = true;
    var response = await http.get(uri);
    isLoading.value = false;
    try {
      print("DeleteWarehouse: \n" + response.body);
      return DeleteResponse.fromJson(json.decode(response.body));
    } catch (e) {
      return "";
    }
  }
}