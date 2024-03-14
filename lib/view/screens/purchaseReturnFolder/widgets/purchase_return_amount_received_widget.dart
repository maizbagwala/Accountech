import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_button/group_button.dart';

import '../../../../common/color_class.dart';
import '../../../../common/common_class.dart';
import '../../../../common/string_file.dart';
import '../../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../../widgets/textWidgets/text_widget.dart';

class PurchaseReturnAmountReceivedWidget extends StatefulWidget {
  const PurchaseReturnAmountReceivedWidget({Key? key}) : super(key: key);

  @override
  State<PurchaseReturnAmountReceivedWidget> createState() => _PurchaseReturnAmountReceivedWidgetState();
}
final CommonClass _commonClass=CommonClass();
final ColorClass _colorClass=ColorClass();
final StringFile _stringFile=StringFile();
class _PurchaseReturnAmountReceivedWidgetState extends State<PurchaseReturnAmountReceivedWidget> {
  final ExpandableController _roundOffController = ExpandableController();


  @override
  Widget build(BuildContext context) {
    return           SizedBox(
      width: _commonClass.getScreenWidth(context),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpandableNotifier(
                  child: ScrollOnExpand(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ExpandablePanel(
                          controller: _roundOffController,
                          theme: const ExpandableThemeData(
                            headerAlignment:
                            ExpandablePanelHeaderAlignment.center,
                            hasIcon: true,
                          ),
                          header: Container(
                            color: _colorClass.transparent,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 17, horizontal: 0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: TextWidget(
                                        text: _stringFile.amount,
                                        textStyle:
                                        _commonClass.getTextStyle(
                                            15,
                                            _colorClass.blackColor,
                                            CommonClass.medium),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          collapsed: Container(),
                          expanded: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [

                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFieldWidget(

                                            maxLength: 10,
                                            type:
                                            TextInputType.number,
                                            formatter: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  10),
                                            ],
                                            text: _stringFile.receivedAmount,
                                            onTypeCallBack: (e) {}),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: TextFieldWidget(

                                            maxLength: 10,
                                            type:
                                            TextInputType.number,
                                            formatter: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  10),
                                            ],
                                            text: _stringFile.balanceAmount,
                                            onTypeCallBack: (e) {}),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),

                                    ],
                                  ))
                              ,
                              TextWidget(
                                text: _stringFile.paymentMode,
                                textStyle:
                                _commonClass.getTextStyle(
                                    15,
                                    _colorClass.blackColor,
                                    CommonClass.medium),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GroupButton(
                                isRadio: true,
                                onSelected: (value,index, isSelected) {},
                                buttons:   [_stringFile.cash,_stringFile.cheque, _stringFile.online,  ],
                                controller: GroupButtonController(
                                  selectedIndex: 0,
                                ),
                                options: GroupButtonOptions(
                                    selectedColor: _colorClass
                                        .mainBrandColor
                                        .withAlpha(30),
                                    unselectedColor:
                                    _colorClass.bgColor,
                                    selectedTextStyle: TextStyle(
                                        color: _colorClass
                                            .mainBrandColor),
                                    selectedBorderColor:
                                    _colorClass.mainBrandColor,
                                    unselectedBorderColor:
                                    _colorClass.transparent,
                                    borderRadius:
                                    BorderRadius.circular(20)),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
