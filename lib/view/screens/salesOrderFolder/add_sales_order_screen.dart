import 'package:accountech/common/common_class.dart';
import 'package:accountech/view/screens/salesOrderFolder/widgets/sales_order_body_widget.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../common/color_class.dart';
import '../../../common/string_file.dart';
import '../../../controller/salesController/sales_controller.dart';
import '../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class AddSalesOrderScreen extends StatefulWidget {
  static String addSalesOrderScreenRoute = "/AddSalesOrderScreen";

  const AddSalesOrderScreen({Key? key}) : super(key: key);

  @override
  State<AddSalesOrderScreen> createState() => _AddSalesOrderScreenState();
}

final ColorClass _colorClass = ColorClass();
final StringFile _stringFile = StringFile();
final CommonClass _commonClass = CommonClass();

class _AddSalesOrderScreenState extends State<AddSalesOrderScreen> {
  var salesOrderNo = "", date1 = "", date2 = "";

  var salesController = Get.find<SalesController>();

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
                      text: "Create New Sales Order",
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
                                      return EditDateBottomSheet(
                                          onSave: (sn) {
                                            setState(() {
                                              salesOrderNo = sn;
                                            });
                                          });
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
                                      text: "Sales #${salesOrderNo.toString()}",
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
                        GetX<SalesController>(builder: (controller) {
                          return Row(
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
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (c) {
                                                  return StatefulBuilder(
                                                      builder: (context,
                                                          bottomSheetSetState) {
                                                        return BottomSheetForDateSelection(
                                                          onSave: (v) {},
                                                        );
                                                      });
                                                });
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
                                              text: controller.date.value,
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
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (c) {
                                                  return StatefulBuilder(
                                                      builder: (context,
                                                          bottomSheetSetState) {
                                                        return BottomSheetForDateSelection(
                                                          onSave: (v) {},
                                                        );
                                                      });
                                                });
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
                                              text: _stringFile.dueOn,
                                              textStyle:
                                              _commonClass.getTextStyle(
                                                  13,
                                                  _colorClass.blackColor,
                                                  CommonClass.regular)),
                                          TextWidget(
                                              text: "${controller.validityDate}",
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
                          );
                        })
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
          child: const SalesOrderBodyWidget(),
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
                  createSalesOrder();
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

  Future<void> createSalesOrder() async {
    _commonClass.showLoader(context, true);
    var response= await salesController.createSalesOrder( salesOrderNo, salesController.date.value, salesController.terms.value, salesController.validityDate.value,salesController.selectedPartyId.value , salesController.managerId.value.toString(), salesController.architectId.value.toString(), salesController.selectedPartyId.value, salesController.notes.value, salesController.terms.value, salesController.discountInPercent.value.toString(), salesController.discountInAmount.value.toString(), salesController.roundOfInPercent.value.toString(), salesController.roundOfInAmount.value.toString());
    print(response.message);
    _commonClass.showLoader(context, false);

    _commonClass.showMessage(context,
        response.message.toString());
    if(response.status==200){
      Navigator.pop(context);
    }
  }
}

class EditDateBottomSheet extends StatefulWidget {
  final Function onSave;

  const EditDateBottomSheet({Key? key, required this.onSave}) : super(key: key);

  @override
  State<EditDateBottomSheet> createState() => _EditDateBottomSheetState();
}

class _EditDateBottomSheetState extends State<EditDateBottomSheet> {

  var salesController = SalesController();
  var sOrderNo, d1, d2;
  var textController=TextEditingController();

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
                        text: "Edit Sales Order Date & Number",
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
                  GetX<SalesController>(builder: (controller) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: _colorClass.secondaryBrandColor)),
                      child: InkWell(
                        splashColor: _colorClass.bgColor,
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (c) {
                                return StatefulBuilder(
                                    builder: (context, bottomSheetSetState) {
                                      return BottomSheetForDateSelection(
                                        onSave: (v) {
                                          controller.updateDate(v);
                                        },
                                      );
                                    });
                              });
                        },
                        child: ListTile(
                          title: TextWidget(
                              text: "Sales Date ${controller.date}",
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
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  GetX<SalesController>(builder: (controller) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: _colorClass.secondaryBrandColor)),
                      child: InkWell(
                        splashColor: _colorClass.bgColor,
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (c) {
                                return StatefulBuilder(
                                    builder: (context, bottomSheetSetState) {
                                      return BottomSheetForDateSelection(
                                        onSave: (v) {
                                          controller.updateValidityDate(v);
                                        },
                                      );
                                    });
                              });
                        },
                        child: ListTile(
                          title: TextWidget(
                              text:
                              "${_stringFile.validityDate} ${controller.validityDate.value}",
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
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                      maxLength: 10,
                      type: TextInputType.number,
                      textEditingController: textController,
                      formatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      text: "Sales Order No",
                      onTypeCallBack: (e) {
                        sOrderNo=e;
                      }),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Material(
          color: _colorClass.secondaryBrandColor,
          child: InkWell(
            onTap: () {
              widget.onSave(sOrderNo);
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
  final Function(String) onSave;

  const BottomSheetForDateSelection({Key? key, required this.onSave})
      : super(key: key);

  @override
  State<BottomSheetForDateSelection> createState() =>
      _BottomSheetForDateSelectionState();
}

class _BottomSheetForDateSelectionState
    extends State<BottomSheetForDateSelection> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
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
          widget.onSave(DateFormat('dd/MM/yyyy').format(value as DateTime));
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
