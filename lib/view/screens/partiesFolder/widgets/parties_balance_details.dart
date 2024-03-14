import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/widgets/textWidgets/text_widget.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/services.dart';
import 'package:group_button/group_button.dart';
import '../../../../../common/common_class.dart';

class PartiesBalanceDetails extends StatefulWidget {
  final TextEditingController creditPeriodController;
  final TextEditingController creditLimitController;
  final TextEditingController openingBalanceController;
  final Function getCreditStatusChangeValue;
  const PartiesBalanceDetails({Key? key, required this.creditPeriodController, required this.creditLimitController, required this.openingBalanceController, required this.getCreditStatusChangeValue}) : super(key: key);

  @override
  State<PartiesBalanceDetails> createState() => _PartiesBalanceDetailsState();
}

ColorClass _colorClass = ColorClass();
StringFile _stringFile = StringFile();
CommonClass _commonClass = CommonClass();

class _PartiesBalanceDetailsState extends State<PartiesBalanceDetails> {
  @override
  Widget build(BuildContext context) {
    return ExpandableTheme(
      data: ExpandableThemeData(
        iconColor: _colorClass.mainBrandMaterialColor,
        collapseIcon: FontAwesomeIcons.circleMinus,
        expandIcon: FontAwesomeIcons.circlePlus,
        useInkWell: true,
      ),
      child: MyCard(creditLimitController: widget.creditLimitController, creditPeriodController: widget.creditPeriodController, openingBalanceController: widget.openingBalanceController, getCreditStatusChangeValue: widget.getCreditStatusChangeValue,),
    );
  }
}

class MyCard extends StatefulWidget {
  final TextEditingController creditPeriodController;
  final TextEditingController creditLimitController;
  final TextEditingController openingBalanceController;
  final Function getCreditStatusChangeValue;
  const MyCard({Key? key, required this.creditPeriodController, required this.creditLimitController, required this.openingBalanceController, required this.getCreditStatusChangeValue}) : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  ExpandableController controller = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: ScrollOnExpand(
      child: Card(
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextWidget(
                        text: _stringFile.balanceDetails,
                        textStyle: _commonClass.getTextStyle(
                            13, _colorClass.mainBrandColor, CommonClass.medium),
                      )),
                    ],
                  ),
                ),
              ),
              collapsed: Container(),
              expanded: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                overflow: TextOverflow.visible,
                                text: _stringFile.setCreditPeriod,
                                textStyle: _commonClass.getTextStyle(13,
                                    _colorClass.blackColor, CommonClass.medium),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextWidget(
                                overflow: TextOverflow.visible,
                                text: _stringFile.setCreditPeriodSubtitle,
                                textStyle: _commonClass.getTextStyle(12,
                                    _colorClass.blackColor, CommonClass.light),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: widget.creditPeriodController,
                            cursorColor: _colorClass.mainBrandColor,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.calendarDay,
                                color: _colorClass.blackColor,
                                size: 15,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 0),
                              labelText: _stringFile.creditPeriod,
                              labelStyle: TextStyle(
                                  color: _colorClass.secondaryBrandColor),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _colorClass.secondaryBrandColor,
                                      width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _colorClass.secondaryBrandColor,
                                      width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _colorClass.secondaryBrandColor,
                                      width: 1)),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                overflow: TextOverflow.visible,
                                text: _stringFile.setCreditLimit,
                                textStyle: _commonClass.getTextStyle(13,
                                    _colorClass.blackColor, CommonClass.medium),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextWidget(
                                overflow: TextOverflow.visible,
                                text: _stringFile.setCreditLimitSubtitle,
                                textStyle: _commonClass.getTextStyle(12,
                                    _colorClass.blackColor, CommonClass.light),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: widget.creditLimitController,
                            cursorColor: _colorClass.mainBrandColor,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.indianRupeeSign,
                                color: _colorClass.blackColor,
                                size: 15,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 0),
                              labelText: _stringFile.creditLimit,
                              labelStyle: TextStyle(
                                  color: _colorClass.secondaryBrandColor),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _colorClass.secondaryBrandColor,
                                      width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _colorClass.secondaryBrandColor,
                                      width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _colorClass.secondaryBrandColor,
                                      width: 1)),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextField(
                          controller: widget.openingBalanceController,
                          maxLength: 15,
                          cursorColor: _colorClass.mainBrandColor,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(15),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              FontAwesomeIcons.indianRupeeSign,
                              color: _colorClass.blackColor,
                              size: 15,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 0),
                            labelText: _stringFile.openingBalance,
                            labelStyle: TextStyle(
                                color: _colorClass.secondaryBrandColor),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                          ),
                        ),

                        GroupButton(
                          isRadio: true,
                          onSelected: (value,index, isSelected) {
                            widget.getCreditStatusChangeValue(value);
                          },
                          buttons: [_stringFile.iReceive, _stringFile.iPay],
                          controller: GroupButtonController(
                            selectedIndex: 0,
                          ),

                          options: GroupButtonOptions(

                              mainGroupAlignment: MainGroupAlignment.start,
                              selectedColor:
                              _colorClass.mainBrandColor.withAlpha(30),
                              unselectedColor: _colorClass.bgColor,
                              selectedTextStyle:
                              TextStyle(color: _colorClass.mainBrandColor),
                              selectedBorderColor: _colorClass.mainBrandColor,
                              unselectedBorderColor: _colorClass.transparent,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
