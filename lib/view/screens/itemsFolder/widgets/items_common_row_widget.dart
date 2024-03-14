import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/widgets/textWidgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../../../model/itemModel/item_response_model.dart';
import '../../../../common/color_class.dart';

class ItemsCommonRowWidget extends StatelessWidget {
  final Function onTap;
  final Data data;

   ItemsCommonRowWidget({Key? key, required this.onTap, required this.data}) : super(key: key);

  final ColorClass _colorClass = ColorClass();

  final CommonClass _commonClass = CommonClass();

final StringFile _stringFile=StringFile();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _colorClass.mainBrandColor.withOpacity(0.001),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  onTap("1234");
                },
                splashColor: _colorClass.greyColor.withAlpha(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextWidget(
                            text: "${data.stockQty} (PCS)",
                            textStyle: _commonClass.getTextStyle(
                                13, _colorClass.greenColor, CommonClass.light),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: TextWidget(
                          text: "Test Product",
                          textStyle: _commonClass.getTextStyle(
                              13, _colorClass.blackColor, CommonClass.semiBold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextWidget(
                                text: _stringFile.salePrice,
                                textStyle: _commonClass.getTextStyle(
                                    13,
                                    _colorClass.blackColor,
                                    CommonClass.semiBold),
                              ),
                            ),
                            Expanded(
                              child: TextWidget(
                                text: "₹ ${data.salesPrice}",
                                textStyle: _commonClass.getTextStyle(13,
                                    _colorClass.blackColor, CommonClass.light),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextWidget(
                                overflow: TextOverflow.visible,
                                text: _stringFile.purchasePrice,
                                textStyle: _commonClass.getTextStyle(
                                    13,
                                    _colorClass.blackColor,
                                    CommonClass.semiBold),
                              ),
                            ),
                            Expanded(
                              child: TextWidget(
                                text: "₹ ${data.purchasePrice}",
                                textStyle: _commonClass.getTextStyle(13,
                                    _colorClass.blackColor, CommonClass.light),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 20,
                child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(color: _colorClass.mainBrandColor),
                    child: PopupMenuButton(
                        padding: const EdgeInsets.all(0),
                        iconSize: 5,
                        icon: TextWidget(
                          overflow: TextOverflow.visible,
                          text: _stringFile.settings,
                          textStyle: _commonClass.getTextStyle(
                              10, _colorClass.whiteColor, CommonClass.semiBold),
                        ),
                        itemBuilder: (context) => [
                                PopupMenuItem(
                                child: Text(_stringFile.appendStock),
                                value: 1,
                              ),
                                PopupMenuItem(
                                child: Text(_stringFile.decreaseStock),
                                value: 2,
                              )
                            ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
