import 'package:accountech/model/goodsInTransit/goods_in_transit_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';

import '../../common/color_class.dart';
import '../../common/common_class.dart';
import '../../common/string_file.dart';
import '../textWidgets/text_widget.dart';
import 'delete_dialog.dart';

final ColorClass _colorClass = ColorClass();
final CommonClass _commonClass = CommonClass();
final StringFile _stringFile = StringFile();

class PurchaseListItem extends StatelessWidget {
  final String label;
  final Data item;
  final Function onDelete;
  final Function onEdit;
  const PurchaseListItem({Key? key,required this.label, required this.item, required this.onDelete, required this.onEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        key: GlobalKey(),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            showModalBottomSheet(
                context: context,
                builder: (c) {
                  return StatefulBuilder(builder:
                      (context, bottomSheetSetState) {
                    return DeleteDialog(onDelete: (){
                      onDelete();
                    },);
                  });
                });
          }),
          children: [
            SlidableAction(
              onPressed: (e) {
                onEdit();
              },
              backgroundColor:
              _colorClass.secondaryBrandColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
            ),
            SlidableAction(
              onPressed: (e) {
                showModalBottomSheet(
                    context: context,
                    builder: (c) {
                      return StatefulBuilder(builder:
                          (context, bottomSheetSetState) {
                        return DeleteDialog(onDelete: (){
                          onDelete();
                        },);
                      });
                    });
              },
              backgroundColor: _colorClass.redColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Material(
          color: _colorClass.whiteColor,
          child: InkWell(
            splashColor: _colorClass.bgColor,
            onTap: () {
              // Navigator.pushNamed(
              //     context,
              //     DetailItemCashBankScreen
              //         .detailItemCashBankRoute);
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: _colorClass
                            .secondaryBrandColor),
                  ),
                  width: _commonClass
                      .getScreenWidth(context),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                            overflow:
                            TextOverflow.visible,
                            text:
                            "date",
                            textStyle:
                            _commonClass.getTextStyle(
                                12,
                                _colorClass
                                    .blackColor,
                                CommonClass.regular)),
                        const SizedBox(
                          height: 10,
                        ),
                        TextWidget(
                            overflow:
                            TextOverflow.visible,
                            text: "Party Name : ${item.partyName}",//${controller.cashInHandList[index]} ",
                            textStyle:
                            _commonClass.getTextStyle(
                                14,
                                _colorClass
                                    .blackColor,
                                CommonClass
                                    .semiBold)),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .center,
                              children: [
                                TextWidget(
                                    text: "$label no"
                                        .toUpperCase(),
                                    textStyle: _commonClass
                                        .getTextStyle(
                                        15,
                                        _colorClass
                                            .blackColor,
                                        CommonClass
                                            .semiBold)),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextWidget(
                                    text:
                                    "${item.goodsInTransitNo}",
                                    textStyle: _commonClass
                                        .getTextStyle(
                                        12,
                                        _colorClass
                                            .blackColor,
                                        CommonClass
                                            .regular)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .center,
                              children: [
                                TextWidget(
                                    text: _stringFile
                                        .dueOn
                                        .toUpperCase(),
                                    textStyle: _commonClass
                                        .getTextStyle(
                                        15,
                                        _colorClass
                                            .blackColor,
                                        CommonClass
                                            .semiBold)),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextWidget(
                                    text: "${item.dueIn}",
                                    textStyle: _commonClass
                                        .getTextStyle(
                                        12,
                                        _colorClass
                                            .blackColor,
                                        CommonClass
                                            .regular)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .center,
                              children: [
                                TextWidget(
                                    text: _stringFile.amount
                                        .toUpperCase(),
                                    textStyle: _commonClass
                                        .getTextStyle(
                                        15,
                                        _colorClass
                                            .blackColor,
                                        CommonClass
                                            .semiBold)),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextWidget(
                                    text: "₹ ${item.amount}",
                                    textStyle: _commonClass
                                        .getTextStyle(
                                        12,
                                        _colorClass
                                            .blackColor,
                                        CommonClass
                                            .regular)),
                              ],
                            ),
                          ],
                        ),

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
            ),
          ),
        ),
      ),
    );
  }
}
