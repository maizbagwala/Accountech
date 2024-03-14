import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/widgets/textWidgets/text_widget.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/services.dart';
import '../../../../common/common_class.dart';
import '../../../../widgets/textFieldWidgets/text_field_widget.dart';

class PartiesGstPlansDetails extends StatefulWidget {
  final TextEditingController gstController;
  final TextEditingController panController;
  final TextEditingController adharController;
  const PartiesGstPlansDetails({Key? key, required this.gstController, required this.panController, required this.adharController}) : super(key: key);

  @override
  State<PartiesGstPlansDetails> createState() => _PartiesGstPlansDetailsState();
}

ColorClass _colorClass = ColorClass();
StringFile _stringFile = StringFile();
CommonClass _commonClass = CommonClass();

class _PartiesGstPlansDetailsState extends State<PartiesGstPlansDetails> {
  @override
  Widget build(BuildContext context) {
    return ExpandableTheme(
      data: ExpandableThemeData(
        iconColor: _colorClass.mainBrandMaterialColor,
        collapseIcon: FontAwesomeIcons.circleMinus,
        expandIcon: FontAwesomeIcons.circlePlus,
        useInkWell: true,
      ),
      child: MyCard(gstController: widget.gstController, panController: widget.panController, adharController: widget.adharController,),
    );
  }
}

class MyCard extends StatefulWidget {
  final TextEditingController gstController;
  final TextEditingController panController;
  final TextEditingController adharController;
  const MyCard({Key? key, required this.gstController, required this.panController, required this.adharController}) : super(key: key);

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
                        text: _stringFile.gstAndPan,
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
                    TextFieldWidget(
                      textEditingController: widget.gstController,
                        maxLength: 15,
                        type: TextInputType.text,
                        formatter: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(15),
                        ],
                        text: _stringFile.gstInIfApplicable,
                        onTypeCallBack: (e) {}),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        textEditingController: widget.panController,
                        maxLength: 10,
                        type: TextInputType.text,
                        formatter: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(10),
                        ],
                        text: _stringFile.panNumber,
                        onTypeCallBack: (e) {}),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        textEditingController: widget.adharController,
                        maxLength: 10,
                        type: TextInputType.text,
                        formatter: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(10),
                        ],
                        text: _stringFile.udyamAdharNumber,
                        onTypeCallBack: (e) {}),
                    const SizedBox(
                      height: 10,
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
