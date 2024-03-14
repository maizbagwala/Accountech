import 'package:accountech/common/api_services.dart';
import 'package:accountech/common/my_shared_preferences.dart';
import 'package:accountech/model/companyModels/company_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';


class CompanyController extends ApiServices{

Future<CompanyListModel> getBusinessList() async
{
debugPrint("business list url is=====$getCompanyListEndPoint/${MySharedPreferences.userID.$}");
  var response= await get(Uri.parse("$getCompanyListEndPoint/${MySharedPreferences.userID.$}"));
  return companyListModelFromMap(response.body);

}}