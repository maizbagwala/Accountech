import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/color_class.dart';
import '../../common/common_class.dart';

class NormalTextFieldWidget extends StatelessWidget {
  final TextInputType type;
  final List<TextInputFormatter>? formatter;
  final String text;
  final TextEditingController? controller;
  final int? maxLength;
  final String? hasSuffix;
  final String? hasPrefix;
  final Function onTypeCallBack;

  NormalTextFieldWidget(
      {Key? key,
      required this.maxLength,
      required this.type,
      required this.formatter,
      required this.text,
      required this.onTypeCallBack,
      this.controller,
      this.hasSuffix,
      this.hasPrefix})
      : super(key: key);
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: _commonClass.getTextStyle(
          12, _colorClass.blackColor, CommonClass.medium),
      cursorColor: _colorClass.secondaryBrandColor,
      keyboardType: type,
      inputFormatters: formatter,
      maxLength: maxLength,
      decoration: InputDecoration(
        prefixIcon: hasPrefix == null
            ? null
            : Icon(
                FontAwesomeIcons.indianRupeeSign,
                size: 10,
                color: _colorClass.secondaryBrandColor,
              ),
   
        suffixText: hasSuffix,
        suffixStyle: TextStyle(color: _colorClass.secondaryBrandColor),
        prefixStyle: TextStyle(color: _colorClass.secondaryBrandColor),
        labelStyle: TextStyle(color: _colorClass.secondaryBrandColor),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        labelText: text,
      ),
      onChanged: (e) {
        onTypeCallBack(e);
      },
    );
  }
}
