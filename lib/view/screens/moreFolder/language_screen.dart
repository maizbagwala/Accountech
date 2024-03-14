import 'dart:async';
import 'dart:io';

import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/my_shared_preferences.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_more_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:group_button/group_button.dart';
import 'package:restart_app/restart_app.dart';
import '../../../common/common_class.dart';

class MoreScreen extends StatefulWidget {
  final String textName;

  const MoreScreen(this.textName, {Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {

  @override
  void initState() {
    super.initState();
  }

  final CommonClass _commonClass = CommonClass();
  final ColorClass _colorClass = ColorClass();
  final StringFile _stringFile = StringFile();
  int _tick = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(CommonClass.headerHeight - 4),
        child: Column(
          children: [CommonAppBarMoreWidget()],
        ),
      ),
      body: Container(
        width: _commonClass.getScreenWidth(context),
        color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
        height: _commonClass.getScreenHeight(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_stringFile.selectLanguage),
              GroupButton(
                isRadio: true,
                onSelected: (value,index, isSelected) {
                  setState(() {
                    MySharedPreferences.languageCode.$ = index == 0 ? 1 : 2;
                  });
                  Timer.periodic(  const Duration(seconds: 1), (timer) {

      setState(() {
        _tick = timer.tick;
      });

                    if (timer.tick ==  _commonClass.totalLanguageChangeTick) {
                      timer.cancel();
                      if (Platform.isAndroid) {
                        Restart.restartApp();
                      } else {
                        Phoenix.rebirth(context);
                      }
                    }
                  });
                },
                buttons: [_stringFile.english, _stringFile.hindi],
                controller: GroupButtonController(
                  selectedIndex:
                      MySharedPreferences.languageCode.$ == 1 ? 0 : 1,
                ),
                options: GroupButtonOptions(
                    selectedColor: _colorClass.mainBrandColor.withAlpha(30),
                    unselectedColor: _colorClass.bgColor,
                    selectedTextStyle:
                        TextStyle(color: _colorClass.mainBrandColor),
                    selectedBorderColor: _colorClass.mainBrandColor,
                    unselectedBorderColor: _colorClass.transparent,
                    borderRadius: BorderRadius.circular(20)),
              ),
              _tick == 0
                  ? Container()
                  : Text("We are changing language in " + _tick.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
