import 'package:accountech/common/common_class.dart';
import 'package:accountech/view/screens/purchaseReturnFolder/widgets/purchase_return_body_widget.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../common/color_class.dart';
import '../../../common/string_file.dart';
import '../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class AddPurchaseReturnScreen extends StatefulWidget {
  static String addPurchaseReturnScreenRoute = "/AddPurchaseReturnScreen";

  const AddPurchaseReturnScreen({Key? key}) : super(key: key);

  @override
  State<AddPurchaseReturnScreen> createState() => _AddPurchaseReturnScreenState();
}

final ColorClass _colorClass = ColorClass();
final StringFile _stringFile = StringFile();
final CommonClass _commonClass = CommonClass();

class _AddPurchaseReturnScreenState extends State<AddPurchaseReturnScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize:
            const Size.fromHeight(CommonClass.headerHeight + 120),
            child: Container(
              color: _colorClass.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonAppBarWidget(
                    title: TextWidget(
                      text: _stringFile.createPurchaseReturn,
                      textStyle: _commonClass.getTextStyle(
                          20, _colorClass.blackColor, CommonClass.semiBold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Material(
                          color: _colorClass.whiteColor,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (c) {
                                    return StatefulBuilder(builder:
                                        (context, bottomSheetSetState) {
                                      return const EditDateBottomSheet();
                                    });
                                  });
                            },
                            splashColor: _colorClass.bgColor,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWidget(
                                      text: "${_stringFile.purchaseReturn} #1",
                                      textStyle: _commonClass.getTextStyle(
                                          15,
                                          _colorClass.secondaryBrandColor,
                                          CommonClass.semiBold)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.pencil,
                                    size: 15,
                                    color: _colorClass.secondaryBrandColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {

                                        },
                                        child: Icon(
                                          FontAwesomeIcons.calendar,
                                          color:
                                          _colorClass.secondaryBrandColor,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                            text: _stringFile.date,
                                            textStyle:
                                            _commonClass.getTextStyle(
                                                13,
                                                _colorClass.blackColor,
                                                CommonClass.regular)),
                                        TextWidget(
                                            text: "10 Apr 2022",
                                            textStyle:
                                            _commonClass.getTextStyle(
                                                10,
                                                _colorClass.blackColor,
                                                CommonClass.light))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
        resizeToAvoidBottomInset: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ExpandableTheme(
          data: ExpandableThemeData(
            iconColor: _colorClass.mainBrandMaterialColor,
            collapseIcon: FontAwesomeIcons.circleMinus,
            expandIcon: FontAwesomeIcons.circlePlus,
            useInkWell: true,
          ),
          child: const PurchaseReturnBodyWidget(),
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
                        text: _stringFile.totalAmount,
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

class EditDateBottomSheet extends StatefulWidget {
  const EditDateBottomSheet({Key? key}) : super(key: key);

  @override
  State<EditDateBottomSheet> createState() =>
      _EditDateBottomSheetState();
}

class _EditDateBottomSheetState
    extends State<EditDateBottomSheet> {
  final ExpandableController _prefixController = ExpandableController();

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
                        text: _stringFile.editPurchaseReturnDateAndNumber,
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.blackColor, CommonClass.medium),
                      ),
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
        body: ExpandableTheme(
          data: ExpandableThemeData(
            iconColor: _colorClass.mainBrandMaterialColor,
            collapseIcon: FontAwesomeIcons.circleMinus,
            expandIcon: FontAwesomeIcons.circlePlus,
            useInkWell: true,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                        Border.all(color: _colorClass.secondaryBrandColor)),
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
                            text: "${_stringFile.purchaseReturnDate} (8 march 2022)",
                            textStyle: _commonClass.getTextStyle(
                                12,
                                _colorClass.secondaryBrandColor,
                                CommonClass.medium)),
                        trailing: Icon(
                          FontAwesomeIcons.calendar,
                          color: _colorClass.secondaryBrandColor,
                        ),
                      ),
                    ),
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
                      text: _stringFile.purchaseReturnNumber,
                      onTypeCallBack: (e) {}),
                  ExpandableNotifier(
                      child: ScrollOnExpand(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ExpandablePanel(
                              controller: _prefixController,
                              theme: const ExpandableThemeData(
                                headerAlignment:
                                ExpandablePanelHeaderAlignment.center,
                                hasIcon: true,
                              ),
                              header: Container(
                                color: _colorClass.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 17, horizontal: 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: TextWidget(
                                            text: _stringFile.prefixEX,
                                            textStyle: _commonClass.getTextStyle(
                                                15,
                                                _colorClass.blackColor,
                                                CommonClass.medium),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              collapsed: Container(),
                              expanded: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFieldWidget(
                                                maxLength: null,
                                                type: TextInputType.text,
                                                formatter: null,
                                                text: _stringFile.prefix,
                                                onTypeCallBack: (e) {}),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: TextFieldWidget(
                                                maxLength: null,
                                                type: TextInputType.text,
                                                formatter: null,
                                                text: _stringFile
                                                    .startingSerialNumber,
                                                onTypeCallBack: (e) {}),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Material(
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
