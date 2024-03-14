import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:accountech/model/authModels/check_user_model.dart';
import 'package:accountech/model/authModels/login_model.dart';
import 'package:accountech/model/authModels/register_model.dart';
import 'package:accountech/model/authModels/user_model.dart';
import 'package:async/async.dart';

import 'package:accountech/common/api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class AuthController extends ApiServices {
  Future<RegisterModel> register(
    String name,
    String email,
    String mobileNo,
    String panNo,
    String businessName,
    String businessPhone,
    String businessType,
    String industryType,
    String billingAddress,
    String gstNumber,
    String placeOfSupply,
    File? profilePic,
    File? businessLogo,
    String packageId,
  ) async {
    var uri = Uri.parse(getRegisterEndPoint);
    var request = MultipartRequest("POST", uri);
    if (profilePic != null) {
      String myProfilePic = profilePic.path.split("/").last;
      var profilePicStream =
          ByteStream(DelegatingStream(profilePic.openRead()));
      var profilePicLength = await profilePic.length();
      var profilePicMultipartFileSign = MultipartFile(
          'profile_pic', profilePicStream, profilePicLength,
          filename: myProfilePic);
      request.files.add(profilePicMultipartFileSign);
    }

    if (businessLogo != null) {
      String myBusinessLogo = businessLogo.path.split("/").last;
      var businessLogoStream =
          ByteStream(DelegatingStream(businessLogo.openRead()));
      var businessLogoLength = await businessLogo.length();
      var businessLogoMultipartFileSign = MultipartFile(
          'business_logo', businessLogoStream, businessLogoLength,
          filename: myBusinessLogo);
      request.files.add(businessLogoMultipartFileSign);
    }

    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['mobile_no'] = mobileNo;
    request.fields['pan_no'] = panNo;
    request.fields['business_name'] = businessName;
    request.fields['business_phone'] = businessPhone;
    request.fields['business_type'] = businessType;
    request.fields['industry_type'] = industryType;
    request.fields['billing_address'] = billingAddress;
    request.fields['gst_number'] = gstNumber;
    request.fields['place_of_supply'] = placeOfSupply;
    request.fields['package_id'] = packageId;

    var response = await request.send();

    var res = await Response.fromStream(response);
    return registerModelFromMap(res.body);
  }

  Future<dynamic> login(String number) async {
    Uri uri = Uri.parse(loginEndPoint);
    Map<String, String> body = {'mobile_no': number};
    final jsonBody = json.encode(body);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var encoding = Encoding.getByName('utf-8');

    var res =
        await post(uri, headers: headers, body: jsonBody, encoding: encoding);
    try {
      return loginModelFromMap(res.body);
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> verifyUser(String number) async {
    Uri uri = Uri.parse(verifyUserEndPoint);
    Map<String, String> body = {'mobile_no': number};
    final jsonBody = json.encode(body);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var encoding = Encoding.getByName('utf-8');

    var res =
        await post(uri, headers: headers, body: jsonBody, encoding: encoding);
    try {
      if (kDebugMode) {
        print(res.body);
      }

      return userModelFromMap(res.body);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return "";
    }
  }

  Future<dynamic> checkUser(String number, String email) async {
    Uri uri = Uri.parse(checkUserEndPoint);
    Map<String, String> body = {'mobile_no': number, 'email': email};
    final jsonBody = json.encode(body);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var encoding = Encoding.getByName('utf-8');

    var res =
        await post(uri, headers: headers, body: jsonBody, encoding: encoding);
    try {
      return checkUserModelFromMap(res.body);
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> verifyOTP(String number, String otp, String type) async {
    Uri uri = Uri.parse(verifyOTPEndPoint);
    Map<String, String> body = {'mobile_no': number, 'type': type, "otp": otp};
    final jsonBody = json.encode(body);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var encoding = Encoding.getByName('utf-8');

    var res =
        await post(uri, headers: headers, body: jsonBody, encoding: encoding);
    try {
      if (kDebugMode) {
        debugPrint(res.body);
      }

      return userModelFromMap(res.body);
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  Future<dynamic> resendOTP(String number, String type) async {
    Uri uri = Uri.parse(resendOTPEndPoint);
    Map<String, String> body = {'mobile_no': number, 'type': type};
    final jsonBody = json.encode(body);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var encoding = Encoding.getByName('utf-8');

    var res =
        await post(uri, headers: headers, body: jsonBody, encoding: encoding);
    try {
      return userModelFromMap(res.body);
    } catch (e) {
      return "";
    }
  }
}
