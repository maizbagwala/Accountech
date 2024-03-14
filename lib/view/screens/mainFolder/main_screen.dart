import 'package:accountech/view/screens/dashboardFolder/dashboard_screen.dart';
import 'package:accountech/view/screens/itemsFolder/items_screen.dart';
import 'package:accountech/view/screens/moreFolder/more_screen.dart';
import 'package:accountech/view/screens/partiesFolder/parties_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../common/color_class.dart';
import '../../../common/my_shared_preferences.dart';
import '../../../common/string_file.dart';

class MainScreen extends StatefulWidget {
  static String mainScreenRoute = "/MainScreen";

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}
final ColorClass _colorClass = ColorClass();
var _currentIndex = 0;
final StringFile _stringFile = StringFile();
final PageController _pageController =
PageController(initialPage: 0, keepPage: false);

class _MainScreenState extends State<MainScreen> {
@override
void initState(){
  _currentIndex=0;
  super.initState();
  print("bussiness selected id"+MySharedPreferences.businessSelectedID.$.toString());
  print("user id"+MySharedPreferences.userID.$.toString());
}
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: _colorClass.whiteColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          top: false,
          child: Scaffold(

            backgroundColor: _colorClass.whiteColor,
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children:<Widget> [
                DashboardScreen(_stringFile.dashboard),
                PartiesScreen(_stringFile.parties),
                ItemsScreen(_stringFile.items),
                // DashboardScreen(_stringFile.payments),
                MoreScreen(_stringFile.profile),
              ],
            ),
            bottomNavigationBar: const BottomBar(),
          ),
        ));
  }
}
class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {

    return SalomonBottomBar(
      currentIndex: _currentIndex,
      onTap: (i) {
        setState(() => _currentIndex = i);
        _pageController.animateToPage(_currentIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut);
      },
      items: [
        SalomonBottomBarItem(
          icon: const Icon(
            FontAwesomeIcons.house,
            size: 18,
          ),
          title: Text(_stringFile.dashboard),
          selectedColor: _colorClass.mainBrandMaterialColor,
        ),
        SalomonBottomBarItem(
          icon: const Icon(
            FontAwesomeIcons.users,
            size: 18,
          ),
          title: Text(_stringFile.parties),
          selectedColor: _colorClass.mainBrandMaterialColor,
        ),
        SalomonBottomBarItem(
          icon: const Icon(
            FontAwesomeIcons.box,
            size: 18,
          ),
          title: Text(_stringFile.items),
          selectedColor: _colorClass.mainBrandMaterialColor,
        ),
        // SalomonBottomBarItem(
        //   icon: const Icon(
        //     FontAwesomeIcons.rupeeSign,
        //     size: 18,
        //   ),
        //   title: Text(_stringFile.payments),
        //   selectedColor: _colorClass.mainBrandMaterialColor,
        // ),
        SalomonBottomBarItem(
          icon: const Icon(
            FontAwesomeIcons.user,
            size: 18,
          ),
          title: Text(_stringFile.profile),
          selectedColor: _colorClass.mainBrandMaterialColor,
        ),
      ],
    );
  }
}

