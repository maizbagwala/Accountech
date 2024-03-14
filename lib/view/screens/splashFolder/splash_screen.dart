
import 'package:accountech/common/my_shared_preferences.dart';
import 'package:accountech/view/screens/authFolder/auth_selection_screen.dart';
import 'package:accountech/view/screens/mainFolder/main_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../../common/common_class.dart';

class SplashScreen extends StatefulWidget {
  static String splashScreenRoute = "/";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final CommonClass _commonClass = CommonClass();

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: _commonClass.splashTick), (timer) {

      if (timer.tick == _commonClass.totalSplashTick) {
        CommonClass.languageCode=MySharedPreferences.languageCode.$;
        if(MySharedPreferences.userID.$==-1)
          {
            Navigator.pushNamedAndRemoveUntil(context, AuthSelectionScreen.authSelectionScreenRoute,(Route<dynamic> route)=>false);

          }
        else{
          Navigator.pushNamedAndRemoveUntil(context,   MainScreen.mainScreenRoute,(Route<dynamic> route)=>false);

        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(
            _commonClass.accountechMainLogo,
            width: _commonClass.getScreenWidth(context) - 100,
          ),
        ),
      ),
    );
  }
}
