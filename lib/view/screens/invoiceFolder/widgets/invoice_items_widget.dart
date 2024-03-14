import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common/color_class.dart';
import '../../../../../common/common_class.dart';
import '../../../../../common/string_file.dart';
import '../../../../../widgets/textWidgets/text_widget.dart';
import '../../commonScreens/item_listing_screen.dart';

class InvoiceItemsWidget extends StatefulWidget {
  const InvoiceItemsWidget({Key? key}) : super(key: key);

  @override
  State<InvoiceItemsWidget> createState() => _InvoiceItemsWidgetState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();
final StringFile _stringFile = StringFile();

class _InvoiceItemsWidgetState extends State<InvoiceItemsWidget> {
  final List<int> _itemList = [1, 2, 3, 4, 5, 6];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _commonClass.getScreenWidth(context),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                  text: "${_stringFile.items} (${_itemList.length})",
                  textStyle: _commonClass.getTextStyle(
                      15, _colorClass.blackColor, CommonClass.bold)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: _commonClass.getScreenWidth(context),
                child: Material(
                  color: _colorClass.secondaryBrandColor,
                  child: InkWell(
                    splashColor: _colorClass.whiteColor,
                    onTap: () {
                      Navigator.pushNamed(
                          context, ItemListingScreen.itemListingScreenRoute);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 10),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.box,
                            color: _colorClass.whiteColor,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextWidget(
                                overflow: TextOverflow.visible,
                                text: _stringFile.addItems,
                                textStyle: _commonClass.getTextStyle(
                                    12,
                                    _colorClass.whiteColor,
                                    CommonClass.medium)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _itemList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Slidable(
                        key: GlobalKey(),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          dismissible: DismissiblePane(onDismissed: () {
                            setState(() {
                              _itemList.removeAt(index);
                            });
                          }),
                          children: [
                            SlidableAction(
                              onPressed: (e) {},
                              backgroundColor: _colorClass.secondaryBrandColor,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: _stringFile.edit,
                            ),
                            SlidableAction(
                              onPressed: (e) {
                                setState(() {
                                  _itemList.removeAt(index);
                                });
                              },
                              backgroundColor: _colorClass.redColor,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: _stringFile.delete,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: _colorClass.secondaryBrandColor)),
                              width: _commonClass.getScreenWidth(context),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                        overflow: TextOverflow.visible,
                                        text: "Baby Cheramy Cologne 100 ML",
                                        textStyle: _commonClass.getTextStyle(
                                            14,
                                            _colorClass.blackColor,
                                            CommonClass.semiBold)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TextWidget(
                                                text: _stringFile.batchQTY,
                                                textStyle:
                                                    _commonClass.getTextStyle(
                                                        15,
                                                        _colorClass.blackColor,
                                                        CommonClass.semiBold)),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextWidget(
                                                text: "1.0",
                                                textStyle:
                                                    _commonClass.getTextStyle(
                                                        12,
                                                        _colorClass.blackColor,
                                                        CommonClass.regular)),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TextWidget(
                                                text: _stringFile.price,
                                                textStyle:
                                                    _commonClass.getTextStyle(
                                                        15,
                                                        _colorClass.blackColor,
                                                        CommonClass.semiBold)),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextWidget(
                                                text: "₹ 265",
                                                textStyle:
                                                    _commonClass.getTextStyle(
                                                        12,
                                                        _colorClass.blackColor,
                                                        CommonClass.regular)),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TextWidget(
                                                text: _stringFile.amount,
                                                textStyle:
                                                    _commonClass.getTextStyle(
                                                        15,
                                                        _colorClass.blackColor,
                                                        CommonClass.semiBold)),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextWidget(
                                                text: "₹ 265",
                                                textStyle:
                                                    _commonClass.getTextStyle(
                                                        12,
                                                        _colorClass.blackColor,
                                                        CommonClass.regular)),
                                          ],
                                        ),
                                      ],
                                    )
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
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
