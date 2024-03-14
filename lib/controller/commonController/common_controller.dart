import 'package:accountech/common/api_services.dart';
import 'package:accountech/model/commonModels/business_type_model.dart';
import 'package:accountech/model/commonModels/industry_type_model.dart';
import 'package:accountech/model/commonModels/package_model.dart';
import 'package:accountech/model/commonModels/place_of_supply_model.dart';
import 'package:http/http.dart' as http;

class CommonController extends ApiServices{

  Future<BusinessTypeModel> getBusinessType() async
  {

 var response= await http.get(Uri.parse(getBusinessTypeEndPoint));
 return businessTypeModelFromMap(response.body);

  }
  Future<IndustryTypeModel> getIndustryType() async
  {

 var response= await http.get(Uri.parse(getIndustryTypeEndPoint));
 return industryTypeModelFromMap(response.body);

  }
  Future<PlaceOfSupplyModel> getPlaceOfSupply() async
  {

 var response= await http.get(Uri.parse(getPlaceOfSupplyEndPoint));
 return placeOfSupplyModelFromMap(response.body);

  }
  Future<PackageModel> getPackages() async
  {
 var response= await http.get(Uri.parse(getPackagesEndPoint));
 return packageModelFromMap(response.body);

  }

}