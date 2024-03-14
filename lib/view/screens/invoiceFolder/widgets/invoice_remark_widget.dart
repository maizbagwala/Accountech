import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../../common/color_class.dart';
import '../../../../common/common_class.dart';
import '../../../../common/string_file.dart';
import '../../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../../widgets/textWidgets/text_widget.dart';

class InvoiceRemarkWidget extends StatefulWidget {
  const InvoiceRemarkWidget({Key? key}) : super(key: key);

  @override
  State<InvoiceRemarkWidget> createState() => _InvoiceRemarkWidgetState();
}
final CommonClass _commonClass=CommonClass();
final ColorClass _colorClass=ColorClass();
final StringFile _stringFile=StringFile();
class _InvoiceRemarkWidgetState extends State<InvoiceRemarkWidget> {
  final ExpandableController _remarkController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
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
                            controller: _remarkController,
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
                                          text: _stringFile.remark,
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
                    ))
              ],
            ),
          ),
        ),
      );
  }
}
