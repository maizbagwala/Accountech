import 'dart:convert';

import 'package:accountech/model/itemModel/item_brand_response.dart' as brand;
import 'package:accountech/model/itemModel/item_series_response.dart' as series;
import 'package:accountech/model/itemModel/item_size_response.dart' as size;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../common/api_services.dart';
import '../../common/my_shared_preferences.dart';
import '../../model/itemModel/delete_item_response.dart';
import '../../model/itemModel/item_category_response.dart' as category;
import '../../model/itemModel/item_response_model.dart' as item;

class ItemController extends GetxController {
  var itemList = <item.Data>[].obs;
  var isLoading = false.obs;

  var endpoint = ApiServices();

  //create item
  var imageList = [].obs;
  var categoryList = <category.Data>[].obs;
  var subCategoryList = <category.Data>[].obs;
  var seriesList = <series.Data>[].obs;
  var subSeriesList = <series.Data>[].obs;
  var brandList = <brand.Data>[].obs;
  var sizeList = <size.Data>[].obs;
  var categoryParentId = "".obs;
  var subCategoryId = "".obs;
  var seriesParentId = "".obs;
  var subSeriesId = "".obs;
  var brandId = "".obs;
  var sizeId = "".obs;
  var hsn = "".obs;
  var gst = "".obs;
  var stockAsOnDate = "".obs;
  var unitList = <String>[].obs;

  Future<dynamic> getItems() async {
    Uri uri = Uri.parse(endpoint.getItemEndPoint);
    print(endpoint.getItemEndPoint);
    isLoading.value = true;
    var response = await http.get(uri);
    try {
      print("GetItem: \n${response.body}");
      if (response.statusCode == 200) {
        var model = item.ItemResponseModel.fromJson(json.decode(response.body));
        itemList.value = model.data!;
        isLoading.value = false;
        return model.data!;
      }
      return "";
    } catch (e) {
      isLoading.value = false;
      return "";
    }
  }

