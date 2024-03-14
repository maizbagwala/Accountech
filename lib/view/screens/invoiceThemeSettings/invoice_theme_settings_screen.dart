import 'package:accountech/common/common_class.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:group_button/group_button.dart';
import '../../../common/color_class.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class InvoiceThemeSettingsScreen extends StatefulWidget {
  static String invoiceThemeSettingsScreenRoute = "/InvoiceThemeSettingsScreen";

  const InvoiceThemeSettingsScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceThemeSettingsScreen> createState() =>
      _InvoiceThemeSettingsScreenState();
}

final ColorClass _colorClass = ColorClass();
final CommonClass _commonClass = CommonClass();

class _InvoiceThemeSettingsScreenState
    extends State<InvoiceThemeSettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  final List<String> _colors = [
    "#000000",
    "#407400",
    "#0B6A9F",
    "#840BB2",
    "#C11111",
    "#5B57AE",
    "#CD9D23",
    "#BF6200"
  ];
  String _selectedColor = "#000000";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: _colorClass.greyColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(CommonClass.headerHeight),
            child: Container(
              color: _colorClass.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonAppBarWidget(
                    title: TextWidget(
                      text: "Invoice Theme Settings",
                      textStyle: _commonClass.getTextStyle(
                          20, _colorClass.blackColor, CommonClass.semiBold),
                    ),
                  ),
                ],
              ),
            )),
        resizeToAvoidBottomInset: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ExpandableTheme(
          data: ExpandableThemeData(
            iconColor: _colorClass.mainBrandMaterialColor,
            collapseIcon: FontAwesomeIcons.circleMinus,
            expandIcon: FontAwesomeIcons.circlePlus,
            useInkWell: true,
          ),
          child: SizedBox(
            height: _commonClass.getScreenHeight(context),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(_commonClass.demoInvoice),
                ),
                Positioned(
                  child: Container(
                    color: _colorClass.whiteColor,
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GroupButton(
                              isRadio: true,
                              onSelected: (value, index, isSelected) {},
                              buttons: const [
                                "Stylish",
                                "GST",
                                "Billbook",
                                "GST(A5)",
                                "Billbook(A5)",
                                "Modern",
                                "Simple"
                              ],
                              controller: GroupButtonController(
                                selectedIndex: 0,
                              ),
                              options: GroupButtonOptions(
                                  selectedColor:
                                      _colorClass.mainBrandColor.withAlpha(30),
                                  unselectedColor: _colorClass.bgColor,
                                  selectedTextStyle: TextStyle(
                                      color: _colorClass.mainBrandColor),
                                  selectedBorderColor:
                                      _colorClass.mainBrandColor,
                                  unselectedBorderColor:
                                      _colorClass.transparent,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: _colors.length,
                              itemBuilder: (c, i) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedColor = _colors[i];
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: _selectedColor == _colors[i]
                                            ? _colorClass.mainBrandColor
                                                .withAlpha(100)
                                            : null,
                                        borderRadius:
                                            _selectedColor == _colors[i]
                                                ? BorderRadius.circular(20)
                                                : null,
                                        border: _selectedColor == _colors[i]
                                            ? Border.all(
                                                color: _colorClass
                                                    .mainBrandColor
                                                    .withAlpha(100),
                                                width: 2)
                                            : null),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: toColor(_colors[i]),
                                          shape: BoxShape.circle),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                  bottom: 0,
                  left: 0,
                  right: 0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  toColor(data) {
    var hexColor = data.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
