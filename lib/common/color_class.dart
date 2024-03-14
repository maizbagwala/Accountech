
import 'package:flutter/material.dart';

class ColorClass {
  final _mainBrandColor = const Color(0xFF038640);
  final _secondaryBrandColor = const Color(0xFF393185);
  final _whiteColor = const Color(0xFFFFFFFF);
  final _blackColor=const Color(0xFF000000);
  final _greyColor=const Color(0xFF696969);
  final _transparent=const Color(0x00000000);
  final _redColor=const Color(0xFFA70101);
  final _greenColor=const Color(0xFF038640);

  get blackColor => _blackColor;
  final _bgColor = const Color(0xFFE7E7E7);
  final MaterialColor _mainBrandMaterialColor = const MaterialColor(
    0xFF038640,
      <int, Color>{
      50:   Color(0xFF038640),
      100:   Color(0xFF038640),
      200:   Color(0xFF038640),
      300:   Color(0xFF038640),
      400:   Color(0xFF038640),
      500:   Color(0xFF038640),
      600:   Color(0xFF038640),
      700:   Color(0xFF038640),
      800:   Color(0xFF038640),
      900:   Color(0xFF038640),
    },
  );

  get redColor => _redColor;

  get greenColor => _greenColor;

  get transparent => _transparent;

  get mainBrandColor => _mainBrandColor;

  get greyColor => _greyColor;

  get whiteColor => _whiteColor;

  MaterialColor get mainBrandMaterialColor => _mainBrandMaterialColor;

  get bgColor => _bgColor;

  get secondaryBrandColor => _secondaryBrandColor;
}
