import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../common/color_class.dart';
import '../../../../common/common_class.dart';
import '../../../../common/string_file.dart';
import '../../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../../widgets/textWidgets/text_widget.dart';

class SalesReturnAdditionalChargesWidget extends StatefulWidget {
  const SalesReturnAdditionalChargesWidget({Key? key}) : super(key: key);

  @override
  State<SalesReturnAdditionalChargesWidget> createState() => _SalesReturnAdditionalChargesWidgetState();
}
final CommonClass _commonClass=CommonClass();
final ColorClass _colorClass=ColorClass();
final StringFile _stringFile=StringFile();
final ExpandableController _additionalsController = ExpandableController();

final List<int> _additionalChargesList = [];

class _SalesReturnAdditionalChargesWidgetState extends State<SalesReturnAdditionalChargesWidget> {
  @override
  Widget build(BuildContext context) {
    return             SizedBox(
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
                          controller: _additionalsController,
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
                                        text: _stringFile.addAdditionalCharges,
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
                              Align(
                                alignment: Alignment.centerRight,
                                child: Card(
                                  color: _colorClass.mainBrandColor,
                                  child: InkWell(
                                    splashColor: _colorClass.bgColor,
                                    onTap: () {
                                      setState(() {
                                        _additionalChargesList.add(1);
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: TextWidget(
                                          text: _stringFile.add,
                                          textStyle: _commonClass
                                              .getTextStyle(
                                              12,
                                              _colorClass
                                                  .whiteColor,
                                              CommonClass
                                                  .medium)),
                                    ),
                                  ),
                                ),
                              ),
                              ListView.builder(
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                  _additionalChargesList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 8.0,
                                            right: 8.0,
                                            top: 8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextFieldWidget(
                                                  maxLength: null,
                                                  type:
                                                  TextInputType
                                                      .text,
                                                  formatter: null,
                                                  text:
                                                  _stringFile.chargeName,
                                                  onTypeCallBack:
                                                      (e) {}),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: TextFieldWidget(
                                                  hasPrefix: "₹",
                                                  maxLength: null,
                                                  type:
                                                  TextInputType
                                                      .text,
                                                  formatter: null,
                                                  text: "0.0",
                                                  onTypeCallBack:
                                                      (e) {}),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Card(
                                              child: InkWell(
                                                splashColor: _colorClass.bgColor,
                                                onTap: () {
                                                  setState(() {
                                                    _additionalChargesList.removeAt(index);
                                                  });
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 18.0, horizontal: 10),
                                                  child: Icon(
                                                    FontAwesomeIcons.trash,
                                                    color: _colorClass.redColor,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
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
