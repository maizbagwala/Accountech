import 'package:accountech/common/string_file.dart';
import 'package:accountech/widgets/textWidgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../common/color_class.dart';
import '../../common/common_class.dart';

class CommonAppBarMoreWidget extends StatelessWidget {
  CommonAppBarMoreWidget({Key? key}) : super(key: key);
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();
  final StringFile _stringFile = StringFile();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _colorClass.whiteColor,
      elevation: 0.7,
      title: TextWidget(
        text: _stringFile.profile,
        textStyle: _commonClass.getTextStyle(
            20, _colorClass.blackColor, CommonClass.semiBold),
      ),

    );
  }
}
