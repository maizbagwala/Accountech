import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../../common/color_class.dart';
import '../../../../common/common_class.dart';
import '../../../../widgets/textWidgets/text_widget.dart';

class CreditNoteDocumentWidget extends StatefulWidget {
  const CreditNoteDocumentWidget({Key? key, }) : super(key: key);

  @override
  State<CreditNoteDocumentWidget> createState() => _CreditNoteDocumentWidgetState();
}
final CommonClass _commonClass=CommonClass();
final ColorClass _colorClass=ColorClass();
class _CreditNoteDocumentWidgetState extends State<CreditNoteDocumentWidget> {
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
                                        text:"Uploaded Document",
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





                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    border: Border.all(
                                        color: _colorClass.secondaryBrandColor)),
                                child: Image.asset(
                                  _commonClass.accountechMainLogo,
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 62,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: _colorClass.secondaryBrandColor,
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    border: Border.all(
                                        color: _colorClass.secondaryBrandColor)),
                                child: InkWell(
                                  splashColor: _colorClass.bgColor,
                                  onTap: () {},
                                  child: TextWidget(
                                      text: "DELETE",
                                      textStyle: _commonClass.getTextStyle(
                                          10,
                                          _colorClass.whiteColor,
                                          CommonClass.medium)),
                                ),
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
