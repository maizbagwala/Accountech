import 'package:accountech/common/api_services.dart';
import 'package:accountech/common/my_shared_preferences.dart';
import 'package:accountech/model/authModels/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:async/async.dart';

import 'package:http/http.dart';
class AccountController extends ApiServices {
  Future<dynamic> getProfile() async{
    Uri uri = Uri.parse(getProfileEndPoint+MySharedPreferences.userID.$.toString());
    var response = await http.get(uri);
  try{
    return userModelFromMap(response.body);
  }catch(e)
    {
      return "";
    }

  }
  Future<dynamic> deleteProfile() async{
    Uri uri = Uri.parse(deactivateAccountEndPoint+MySharedPreferences.userID.$.toString());
    var response = await http.get(uri);
  try{
    return userModelFromMap(response.body);
  }catch(e)
    {
      return "";
    }

  }
  Future<dynamic> editProfile(
      String name,
      String panNo,
      File? profilePic,
      ) async {
    var uri = Uri.parse(editProfileEndPoint);
    var request = http.MultipartRequest("POST", uri);

    if(profilePic!=null) {
      String myProfilePic = profilePic.path
          .split("/")
          .last;
      var profilePicStream = ByteStream(
          DelegatingStream(profilePic.openRead()));
      var profilePicLength = await profilePic.length();
      var profilePicMultipartFileSign = MultipartFile(
          'profile_pic', profilePicStream, profilePicLength,
          filename: myProfilePic);
      request.files.add(profilePicMultipartFileSign);
    }
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);

    request.fields['id'] = MySharedPreferences.userID.$.toString();
    request.fields['name'] = name;
    request.fields['pan_no'] = panNo;

    var response = await request.send();

    var res = await Response.fromStream(response);
    try{
      return userModelFromMap(res.body);

    }
    catch(e)
    {
      return "";
    }
  }
}
