import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/color_class.dart';
import '../../common/common_class.dart';

class TextFieldWidget extends StatelessWidget {
  final TextInputType type;
  final List<TextInputFormatter>? formatter;
  final String text;
  final String? initialValue;
  final int? maxLength;
  final String? hasSuffix;
  final String? hasPrefix;
  final bool? enabled;
  final bool? maxLines;
  final Function onTypeCallBack;
  final TextEditingController? textEditingController;
  final bool? hasUpperCase;
  final TextInputAction? myTextInputAction;


  TextFieldWidget(
      {Key? key,
      required this.maxLength,
      required this.type,
      required this.formatter,
      required this.text,
      required this.onTypeCallBack,
        this.initialValue,

        this.enabled,
       this.myTextInputAction,
      this.hasSuffix,
      this.hasPrefix,
      this.maxLines,
      this.textEditingController,
      this.hasUpperCase})
      : super(key: key);
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
initialValue: initialValue,
      textCapitalization: hasUpperCase==null?TextCapitalization.none:TextCapitalization.characters,
      controller: textEditingController,
      style: _commonClass.getTextStyle(
          15, _colorClass.blackColor, CommonClass.medium),
      cursorColor: _colorClass.secondaryBrandColor,
      keyboardType: type,
      maxLines:maxLines==true?1:null,
      inputFormatters: formatter,
      maxLength: maxLength,
      textInputAction: myTextInputAction,
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
