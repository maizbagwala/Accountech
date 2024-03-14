import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/widgets/textWidgets/text_widget.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../common/common_class.dart';
import '../../../../widgets/textFieldWidgets/text_field_widget.dart';

class ItemStockRemarkWidget extends StatefulWidget {
  const ItemStockRemarkWidget({Key? key}) : super(key: key);

  @override
  State<ItemStockRemarkWidget> createState() => _ItemStockRemarkWidgetState();
}

ColorClass _colorClass = ColorClass();
StringFile _stringFile = StringFile();
CommonClass _commonClass = CommonClass();

class _ItemStockRemarkWidgetState extends State<ItemStockRemarkWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpandableTheme(
      data: ExpandableThemeData(
        iconColor: _colorClass.mainBrandMaterialColor,
        collapseIcon: FontAwesomeIcons.circleMinus,
        expandIcon: FontAwesomeIcons.circlePlus,
        useInkWell: true,
      ),
      child: const MyCard(),
    );
  }
}

class MyCard extends StatefulWidget {
  const MyCard({Key? key}) : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  ExpandableController controller = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: ScrollOnExpand(
      child: Column(
        children: <Widget>[
          ExpandablePanel(
            controller: controller,
            theme: const ExpandableThemeData(
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              hasIcon: true,
            ),
            header: Container(
              color: _colorClass.transparent,
              child: Row(
                children: [
                  Expanded(
                      child: TextWidget(
                    text: _stringFile.addRemark,
                    textStyle: _commonClass.getTextStyle(
                        14, _colorClass.blackColor, CommonClass.semiBold),
                  )),
                ],
              ),
            ),
            collapsed: Container(),
            expanded: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                    maxLength: null,

                    type: TextInputType.text,
                    formatter: null,
                    text: _stringFile.addRemark,
                    onTypeCallBack: (e) {}),

              ],
            ),
          ),
        ],
      ),
    ));
  }
}
