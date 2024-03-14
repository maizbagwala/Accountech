import 'package:accountech/controller/expenseController/expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../common/color_class.dart';
import '../../../../common/common_class.dart';
import '../../../../widgets/textWidgets/text_widget.dart';
import 'package:accountech/model/expenseModel/expenses_individual_list_model.dart';

class CashBankItemWidget extends StatefulWidget {

  final Data expensesIndividual;

  const CashBankItemWidget( {Key? key,required this .expensesIndividual}) : super(key: key);

  @override
  State<CashBankItemWidget> createState() => _CashBankItemWidgetState();
}

final ColorClass _colorClass = ColorClass();
final CommonClass _commonClass = CommonClass();

class _CashBankItemWidgetState extends State<CashBankItemWidget> {

  @override
  void initState() {


    super.initState();




  }
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
        body:  widget.expensesIndividual==null?Container(): CommonWidget( widget.expensesIndividual!),
        bottomNavigationBar:  widget.expensesIndividual==null?Container(): Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
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
                        text: "₹ ${ widget.expensesIndividual!.eAmount}",
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
  final Data expensesIndividual;
  const CommonWidget(this.expensesIndividual, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: expensesIndividual.item?.length,
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
                          text:  expensesIndividual.item![index].name!,
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.blackColor, CommonClass.light))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextWidget(
                          overflow: TextOverflow.visible,
                          text: expensesIndividual.item![index].qty.toString(),
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.greyColor, CommonClass.medium))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextWidget(
                          overflow: TextOverflow.visible,
                          text: "₹ ${expensesIndividual.item![index].rate}",
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.greyColor, CommonClass.medium))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextWidget(
                          overflow: TextOverflow.visible,
                          text: "₹ ${expensesIndividual.item![index].amount}",
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.greyColor, CommonClass.medium))),
                  const SizedBox(
                    width: 10,
                  ),
                  // Card(
                  //   color: _colorClass.greenColor,
                  //   child: InkWell(
                  //     onTap: () {
                  //       showModalBottomSheet(
                  //           context: context,
                  //           builder: (c) {
                  //             return StatefulBuilder(
                  //                 builder: (context, bottomSheetSetState) {
                  //                   return const QRCodeBottomSheet();
                  //                 });
                  //           });
                  //     },
                  //     splashColor: _colorClass.greyColor.withAlpha(10),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: SizedBox(
                  //         height: 15,
                  //         child: TextWidget(
                  //             text: "View",
                  //             textStyle: _commonClass.getTextStyle(13,
                  //                 _colorClass.whiteColor, CommonClass.medium)),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        });
  }
}



class QRCodeBottomSheet extends StatefulWidget {
  const QRCodeBottomSheet({Key? key}) : super(key: key);

  @override
  State<QRCodeBottomSheet> createState() => _QRCodeBottomSheetState();
}

class _QRCodeBottomSheetState extends State<QRCodeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                          text:"Uploaded Documents",
                          textStyle: _commonClass.getTextStyle(
                              15, _colorClass.blackColor, CommonClass.bold)),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        splashColor: _colorClass.bgColor,
                        child: const Icon(FontAwesomeIcons.xmark))
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: _colorClass.bgColor,
                thickness: 1,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: double.infinity,
                    child: Column(
                      children: [

                        Image.asset(
                          _commonClass.demoInvoice,
                          height: 350,
                          width: double.infinity,
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Expanded(
                  child: Material(
                      color: _colorClass.whiteColor,
                      child: InkWell(
                          onTap: () {},
                          splashColor: _colorClass.bgColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              FontAwesomeIcons.shareNodes,
                              color: _colorClass.secondaryBrandColor,
                            ),
                          ))),
                ),
                Expanded(
                  child: Material(
                      color: _colorClass.whiteColor,
                      child: InkWell(
                          onTap: () {},
                          splashColor: _colorClass.bgColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              FontAwesomeIcons.print,
                              color: _colorClass.secondaryBrandColor,
                            ),
                          ))),
                ),
                Expanded(
                  child: Material(
                      color: _colorClass.whiteColor,
                      child: InkWell(
                          onTap: () {},
                          splashColor: _colorClass.bgColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              FontAwesomeIcons.download,
                              color: _colorClass.secondaryBrandColor,
                            ),
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
