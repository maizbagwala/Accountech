import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/color_class.dart';
import '../../../../common/common_class.dart';
import '../../../../common/string_file.dart';
import '../../../../controller/salesController/sales_controller.dart';
import '../../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../../widgets/textWidgets/text_widget.dart';

class SalesOrderNotesWidget extends StatefulWidget {
  const SalesOrderNotesWidget({Key? key}) : super(key: key);

  @override
  State<SalesOrderNotesWidget> createState() => _SalesOrderNotesWidgetState();
}
final CommonClass _commonClass=CommonClass();
final ColorClass _colorClass=ColorClass();
final StringFile _stringFile=StringFile();
var salesController=Get.find<SalesController>();

class _SalesOrderNotesWidgetState extends State<SalesOrderNotesWidget> {
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
                                        text: _stringFile.notes,
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
                                child: TextFieldWidget(

                                    maxLength: null,
                                    type:
                                    TextInputType.text,
                                    formatter: null,
                                    text: _stringFile.typeNotesHere,
                                    onTypeCallBack: (e) {
                                      salesController.notes.value=e;
                                    }),
                              )
                              ,

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