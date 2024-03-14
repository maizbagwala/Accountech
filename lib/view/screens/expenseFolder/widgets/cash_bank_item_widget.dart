import 'package:flutter/material.dart';

import '../../../../common/color_class.dart';
import '../../../../common/common_class.dart';
import '../../../../widgets/textWidgets/text_widget.dart';

class CashBankItemWidget extends StatefulWidget {
  const CashBankItemWidget({Key? key}) : super(key: key);

  @override
  State<CashBankItemWidget> createState() => _CashBankItemWidgetState();
}

final ColorClass _colorClass = ColorClass();
final CommonClass _commonClass = CommonClass();

class _CashBankItemWidgetState extends State<CashBankItemWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: _colorClass.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: _colorClass.bgColor,
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                      overflow: TextOverflow.visible,
                      text: "Item Name",
                      textStyle: _commonClass.getTextStyle(
                          12, _colorClass.greyColor, CommonClass.bold)),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                      overflow: TextOverflow.visible,
                      text: "Quantity",
                      textStyle: _commonClass.getTextStyle(
                          12, _colorClass.greyColor, CommonClass.bold)),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                      overflow: TextOverflow.visible,
                      text: "Rate",
                      textStyle: _commonClass.getTextStyle(
                          12, _colorClass.greyColor, CommonClass.bold)),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                      overflow: TextOverflow.visible,
                      text: "Total Amount",
                      textStyle: _commonClass.getTextStyle(
                          12, _colorClass.greyColor, CommonClass.bold)),
                )),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        body: const CommonWidget(),
        bottomNavigationBar: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: TextWidget(
                        overflow: TextOverflow.visible,
                        text: "Total Expense Amount:",
                        textStyle: _commonClass.getTextStyle(
                            12, _colorClass.blackColor, CommonClass.light))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextWidget(
                        overflow: TextOverflow.visible,
                        text: "",
                        textStyle: _commonClass.getTextStyle(
                            12, _colorClass.greyColor, CommonClass.medium))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextWidget(
                        overflow: TextOverflow.visible,
                        text: "",
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.greyColor, CommonClass.medium))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextWidget(
                        overflow: TextOverflow.visible,
                        text: "₹ 4",
                        textStyle: _commonClass.getTextStyle(
                            12, _colorClass.greyColor, CommonClass.medium))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommonWidget extends StatelessWidget {
  const CommonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextWidget(
                          overflow: TextOverflow.visible,
                          text: "Test",
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.blackColor, CommonClass.light))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextWidget(
                          overflow: TextOverflow.visible,
                          text: "2",
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.greyColor, CommonClass.medium))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextWidget(
                          overflow: TextOverflow.visible,
                          text: "₹ 2",
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.greyColor, CommonClass.medium))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextWidget(
                          overflow: TextOverflow.visible,
                          text: "₹ 2",
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.greyColor, CommonClass.medium))),
                ],
              ),
            ),
          );
        });
  }
}
