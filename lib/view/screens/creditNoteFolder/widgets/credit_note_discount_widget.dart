import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../common/color_class.dart';
import '../../../../common/common_class.dart';
import '../../../../common/string_file.dart';
import '../../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../../widgets/textWidgets/text_widget.dart';

class CreditNoteDiscountWidget extends StatefulWidget {
  const CreditNoteDiscountWidget({Key? key}) : super(key: key);

  @override
  State<CreditNoteDiscountWidget> createState() => _CreditNoteDiscountWidgetState();
}
final CommonClass _commonClass=CommonClass();
final ColorClass _colorClass=ColorClass();
final StringFile _stringFile=StringFile();
class _CreditNoteDiscountWidgetState extends State<CreditNoteDiscountWidget> {
  final ExpandableController _discountController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return         SizedBox(
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
                          controller: _discountController,
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
                                        text: _stringFile.discount,
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
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFieldWidget(
                                            hasSuffix: "%",
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
                                            text: "${_stringFile.discountIn} %",
                                            onTypeCallBack: (e) {}),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: TextFieldWidget(
                                            hasSuffix: "₹",
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
                                            text: "${_stringFile.discountIn} ₹",
                                            onTypeCallBack: (e) {}),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ))
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
