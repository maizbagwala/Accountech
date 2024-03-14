import 'package:accountech/common/api_services.dart';
import 'package:accountech/common/my_shared_preferences.dart';
import 'package:accountech/model/companyModels/business_details.dart';
import 'package:http/http.dart' as http;

class BusinessController extends ApiServices{


  Future<dynamic> getBusinessProfile() async{
    Uri uri = Uri.parse(getCompanyDetailEndPoint+MySharedPreferences.userID.$.toString());
    var response = await http.get(uri);
    try{
      return businessDetailsModelFromMap(response.body);
    }catch(e)
    {
      return "";
    }

  }

}