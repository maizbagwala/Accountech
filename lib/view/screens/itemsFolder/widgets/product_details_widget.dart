import 'package:accountech/common/string_file.dart';
import 'package:flutter/material.dart';
import '../../../../common/color_class.dart';
import '../../../../common/common_class.dart';
import '../../../../widgets/textWidgets/text_widget.dart';

class ProductDetailWidget extends StatefulWidget {
  const ProductDetailWidget({Key? key}) : super(key: key);

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  final ColorClass _colorClass = ColorClass();

  final CommonClass _commonClass = CommonClass();
final StringFile _stringFile=StringFile();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: _commonClass.getScreenWidth(context),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                      text: _stringFile.itemDetails,
                      textStyle: _commonClass.getTextStyle(
                          13, _colorClass.blackColor, CommonClass.semiBold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: _stringFile.itemCode,
                                textStyle: _commonClass.getTextStyle(
                                    11,
                                    _colorClass.blackColor,
                                    CommonClass.medium)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                text: "--",
                                textStyle: _commonClass.getTextStyle(10,
                                    _colorClass.blackColor, CommonClass.light)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text:  _stringFile.measurementUnit,
                                textStyle: _commonClass.getTextStyle(
                                    11,
                                    _colorClass.blackColor,
                                    CommonClass.medium)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                text: "PCS",
                                textStyle: _commonClass.getTextStyle(10,
                                    _colorClass.blackColor, CommonClass.light)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text:  _stringFile.lowStockAt,
                                textStyle: _commonClass.getTextStyle(
                                    11,
                                    _colorClass.blackColor,
                                    CommonClass.medium)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                text: "0.0 (PCS)",
                                textStyle: _commonClass.getTextStyle(10,
                                    _colorClass.blackColor, CommonClass.light)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text:  _stringFile.taxRate,
                                textStyle: _commonClass.getTextStyle(
                                    11,
                                    _colorClass.blackColor,
                                    CommonClass.medium)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                text: "0.0",
                                textStyle: _commonClass.getTextStyle(10,
                                    _colorClass.blackColor, CommonClass.light)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text:  _stringFile.hsnCode,
                                textStyle: _commonClass.getTextStyle(
                                    11,
                                    _colorClass.blackColor,
                                    CommonClass.medium)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                text: "--",
                                textStyle: _commonClass.getTextStyle(10,
                                    _colorClass.blackColor, CommonClass.light)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            // TextWidget(
                            //     text:  _stringFile.itemType,
                            //     textStyle: _commonClass.getTextStyle(
                            //         11,
                            //         _colorClass.blackColor,
                            //         CommonClass.medium)),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // TextWidget(
                            //     text: "Product",
                            //     textStyle: _commonClass.getTextStyle(10,
                            //         _colorClass.blackColor, CommonClass.light)),
                            //
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: _commonClass.getScreenWidth(context),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                      text: _stringFile.remark,
                      textStyle: _commonClass.getTextStyle(
                          13, _colorClass.blackColor, CommonClass.semiBold)),
                  const SizedBox(
                    height: 10,
                  ),
                  TextWidget(
                      text: "--",
                      textStyle: _commonClass.getTextStyle(
                          10, _colorClass.blackColor, CommonClass.light)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
