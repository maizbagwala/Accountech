import 'package:accountech/common/string_file.dart';
import 'package:accountech/widgets/textWidgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/color_class.dart';
import '../../common/common_class.dart';

class CommonAppBarDashboardWidget extends StatelessWidget {
  CommonAppBarDashboardWidget({Key? key}) : super(key: key);
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();
  final StringFile _stringFile = StringFile();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _colorClass.whiteColor,
      elevation: 0.7,
      title: TextWidget(
        text: _stringFile.parties,
        textStyle: _commonClass.getTextStyle(
            20, _colorClass.blackColor, CommonClass.semiBold),
      ),
      actions: [
        IconButton(
          tooltip: _stringFile.search,
          padding: const EdgeInsets.all(0),
          icon: const Icon(FontAwesomeIcons.magnifyingGlass),
          iconSize: 20,
          onPressed: () {},
          splashColor: _colorClass.bgColor,
          color: _colorClass.mainBrandColor,
        ),
        IconButton(
          tooltip: _stringFile.businessCard,

          padding: const EdgeInsets.all(0),
          icon: const Icon(FontAwesomeIcons.solidAddressCard),
          iconSize: 20,
          onPressed: () {},
          splashColor: _colorClass.bgColor,
          color: _colorClass.mainBrandColor,
        ),
      ],
    );
  }
}