  Future<dynamic> deleteItem(id) async {
    Uri uri = Uri.parse("${endpoint.deleteItemEndPoint}/$id");
    isLoading.value = true;
    var response = await http.get(uri);
    isLoading.value = false;
    try {
      print("url: $uri");
      print("DeleteItem: \n" + response.body);
      return DeleteItemResponse.fromJson(json.decode(response.body));
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> addCategory(category) async {
    Uri uri = Uri.parse(endpoint.addCategory);
    Map<String, String> body = {
      'user_id': "${MySharedPreferences.userID.$}",
      'company_id': "${MySharedPreferences.businessSelectedID.$}",
      'category_name': category,
      'parent_id': "0"
    };

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

  Future<dynamic> getCategory() async {
    Uri uri = Uri.parse(
        "${endpoint.getCategory}?company_id=${MySharedPreferences.businessSelectedID.$}");
    print(endpoint.getCategory);
    isLoading.value = true;
    var response = await http.get(uri);
    try {
      print("getCategory: \n${response.body}");
      if (response.statusCode == 200) {
        var model =
            category.ItemCategoryResponse.fromJson(json.decode(response.body));
        categoryList.value = model.data!;
        isLoading.value = false;
      }
      return "";
    } catch (e) {
      isLoading.value = false;
      return "";
    }
  }

  Future<dynamic> addSubCategory(parentId, subCategory) async {
    Uri uri = Uri.parse(endpoint.addCategory);
    Map<String, String> body = {
      'user_id': "${MySharedPreferences.userID.$}",
      'company_id': "${MySharedPreferences.businessSelectedID.$}",
      'category_name': subCategory,
      'parent_id': parentId
    };

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

  Future<dynamic> getSubCategory(parentId) async {
    Uri uri = Uri.parse(
        "${endpoint.getCategory}?company_id=${MySharedPreferences.businessSelectedID.$}&parent_id=$parentId");
    print(endpoint.getCategory);
    isLoading.value = true;
    var response = await http.get(uri);
    try {
      print("getSubCategory: \n${response.body}");
      if (response.statusCode == 200) {
        var model =
            category.ItemCategoryResponse.fromJson(json.decode(response.body));
        subCategoryList.value = model.data!;
        isLoading.value = false;
      }
      return "";
    } catch (e) {
      isLoading.value = false;
      return "";
    }
  }

  Future<dynamic> addSeries(series) async {
    Uri uri = Uri.parse(endpoint.addSeries);
    Map<String, String> body = {
      'user_id': "${MySharedPreferences.userID.$}",
      'company_id': "${MySharedPreferences.businessSelectedID.$}",
      'series_name': series,
      'parent_id': "0"
    };

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

  Future<dynamic> getSeries() async {
    Uri uri = Uri.parse(
        "${endpoint.getSeries}?company_id=${MySharedPreferences.businessSelectedID.$}");
    print(endpoint.getSeries);
    isLoading.value = true;
    var response = await http.get(uri);
    try {
      print("GetItem: \n${response.body}");
      if (response.statusCode == 200) {
        var model =
            series.ItemSeriesResponse.fromJson(json.decode(response.body));
        seriesList.value = model.data!;
        isLoading.value = false;
      }
      return "";
    } catch (e) {
      isLoading.value = false;
      return "";
    }
  }

  Future<dynamic> addSubSeries(parentId, subSeries) async {
    Uri uri = Uri.parse(endpoint.addSeries);
    Map<String, String> body = {
      'user_id': "${MySharedPreferences.userID.$}",
      'company_id': "${MySharedPreferences.businessSelectedID.$}",
      'series_name': subSeries,
      'parent_id': parentId
    };

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

  Future<dynamic> getSubSeries(parentId) async {
    Uri uri = Uri.parse(
        "${endpoint.getSeries}?company_id=${MySharedPreferences.businessSelectedID.$}&parent_id=$parentId");
    print(endpoint.getSeries);
    isLoading.value = true;
    var response = await http.get(uri);
    try {
      print("getSubSeries: \n${response.body}");
      if (response.statusCode == 200) {
        var model =
            series.ItemSeriesResponse.fromJson(json.decode(response.body));
        subSeriesList.value = model.data!;
        isLoading.value = false;
      }
      return "";
    } catch (e) {
      isLoading.value = false;
      return "";
    }
  }

  Future<dynamic> addBrand(brand) async {
    Uri uri = Uri.parse(endpoint.addBrand);
    Map<String, String> body = {
      'user_id': "${MySharedPreferences.userID.$}",
      'company_id': "${MySharedPreferences.businessSelectedID.$}",
      'brand_name': brand,
    };

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

  Future<dynamic> getBrand() async {
    Uri uri = Uri.parse(
        "${endpoint.getBrand}${MySharedPreferences.businessSelectedID.$}");
    print(endpoint.getBrand);
    isLoading.value = true;
    var response = await http.get(uri);
    try {
      print("getBrand: \n${response.body}");
      if (response.statusCode == 200) {
        var model =
            brand.ItemBrandResponse.fromJson(json.decode(response.body));
        brandList.value = model.data!;
        isLoading.value = false;
      }
      return "";
    } catch (e) {
      isLoading.value = false;
      return "";
    }
  }

  Future<dynamic> addSize(size) async {
    Uri uri = Uri.parse(endpoint.addSize);
    Map<String, String> body = {
      'user_id': "${MySharedPreferences.userID.$}",
      'company_id': "${MySharedPreferences.businessSelectedID.$}",
      'size_name': size
    };

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

  Future<dynamic> getSize() async {
    Uri uri = Uri.parse(
        "${endpoint.getSize}${MySharedPreferences.businessSelectedID.$}");
    print(endpoint.getSize);
    isLoading.value = true;
    var response = await http.get(uri);
    try {
      print("getSize: \n${response.body}");
      if (response.statusCode == 200) {
        var model = size.ItemSizeResponse.fromJson(json.decode(response.body));
        sizeList.value = model.data!;
        isLoading.value = false;
      }
      return "";
    } catch (e) {
      isLoading.value = false;
      return "";
    }
  }

  Future<bool> addItem(
      item_code,
      item_name,
      item_alt_name,
      category_id,
      subcategory_id,
      series_id,
      subseries_id,
      brand_id,
      size_id,
      remark,
      hsn,
      gst,
      sales_price,
      purchase_price,
      mrp,
      sales_tax_include,
      purchase_tax_include,
      is_batch,
      batch_warehouse,
      batch_no,
      qty,
      opening_stock,
      stock_date,
      warehouse,
      reorder_warning,
      reorder_stock,
      main_unit_id,
      unit_id,
      conversation_rate,
      List<String> images) async {
    var request = http.MultipartRequest('POST', Uri.parse(endpoint.createItem));
    request.fields.addAll({
      'user_id': "${MySharedPreferences.userID.$}",
      'company_id': "${MySharedPreferences.businessSelectedID.$}",
      'item_code': item_code,
      'item_name': item_name,
      'item_alt_name': item_alt_name,
      'category_id': category_id,
      'subcategory_id': subcategory_id,
      'series_id': series_id,
      'subseries_id': subseries_id,
      'brand_id': brand_id,
      'size_id': size_id,
      'remark': remark,
      'hsn': hsn,
      'gst': gst,
      'sales_price': sales_price,
      'purchase_price': purchase_price,
      'mrp': mrp,
      'sales_tax_include': sales_tax_include,
      'purchase_tax_include': purchase_tax_include,
      'is_batch': is_batch,
      'batch_warehouse': batch_warehouse,
      'batch_no': batch_no,
      'qty': qty,
      'opening_stock': opening_stock,
      'stock_date': stock_date,
      'warehouse': warehouse,
      'reorder_warning': reorder_warning,
      'reorder_stock': reorder_stock,
      'main_unit_id': main_unit_id,
      'unit_id': unit_id,
      'conversation_rate': conversation_rate
    });
    print(endpoint.getSize);
    print(request.fields);

    for (int i = 0; i < images.length; i++) {
      request.files
          .add(await http.MultipartFile.fromPath('image_${i + 1}', images[i]));
    }
    // request.files.add(await http.MultipartFile.fromPath('image_1', 's3uiVpI8t/035cb5f33b302b0a0a0eb44ce311f293_1519396321 (1).jpg'));
    // request.files.add(await http.MultipartFile.fromPath('image_2', '/path/to/file'));
    // request.files.add(await http.MultipartFile.fromPath('image_3', '/path/to/file'));
    // request.files.add(await http.MultipartFile.fromPath('image_4', '/path/to/file'));
    // request.files.add(await http.MultipartFile.fromPath('image_5', '/path/to/file'));

    print(request.files.map((e) => e.filename));
    http.StreamedResponse response = await request.send();
    print(response);
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}
