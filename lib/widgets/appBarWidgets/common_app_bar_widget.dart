
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/color_class.dart';

class CommonAppBarWidget extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;

  CommonAppBarWidget({Key? key,this.leading,this.title,this.actions}) : super(key: key);
  final ColorClass _colorClass = ColorClass();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _colorClass.whiteColor,
      elevation: 0.7,
titleSpacing: 0,
      leading: leading ?? Material(
color: _colorClass.whiteColor,
        child: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          customBorder: const CircleBorder(),
          splashColor: _colorClass.bgColor,
          child: Icon(
            FontAwesomeIcons.arrowLeftLong,
            color: _colorClass.mainBrandColor,
          ),
        ),
      ),
      title: title,
      actions: actions,
    );
  }
}
