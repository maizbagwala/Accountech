import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../common/color_class.dart';
import '../../../../common/common_class.dart';
import '../../../../common/string_file.dart';
import '../../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../../widgets/textWidgets/text_widget.dart';
import 'item_stock_remark_widget.dart';

class ItemTimeLineWidget extends StatefulWidget {
  const ItemTimeLineWidget({Key? key}) : super(key: key);

  @override
  State<ItemTimeLineWidget> createState() => _ItemTimeLineWidgetState();
}

final ColorClass _colorClass = ColorClass();
final CommonClass _commonClass = CommonClass();
final StringFile _stringFile = StringFile();

class _ItemTimeLineWidgetState extends State<ItemTimeLineWidget> {
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
                      text: _stringFile.activity,
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
                      text: _stringFile.change,
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
                      text: _stringFile.finalStock,
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
        bottomNavigationBar: SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                  child: Material(
                    color: _colorClass.mainBrandColor,
                    child: InkWell(
                      splashColor: _colorClass.bgColor,
                onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (c) {
                          return StatefulBuilder(
                              builder: (context, bottomSheetSetState) {
                            return const BottomSheetForAppendStock();
                          });
                        });
                },
                child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),

                      child: TextWidget(
                          text: _stringFile.appendStock,
                          textStyle: _commonClass.getTextStyle(
                              15, _colorClass.whiteColor, CommonClass.bold))),
              ),
                  )),
              Expanded(
                  child: Material(
                    color: _colorClass.secondaryBrandColor,
                    child: InkWell(
                      splashColor: _colorClass.bgColor,
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (c) {
                              return StatefulBuilder(
                                  builder: (context, bottomSheetSetState) {
                                return const BottomSheetForReduceStock();
                              });
                            });
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),

                          child: TextWidget(
                              text: _stringFile.decreaseStock,
                              textStyle: _commonClass.getTextStyle(
                                  15, _colorClass.whiteColor, CommonClass.bold))),
                    ),
                  )),
            ],
          ),
        ),
        body: const ItemTimelineWidget(),
      ),
    );
  }
}

class ItemTimelineWidget extends StatelessWidget {
  const ItemTimelineWidget({Key? key}) : super(key: key);

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
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                          overflow: TextOverflow.visible,
                          text: _stringFile.appendStock,
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.greenColor, CommonClass.medium)),
                      TextWidget(
                          overflow: TextOverflow.visible,
                          text: "07 Apr 2022",
                          textStyle: _commonClass.getTextStyle(
                              8, _colorClass.greyColor, CommonClass.light)),
                    ],
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextWidget(
                          overflow: TextOverflow.visible,
                          text: "25.0 (PCS)",
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.greyColor, CommonClass.medium))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextWidget(
                          overflow: TextOverflow.visible,
                          text: "25.0 (PCS)",
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.greyColor, CommonClass.medium))),
                ],
              ),
            ),
          );
        });
  }
}

class BottomSheetForAppendStock extends StatefulWidget {
  const BottomSheetForAppendStock({Key? key}) : super(key: key);

  @override
  State<BottomSheetForAppendStock> createState() =>
      _BottomSheetForAppendStockState();
}

class _BottomSheetForAppendStockState extends State<BottomSheetForAppendStock> {
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
                          text: _stringFile.appendStock,
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
                TextWidget(
                    text: _stringFile.date,
                    textStyle: _commonClass.getTextStyle(
                        14, _colorClass.blackColor, CommonClass.semiBold)),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: _colorClass.secondaryBrandColor)),
                  child: InkWell(
                    splashColor: _colorClass.bgColor,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (c) {
                            return StatefulBuilder(
                                builder: (context, bottomSheetSetState) {
                              return const BottomSheetForDateSelection();
                            });
                          });
                    },
                    child: ListTile(
                      title: TextWidget(
                          text: "08 Apr 2022",
                          textStyle: _commonClass.getTextStyle(
                              12,
                              _colorClass.secondaryBrandColor,
                              CommonClass.medium)),
                      trailing: Icon(
                        FontAwesomeIcons.angleDown,
                        color: _colorClass.secondaryBrandColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                          text: _stringFile.currentStock,
                          textStyle: _commonClass.getTextStyle(
                              14, _colorClass.greyColor, CommonClass.semiBold)),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextWidget(
                            text: "25.0 (PCS)",
                            textStyle: _commonClass.getTextStyle(
                                12, _colorClass.greenColor, CommonClass.medium)),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                    maxLength: 10,
                    type: TextInputType.number,
                    formatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    text: _stringFile.enterQuantityToAdd,
                    onTypeCallBack: (e) {}),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                          text: _stringFile.updatedStock,
                          textStyle: _commonClass.getTextStyle(
                              14,
                              _colorClass.secondaryBrandColor,
                              CommonClass.semiBold)),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextWidget(
                            text: "25.0 (PCS)",
                            textStyle: _commonClass.getTextStyle(
                                12, _colorClass.greenColor, CommonClass.medium)),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const ItemStockRemarkWidget(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Material(
          color: _colorClass.mainBrandColor,
          child: InkWell(
            onTap: (){
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
      ),
    );
  }
}

class BottomSheetForReduceStock extends StatefulWidget {
  const BottomSheetForReduceStock({Key? key}) : super(key: key);

  @override
  State<BottomSheetForReduceStock> createState() =>
      _BottomSheetForReduceStockState();
}

class _BottomSheetForReduceStockState extends State<BottomSheetForReduceStock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        text: _stringFile.appendStock,
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
              TextWidget(
                  text: _stringFile.date,
                  textStyle: _commonClass.getTextStyle(
                      14, _colorClass.blackColor, CommonClass.semiBold)),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: _colorClass.secondaryBrandColor)),
                child: InkWell(
                  splashColor: _colorClass.bgColor,
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (c) {
                          return StatefulBuilder(
                              builder: (context, bottomSheetSetState) {
                            return const BottomSheetForDateSelection();
                          });
                        });
                  },
                  child: ListTile(
                    title: TextWidget(
                        text: "08 Apr 2022",
                        textStyle: _commonClass.getTextStyle(
                            12,
                            _colorClass.secondaryBrandColor,
                            CommonClass.medium)),
                    trailing: Icon(
                      FontAwesomeIcons.angleDown,
                      color: _colorClass.secondaryBrandColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextWidget(
                        text: _stringFile.currentStock,
                        textStyle: _commonClass.getTextStyle(
                            14, _colorClass.greyColor, CommonClass.semiBold)),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextWidget(
                          text: "25.0 (PCS)",
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.greenColor, CommonClass.medium)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                  maxLength: 10,
                  type: TextInputType.number,
                  formatter: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  text: _stringFile.enterQuantityToReduce,
                  onTypeCallBack: (e) {}),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextWidget(
                        text: _stringFile.updatedStock,
                        textStyle: _commonClass.getTextStyle(
                            14,
                            _colorClass.secondaryBrandColor,
                            CommonClass.semiBold)),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextWidget(
                          text: "25.0 (PCS)",
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.greenColor, CommonClass.medium)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const ItemStockRemarkWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Material(
        color: _colorClass.mainBrandColor,

        child: InkWell(
          onTap: (){
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
