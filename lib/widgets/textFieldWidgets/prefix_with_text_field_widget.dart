import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/color_class.dart';
import '../../common/common_class.dart';

class PrefixWithTextFieldWidget extends StatelessWidget {
  final TextInputType type;
  final List<TextInputFormatter>? formatter;
  final String text;
  final int? maxLength;
  final String? hasSuffix;
  final String? hasPrefix;
  final bool? enabled;
  final Function onTypeCallBack;
  final TextEditingController? textEditingController;
  final TextInputAction? myTextInputAction;


  PrefixWithTextFieldWidget(
      {Key? key,
      required this.maxLength,
      required this.type,
      required this.formatter,
      required this.text,
      required this.onTypeCallBack,
       this.enabled,
        this.myTextInputAction,

        this.hasSuffix,
      this.hasPrefix,
      this.textEditingController})
      : super(key: key);
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      style: _commonClass.getTextStyle(
          12, _colorClass.blackColor, CommonClass.medium),
      cursorColor: _colorClass.secondaryBrandColor,
      keyboardType: type,
      inputFormatters: formatter,
      maxLength: maxLength,
      textInputAction: myTextInputAction,

      decoration: InputDecoration(
        // prefix: Text("a"),
    prefixText: "+91 ",

   
        suffixText: hasSuffix,
        suffixStyle: TextStyle(color: _colorClass.secondaryBrandColor),
        prefixStyle: TextStyle(color: _colorClass.secondaryBrandColor),
        labelStyle: TextStyle(color: _colorClass.secondaryBrandColor),
        border: OutlineInputBorder(
            borderSide:
                BorderSide(color: _colorClass.secondaryBrandColor, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: _colorClass.secondaryBrandColor, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: _colorClass.secondaryBrandColor, width: 1)),
        labelText: text,
        enabled: enabled==null?true:false
      ),
      onChanged: (e) {
        onTypeCallBack(e);
      },
    );
  }
}
