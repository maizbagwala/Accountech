import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../common/color_class.dart';
import '../../../../../common/common_class.dart';
import '../../../../../common/string_file.dart';
import '../../../../../widgets/textWidgets/text_widget.dart';

class PartiesBelowAppBarWidget extends StatefulWidget {
    const PartiesBelowAppBarWidget({Key? key}) : super(key: key);

  @override
  State<PartiesBelowAppBarWidget> createState() => _PartiesBelowAppBarWidgetState();
}

class _PartiesBelowAppBarWidgetState extends State<PartiesBelowAppBarWidget> {
  final ColorClass _colorClass = ColorClass();

  final StringFile _stringFile = StringFile();

  final CommonClass _commonClass = CommonClass();

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: _commonClass.getScreenWidth(context),
        color: _colorClass.whiteColor,
        height: 50,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Tooltip(
                message: _stringFile.toPay,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _colorClass.bgColor,
                  ),
                  child: TextWidget(
                    text: _stringFile.toPay,
                    textStyle: _commonClass.getTextStyle(
                        12, _colorClass.blackColor, CommonClass.medium),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Tooltip(
                message: _stringFile.toCollect,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _colorClass.bgColor,
                  ),
                  child: TextWidget(
                    text: _stringFile.toCollect,
                    textStyle: _commonClass.getTextStyle(
                        12, _colorClass.blackColor, CommonClass.medium),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _colorClass.bgColor,
                ),
                child: Row(
                  children: [
                    TextWidget(
                      text: _stringFile.toCollect,
                      textStyle: _commonClass.getTextStyle(
                          12, _colorClass.blackColor, CommonClass.medium),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      FontAwesomeIcons.angleDown,
                      size: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Tooltip(
                message: _stringFile.filter,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: _colorClass.bgColor,
                    ),
                    child: Icon(
                      FontAwesomeIcons.filter,
                      size: 20,
                      color: _colorClass.mainBrandColor,
                    )),
              ),
            ],
          ),
        ),
      );
  }
}
