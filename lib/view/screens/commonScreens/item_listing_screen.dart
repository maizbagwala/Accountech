import 'package:accountech/common/common_class.dart';
import 'package:accountech/widgets/textFieldWidgets/normal_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../common/color_class.dart';
import '../../../common/string_file.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class ItemListingScreen extends StatefulWidget {
  static String itemListingScreenRoute = "/ItemListingScreen";

  const ItemListingScreen({Key? key}) : super(key: key);

  @override
  State<ItemListingScreen> createState() => _ItemListingScreenState();
}

final ColorClass _colorClass = ColorClass();
final StringFile _stringFile = StringFile();
final CommonClass _commonClass = CommonClass();

class _ItemListingScreenState extends State<ItemListingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(CommonClass.headerHeight + 76),
            child: Container(
              color: _colorClass.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Material(
                        color: _colorClass.whiteColor,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          customBorder: const CircleBorder(),
                          splashColor: _colorClass.bgColor,
                          child: Icon(
                            FontAwesomeIcons.arrowLeftLong,
                            color: _colorClass.secondaryBrandColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 10, right: 20, top: 5, bottom: 5),
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: _colorClass.secondaryBrandColor)),
                          child: ListTile(
                            horizontalTitleGap: 0,
                            leading: Icon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: 20,
                              color: _colorClass.secondaryBrandColor,
                            ),
                            title: NormalTextFieldWidget(
                                maxLength: null,
                                type: TextInputType.text,
                                formatter: null,
                                text: _stringFile.searchByNameOrCode,
                                onTypeCallBack: (e) {
                                  setState(() {});
                                }),
                            trailing: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Image.asset(
                                  _commonClass.barcodeScanner,
                                  width: 30,
                                  height: 30,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: _colorClass.bgColor,
                  ),
                  Container(
                    width: _commonClass.getScreenWidth(context),
                    color: _colorClass.whiteColor,
                    height: 50,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _colorClass.bgColor,
                            ),
                            child: Row(
                              children: [
                                TextWidget(
                                  text: _stringFile.allCategories,
                                  textStyle: _commonClass.getTextStyle(
                                      12,
                                      _colorClass.blackColor,
                                      CommonClass.medium),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  FontAwesomeIcons.angleDown,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _colorClass.bgColor,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.plus,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextWidget(
                                  text: _stringFile.createNewItem,
                                  textStyle: _commonClass.getTextStyle(
                                      12,
                                      _colorClass.blackColor,
                                      CommonClass.medium),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          height: _commonClass.getScreenHeight(context),
          width: _commonClass.getScreenWidth(context),
          color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: _commonClass.getScreenWidth(context),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextWidget(
                                    text: "Baby Cheramy Cologne 100 ML",
                                    textStyle: _commonClass.getTextStyle(
                                        14,
                                        _colorClass.blackColor,
                                        CommonClass.semiBold)),
                              ),
                              Icon(
                                FontAwesomeIcons.solidPenToSquare,
                                color: _colorClass.secondaryBrandColor,
                                size: 20,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Table(
                          //   defaultVerticalAlignment:
                          //       TableCellVerticalAlignment.middle,
                          //   border: TableBorder.all(
                          //       color: _colorClass.secondaryBrandColor,
                          //       style: BorderStyle.none,
                          //       width: 1),
                          //   children: [
                          //     TableRow(children: [
                          //       Container(
                          //         child: Column(children: [
                          //           Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: TextWidget(
                          //                 text: "STOCK",
                          //                 textStyle: _commonClass.getTextStyle(
                          //                     12,
                          //                     _colorClass.redColor,
                          //                     CommonClass.semiBold)),
                          //           ),
                          //         ]),
                          //         color: _colorClass.redColor.withAlpha(100),
                          //       ),
                          //       Container(
                          //         color: _colorClass.redColor.withAlpha(100),
                          //         child: Column(children: [
                          //           Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: TextWidget(
                          //                 text: "-2PCS",
                          //                 textStyle: _commonClass.getTextStyle(
                          //                     12,
                          //                     _colorClass.redColor,
                          //                     CommonClass.regular)),
                          //           ),
                          //         ]),
                          //       ),
                          //     ]),
                          //
                          //     TableRow(children: [
                          //       Container(
                          //         color: _colorClass.bgColor.withAlpha(100),
                          //         child: Column(
                          //           children: [
                          //             Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: TextWidget(
                          //                   text: "MRP",
                          //                   textStyle:
                          //                       _commonClass.getTextStyle(
                          //                           12,
                          //                           _colorClass.blackColor,
                          //                           CommonClass.semiBold)),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       Container(
                          //         color: _colorClass.bgColor.withAlpha(100),
                          //         child: Column(
                          //           children: [
                          //             Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: TextWidget(
                          //                   text: "₹ 265",
                          //                   textStyle:
                          //                       _commonClass.getTextStyle(
                          //                           12,
                          //                           _colorClass.blackColor,
                          //                           CommonClass.regular)),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ]),
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextWidget(
                                      text: _stringFile.mrp,
                                      textStyle: _commonClass.getTextStyle(
                                          15,
                                          _colorClass.blackColor,
                                          CommonClass.semiBold)),
                                  const SizedBox(height: 5,),
                                  TextWidget(
                                      text: "₹ 265/PCS",
                                      textStyle: _commonClass.getTextStyle(
                                          12,
                                          _colorClass.blackColor,
                                          CommonClass.regular)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextWidget(
                                      text: _stringFile.stock,
                                      textStyle: _commonClass.getTextStyle(
                                          15,
                                          _colorClass.blackColor,
                                          CommonClass.semiBold)),
                                  const SizedBox(height: 5,),

                                  TextWidget(
                                      text: "-2PCS",
                                      textStyle: _commonClass.getTextStyle(
                                          12,
                                          _colorClass.redColor,
                                          CommonClass.regular)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [

                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: _colorClass.greyColor.withAlpha(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                        overflow: TextOverflow.visible,
                        text: "2 Items",
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.blackColor, CommonClass.semiBold),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextWidget(
                          overflow: TextOverflow.visible,
                          text: "₹ 123456",
                          textStyle: _commonClass.getTextStyle(
                              15, _colorClass.blackColor, CommonClass.semiBold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Material(
              color: _colorClass.secondaryBrandColor,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                splashColor: _colorClass.bgColor,
                child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextWidget(
                        text: _stringFile.save,
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.whiteColor, CommonClass.bold))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSheetForDateSelection extends StatefulWidget {
  const BottomSheetForDateSelection({Key? key}) : super(key: key);

  @override
  State<BottomSheetForDateSelection> createState() =>
      _BottomSheetForDateSelectionState();
}

class _BottomSheetForDateSelectionState
    extends State<BottomSheetForDateSelection> {
  // String _selectedDate = '';
  // String _dateCount = '';
  // String _range = '';
  // String _rangeCount = '';

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      // if (args.value is PickerDateRange) {
      //   _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
      //       ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      // } else if (args.value is DateTime) {
      //   _selectedDate = args.value.toString();
      // } else if (args.value is List<DateTime>) {
      //   _dateCount = args.value.length.toString();
      // } else {
      //   _rangeCount = args.value.length.toString();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SfDateRangePicker(
        onCancel: () {
          Navigator.pop(context);
        },
        onSubmit: (value) {
          Navigator.pop(context);
        },
        backgroundColor:
            _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
        onSelectionChanged: _onSelectionChanged,
        selectionMode: DateRangePickerSelectionMode.single,
        selectionColor: _colorClass.mainBrandColor,
        showTodayButton: false,
        showActionButtons: true,
        initialSelectedRange: null,
      ),
    );
  }
}
