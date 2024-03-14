import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/view/screens/cashAndBankFolder/widgets/cash_bank_item_widget.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:flutter/material.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class DetailItemCashBankScreen extends StatefulWidget {
  static String detailItemCashBankRoute = "/DetailItemCashBankScreen";


  const DetailItemCashBankScreen(  {Key? key}) : super(key: key);

  @override
  State<DetailItemCashBankScreen> createState() => _DetailItemCashBankScreenState();
}

final ColorClass _colorClass = ColorClass();
final CommonClass _commonClass = CommonClass();
final StringFile _stringFile = StringFile();

class _DetailItemCashBankScreenState extends State<DetailItemCashBankScreen>  {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(CommonClass.headerHeight + 110),
        child: AppBarWidget(),
      ),
      body: Container(
        color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
        height: _commonClass.getScreenHeight(context),
        // child:            CashBankItemWidget(),

        child:           Container(),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonAppBarWidget(
          title: TextWidget(
    text: "Payment Details",
        textStyle: _commonClass.getTextStyle(
            20, _colorClass.blackColor, CommonClass.semiBold)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Card(
                color: _colorClass.greenColor,
                child: InkWell(
                  onTap: () {},
                  splashColor: _colorClass.greyColor.withAlpha(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 15,
                      child: TextWidget(
                          text: _stringFile.edit,
                          textStyle: _commonClass.getTextStyle(
                              13, _colorClass.whiteColor, CommonClass.medium)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: _colorClass.redColor,
                child: InkWell(
                  onTap: () {},
                  splashColor: _colorClass.greyColor.withAlpha(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 15,
                      child: TextWidget(
                          text: _stringFile.delete,
                          textStyle: _commonClass.getTextStyle(
                              13, _colorClass.whiteColor, CommonClass.medium)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const AppBarBelowDataWidget()
      ],
    );
  }
}

class AppBarBelowDataWidget extends StatefulWidget {
  const AppBarBelowDataWidget({Key? key}) : super(key: key);

  @override
  State<AppBarBelowDataWidget> createState() => _AppBarBelowDataWidgetState();
}

class _AppBarBelowDataWidgetState extends State<AppBarBelowDataWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: _commonClass.getScreenWidth(context),
        child: Column(
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
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                    text: "Expense Category",
                                    textStyle: _commonClass.getTextStyle(
                                        11,
                                        _colorClass.blackColor,
                                        CommonClass.medium)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                    text: "Transportation & Travel Expense",
                                    textStyle: _commonClass.getTextStyle(
                                        10,
                                        _colorClass.blackColor,
                                        CommonClass.light)),
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
                                    text: "Payment Mode",
                                    textStyle: _commonClass.getTextStyle(
                                        11,
                                        _colorClass.blackColor,
                                        CommonClass.medium)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                    text: "Cash",
                                    textStyle: _commonClass.getTextStyle(
                                        10,
                                        _colorClass.blackColor,
                                        CommonClass.light)),
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
                                    text:"Date",
                                    textStyle: _commonClass.getTextStyle(
                                        11,
                                        _colorClass.blackColor,
                                        CommonClass.medium)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                    text: "28-04-2022",
                                    textStyle: _commonClass.getTextStyle(
                                        10,
                                        _colorClass.blackColor,
                                        CommonClass.light)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                              text:"Note",
                              textStyle: _commonClass.getTextStyle(
                                  11,
                                  _colorClass.blackColor,
                                  CommonClass.medium)),
                          const SizedBox(
                            height: 10,
                          ),
                          TextWidget(
                              text: "-",
                              textStyle: _commonClass.getTextStyle(
                                  10,
                                  _colorClass.blackColor,
                                  CommonClass.light)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ));
  }
}
