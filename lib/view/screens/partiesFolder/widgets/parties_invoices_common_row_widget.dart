import 'package:flutter/material.dart';

import '../../../../common/color_class.dart';
import '../../../../common/common_class.dart';
import '../../../../widgets/textWidgets/text_widget.dart';

class PartiesInvoicesCommonRowWidget extends StatefulWidget {
  final Function onTap;

  const PartiesInvoicesCommonRowWidget({Key? key, required this.onTap})
      : super(key: key);

  @override
  State<PartiesInvoicesCommonRowWidget> createState() =>
      _PartiesInvoicesCommonRowWidgetState();
}

class _PartiesInvoicesCommonRowWidgetState
    extends State<PartiesInvoicesCommonRowWidget> {
  final ColorClass _colorClass = ColorClass();

  final CommonClass _commonClass = CommonClass();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _colorClass.mainBrandColor.withOpacity(0.001),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: InkWell(
            onTap: () {
              widget.onTap("1234");
            },
            splashColor: _colorClass.greyColor.withAlpha(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    child: TextWidget(
                        text: "Invoice #01",
                        textStyle: _commonClass.getTextStyle(
                            13, _colorClass.blackColor, CommonClass.semiBold)),
                  ),
                  SizedBox(
                    height: 20,
                    child: TextWidget(
                        text: "10 QTY",
                        textStyle: _commonClass.getTextStyle(
                            12, _colorClass.blackColor, CommonClass.light)),
                  ),
                  SizedBox(
                    height: 15,
                    child: TextWidget(
                        text: "₹ 220.0",
                        textStyle: _commonClass.getTextStyle(
                            13, _colorClass.blackColor, CommonClass.semiBold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
