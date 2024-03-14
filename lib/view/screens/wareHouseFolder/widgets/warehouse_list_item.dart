import 'package:accountech/model/warehouse/warehouse_response.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';

import '../../../../widgets/textWidgets/text_widget.dart';
final ColorClass _colorClass = ColorClass();
final CommonClass _commonClass = CommonClass();
class WarehouseListItem extends StatelessWidget {
  final Data item;
  const WarehouseListItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: _colorClass.secondaryBrandColor),
          ),
          width: _commonClass.getScreenWidth(context),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                    overflow: TextOverflow.visible,
                    text: "${item.warehouseNo}",
                    textStyle: _commonClass.getTextStyle(
                        15,
                        _colorClass.blackColor,
                        CommonClass.regular)),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                    overflow: TextOverflow.visible,
                    text: "Warehouse name",
                    textStyle: _commonClass.getTextStyle(
                        13,
                        _colorClass.blackColor,
                        CommonClass.semiBold)),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                    overflow: TextOverflow.visible,
                    text: "${item.warehouseName}",
                    textStyle: _commonClass.getTextStyle(
                        11,
                        _colorClass.blackColor,
                        CommonClass.regular)),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                    overflow: TextOverflow.visible,
                    text: "Incharge Name",
                    textStyle: _commonClass.getTextStyle(
                        13,
                        _colorClass.blackColor,
                        CommonClass.semiBold)),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                    overflow: TextOverflow.visible,
                    text: "${item.inchargeName}",
                    textStyle: _commonClass.getTextStyle(
                        11,
                        _colorClass.blackColor,
                        CommonClass.regular)),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                    overflow: TextOverflow.visible,
                    text: "Contact no.",
                    textStyle: _commonClass.getTextStyle(
                        13,
                        _colorClass.blackColor,
                        CommonClass.semiBold)),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                    overflow: TextOverflow.visible,
                    text: "${item.contactNo}",
                    textStyle: _commonClass.getTextStyle(
                        11,
                        _colorClass.blackColor,
                        CommonClass.regular)),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                    overflow: TextOverflow.visible,
                    text: "Address",
                    textStyle: _commonClass.getTextStyle(
                        13,
                        _colorClass.blackColor,
                        CommonClass.semiBold)),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                    overflow: TextOverflow.visible,
                    text:
                    "${item.address}",
                    textStyle: _commonClass.getTextStyle(
                        11,
                        _colorClass.blackColor,
                        CommonClass.regular)),
              ],
            ),
          ),
        ),
        Positioned(
          right: 5,
          top: 10,
          child: Row(
            children: [
              RotatedBox(
                quarterTurns: 2,
                child: SizedBox(
                  width: 30,
                  child: Opacity(
                    opacity: 0.2,
                    child: Lottie.asset(
                        _commonClass.swipeLeft),
                  ),
                ),
              ),
              //   Text("Swipe To Edit Or Delete"),
              //   SizedBox(width: 10,),
            ],
          ),
        )
      ],
    );
  }
}
