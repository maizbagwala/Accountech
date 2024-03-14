import 'package:shared_value/shared_value.dart';

class MySharedPreferences {
  static SharedValue<int> languageCode = SharedValue(
      // initial value
      value: 1,
      key: 'languageCode',
      autosave: true);
  static SharedValue<int> userID = SharedValue(
      // initial value
      value: -1,
      key: 'userID',
      autosave: true);
  static SharedValue<int> companyID = SharedValue(
      // initial value
      value: -1,
      key: 'companyID',
      autosave: true);
  static SharedValue<String> userName = SharedValue(
      // initial value
      value: "",
      key: 'userName',
      autosave: true);
  static SharedValue<String> accessToken = SharedValue(
      // initial value
      value: "",
      key: 'accessToken',
      autosave: true);
  static SharedValue<String> businessSelectedName = SharedValue(
      // initial value
      value: "",
      key: 'businessSelectedName',
      autosave: true);
  static SharedValue<int> businessSelectedID = SharedValue(
      // initial value
      value: -1,
      key: 'businessSelectedID',
      autosave: true);
}
