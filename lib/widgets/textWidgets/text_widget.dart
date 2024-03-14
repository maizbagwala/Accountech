import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final TextOverflow? overflow;
  const TextWidget( {Key? key,required this.text, required this.textStyle,   this.overflow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,style: textStyle,overflow: overflow ?? TextOverflow.ellipsis,);
  }
}
