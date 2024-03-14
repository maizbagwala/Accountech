import 'package:accountech/model/partyModels/party_list_model.dart';
import 'package:flutter/material.dart';

import '../../../../common/color_class.dart';
import '../../../../common/common_class.dart';
import '../../../../widgets/textWidgets/text_widget.dart';

class PartiesCommonRowWidget extends StatefulWidget {
  final Function onTap;
  final Datum? data;
  const PartiesCommonRowWidget({Key? key,required this.onTap, required this.data}) : super(key: key);

  @override
  State<PartiesCommonRowWidget> createState() => _PartiesCommonRowWidgetState();
}

class _PartiesCommonRowWidgetState extends State<PartiesCommonRowWidget> {
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
              widget.onTap(widget.data!.id.toString(),widget.data!.name);
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
                        text: "Cash Sale",
                        textStyle: _commonClass.getTextStyle(
                            13, _colorClass.blackColor, CommonClass.semiBold)),
                  ),

                  SizedBox(
                    height: 20,
                    child: TextWidget(
                        text: "${widget.data!.name} ,${widget.data!.partyType}",
                        textStyle: _commonClass.getTextStyle(
                            12, _colorClass.blackColor, CommonClass.light)),
                  ),

                  SizedBox(
                    height: 15,
                    child: TextWidget(
                        text: "${widget.data!.openingBalance}",
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
