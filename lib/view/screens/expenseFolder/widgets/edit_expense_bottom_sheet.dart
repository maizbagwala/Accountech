import 'dart:io';

import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/controller/expenseController/expense_controller.dart';
import 'package:accountech/controller/partyController/party_controller.dart';
import 'package:accountech/model/expenseModel/expense_item_model.dart';
import 'package:accountech/model/partyModels/party_list_model.dart';
import 'package:accountech/widgets/commonWidget/common_date_picker.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../../widgets/textFieldWidgets/normal_text_field_widget.dart';
import '../../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../../widgets/textWidgets/text_widget.dart';
import '../../commonScreens/item_listing_screen.dart';
import 'package:accountech/model/expenseModel/expenses_individual_list_model.dart';

class EditExpenseBottomSheet extends StatefulWidget {
  final List<String> expenseCategories;
  final List<int> expenseCategoriesIDs;
  final Data expensesIndividual;
  final StateSetter bottomSheetSetState;

  const EditExpenseBottomSheet(
      {Key? key,
      required this.expenseCategories,
      required this.expenseCategoriesIDs,
      required this.expensesIndividual,
      required this.bottomSheetSetState})
      : super(key: key);

  @override
  State<EditExpenseBottomSheet> createState() => _EditExpenseBottomSheetState();
}

class _EditExpenseBottomSheetState extends State<EditExpenseBottomSheet> {
  final StringFile _stringFile = StringFile();
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();
  final PartyController _partyController = PartyController();
  final TextEditingController _expenseNumberController =
      TextEditingController();
  Datum? _selectedParty;
  List<ExpenseItemModel> _expenseListItemModel = [];

  TextEditingController _allItemTotalController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  CroppedFile? _documentCroppedFile;
  String _eDocURL='';

  String _date = "";
  ExpenseController _expenseController = ExpenseController();
  String _selectedCategory = "";
  String _paymentMode = "";

  @override
  void initState() {
    super.initState();

    _selectedParty = Datum(
        id: widget.expensesIndividual.partyId!,
        name: widget.expensesIndividual.partyName!,
        email: '',
        mobileNo: widget.expensesIndividual.partyNo!,
        gstNo: '',
        partyType: '',
        partyClass: '',
        openingBalance: 0,
        billingAddress: '');

    _selectedCategory=widget.expensesIndividual.category.toString();
    _paymentMode=widget.expensesIndividual.paymentMode.toString().toUpperCase();
    _expenseNumberController.text=widget.expensesIndividual.expenseNo!.toUpperCase();
    _date=widget.expensesIndividual.date.toString();
    _notesController.text=widget.expensesIndividual.eNotes.toString();


    _eDocURL=widget.expensesIndividual.eDocument!;


    for(int i=0;i<widget.expensesIndividual.item!.length;i++)
      {


        _expenseListItemModel.insert(i,ExpenseItemModel());
        _expenseListItemModel[i].itemName.text=widget.expensesIndividual.item![i].name!;
        _expenseListItemModel[i].itemQTY.text=widget.expensesIndividual.item![i].qty.toString();
        _expenseListItemModel[i].itemRate.text=widget.expensesIndividual.item![i].rate.toString();
        _expenseListItemModel[i].itemTotal.text=(widget.expensesIndividual.item![i].qty!  * widget.expensesIndividual.item![i].rate!).toString();



      }

  }

  String _search = "";

  @override
  Widget build(BuildContext context) {

    if (_expenseListItemModel.isNotEmpty) {
      calculateTotal();
    }
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(CommonClass.headerHeight + 62),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                          text: "Create Expense",
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
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: _commonClass.getScreenWidth(context),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: _colorClass.secondaryBrandColor)),
                          child: Column(
                            children: [
                              ListTile(
                                horizontalTitleGap: 0,
                                leading: Icon(
                                  FontAwesomeIcons.user,
                                  size: 20,
                                  color: _colorClass.secondaryBrandColor,
                                ),
                                title: NormalTextFieldWidget(
                                    maxLength: null,
                                    type: TextInputType.text,
                                    formatter: null,
                                    text: _stringFile.searchCreateParty,
                                    onTypeCallBack: (e) {
                                      widget.bottomSheetSetState(() {
                                        _search = e;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ),
                        _search.isEmpty
                            ? Container(
                                height: 10,
                              )
                            : FutureBuilder<dynamic>(
                                future: _partyController.searchParty(_search),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return TextWidget(
                                        text:
                                            "There is an error please try again...",
                                        textStyle: _commonClass.getTextStyle(
                                            15,
                                            _colorClass.blackColor,
                                            CommonClass.semiBold));
                                  } else if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Lottie.asset(
                                            _commonClass.myLoader,
                                            fit: BoxFit.cover),
                                      ),
                                    );
                                  } else {
                                    dynamic value = snapshot.data;

                                    if (value.status != null) {
                                      if (value.status == 200 &&
                                          value.data != null) {
                                        List<Datum> partList =
                                            value.data as List<Datum>;
                                        return ListView.separated(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            separatorBuilder: (context, index) {
                                              return Divider(
                                                color: _colorClass.bgColor,
                                                thickness: 2,
                                              );
                                            },
                                            itemCount: partList.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  widget
                                                      .bottomSheetSetState(() {
                                                    _selectedParty =
                                                        partList[index];
                                                    _search = "";
                                                  });
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextWidget(
                                                        text: _stringFile
                                                            .partyName,
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                15,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .bold)),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    TextWidget(
                                                        text: StringUtils
                                                            .capitalize(
                                                                partList[index]
                                                                    .name),
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                12,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .regular)),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextWidget(
                                                        text: "phone Number"
                                                            .toUpperCase(),
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                15,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .bold)),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    TextWidget(
                                                        text: partList[index]
                                                            .mobileNo
                                                            .toString(),
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                12,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .regular)),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextWidget(
                                                        text: "GSTIN"
                                                            .toUpperCase(),
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                15,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .bold)),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    TextWidget(
                                                        text: partList[index]
                                                            .gstNo
                                                            .toString(),
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                12,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .regular)),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextWidget(
                                                        text: "ADDRESS"
                                                            .toUpperCase(),
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                15,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .bold)),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    TextWidget(
                                                        text: partList[index]
                                                            .billingAddress
                                                            .toString(),
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                12,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .regular)),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextWidget(
                                                        text:
                                                            "Current Party Balance"
                                                                .toUpperCase(),
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                15,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .bold)),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    TextWidget(
                                                        text:
                                                            "₹${partList[index].openingBalance.toString()}",
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                12,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .regular)),
                                                  ],
                                                ),
                                              );
                                            });
                                      }
                                    }
                                    return Container();
                                  }
                                },
                              ),
                        _selectedParty != null
                            ? Card(
                                color: _colorClass.bgColor,
                                child: Container(
                                  width: _commonClass.getScreenWidth(context),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextWidget(
                                          text: _stringFile.partyName,
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.blackColor,
                                              CommonClass.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextWidget(
                                          text: StringUtils.capitalize(
                                              _selectedParty!.name),
                                          textStyle: _commonClass.getTextStyle(
                                              12,
                                              _colorClass.blackColor,
                                              CommonClass.regular)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextWidget(
                                          text: "phone Number".toUpperCase(),
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.blackColor,
                                              CommonClass.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextWidget(
                                          text: _selectedParty!.mobileNo
                                              .toString(),
                                          textStyle: _commonClass.getTextStyle(
                                              12,
                                              _colorClass.blackColor,
                                              CommonClass.regular)),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownSearch<String>(
                            popupProps: const PopupProps.modalBottomSheet(
                              showSearchBox: true,
                            ),
                            items: widget.expenseCategories,
                            onChanged: (value) {
                              if (value != null) {
                                for (int i = 0;
                                    i < widget.expenseCategories.length;
                                    i++) {
                                  if (value == widget.expenseCategories[i]) {
                                    _selectedCategory = widget
                                        .expenseCategoriesIDs[i]
                                        .toString();
                                    setState(() {});
                                  }
                                }
                              }
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: _colorClass.secondaryBrandColor),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(12, 7, 0, 0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _colorClass.secondaryBrandColor,
                                      width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _colorClass.secondaryBrandColor,
                                      width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _colorClass.secondaryBrandColor,
                                      width: 1)),
                              labelText: "Select Expense Category",
                            )),
                            selectedItem: widget.expenseCategories.isEmpty
                                ? 'No data available'
                                : widget.expenseCategories[0].toUpperCase()),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                            textEditingController: _expenseNumberController,
                            maxLength: 10,
                            type: TextInputType.number,
                            formatter: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            text: "Expense Number",
                            onTypeCallBack: (e) {}),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownSearch<String>(
                            popupProps: const PopupProps.modalBottomSheet(
                              showSearchBox: true,
                            ),
                            items: const [
                              "CASH",
                              "CHEQUE",
                              "ONLINE",
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _paymentMode = value;
                                });
                              }
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: _colorClass.secondaryBrandColor),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(12, 7, 0, 0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _colorClass.secondaryBrandColor,
                                      width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _colorClass.secondaryBrandColor,
                                      width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _colorClass.secondaryBrandColor,
                                      width: 1)),
                              labelText: "Payment Type",
                            )),
                            selectedItem: _paymentMode),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
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
                                    return StatefulBuilder(builder:
                                        (context, bottomSheetSetState) {
                                      return CommonDatePicker(
                                        selectedDate: _date,
                                        onDateSelect: (String date) {
                                          setState(() {
                                            _date = date;
                                          });
                                        },
                                      );
                                    });
                                  });
                            },
                            child: ListTile(
                              title: TextWidget(
                                  text: _date.isEmpty
                                      ? DateFormat("d-M-yyyy")
                                          .format(DateTime.now())
                                          .toString()
                                      : _date,
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: Card(
                            color: _colorClass.mainBrandColor,
                            child: InkWell(
                              splashColor: _colorClass.bgColor,
                              onTap: () {
                                widget.bottomSheetSetState(() {
                                  _expenseListItemModel.add(ExpenseItemModel());
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextWidget(
                                    text: "+ Add Expense Item",
                                    textStyle: _commonClass.getTextStyle(
                                        12,
                                        _colorClass.whiteColor,
                                        CommonClass.medium)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: _expenseListItemModel.length,
                            itemBuilder: (context, index) {
                              return Card(
                                key: _expenseListItemModel[index].key,
                                elevation: 0,
                                color: _colorClass.secondaryBrandColor
                                    .withAlpha(CommonClass.bgAlpha),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          splashColor: _colorClass.bgColor,
                                          onTap: () {
                                            widget.bottomSheetSetState(() {
                                              _expenseListItemModel
                                                  .removeAt(index);
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 18.0, horizontal: 10),
                                            child: Icon(
                                              FontAwesomeIcons.trash,
                                              color: _colorClass.redColor,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextFieldWidget(
                                          textEditingController:
                                              _expenseListItemModel[index]
                                                  .itemName,
                                          maxLength: null,
                                          type: TextInputType.text,
                                          formatter: null,
                                          text: _stringFile.itemName,
                                          onTypeCallBack: (e) {
                                            widget.bottomSheetSetState(() {
                                              // _expenseListItemModel[index]
                                              //     .itemName.text = e;
                                            });
                                          }),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFieldWidget(
                                                textEditingController:
                                                    _expenseListItemModel[index]
                                                        .itemQTY,
                                                maxLength: 10,
                                                type: TextInputType.number,
                                                formatter: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  LengthLimitingTextInputFormatter(
                                                      10),
                                                ],
                                                text: "Quantity",
                                                onTypeCallBack: (e) {
                                                  widget
                                                      .bottomSheetSetState(() {
                                                    // _expenseListItemModel[index]
                                                    //     .itemQTY.text = e;

                                                    if (_expenseListItemModel[
                                                                index]
                                                            .itemQTY
                                                            .text
                                                            .isNotEmpty &&
                                                        _expenseListItemModel[
                                                                index]
                                                            .itemRate
                                                            .text
                                                            .isNotEmpty) {
                                                      int qty = int.parse(
                                                          _expenseListItemModel[
                                                                  index]
                                                              .itemQTY
                                                              .text);
                                                      int rate = int.parse(
                                                          _expenseListItemModel[
                                                                  index]
                                                              .itemRate
                                                              .text);

                                                      _expenseListItemModel[
                                                                  index]
                                                              .itemTotal
                                                              .text =
                                                          (qty * rate)
                                                              .toString();
                                                    } else if (_expenseListItemModel[
                                                            index]
                                                        .itemQTY
                                                        .text
                                                        .isEmpty) {
                                                      int qty = 0;
                                                      int rate = int.parse(
                                                          _expenseListItemModel[
                                                                  index]
                                                              .itemRate
                                                              .text);

                                                      _expenseListItemModel[
                                                                  index]
                                                              .itemTotal
                                                              .text =
                                                          (qty * rate)
                                                              .toString();
                                                    } else if (_expenseListItemModel[
                                                            index]
                                                        .itemRate
                                                        .text
                                                        .isEmpty) {
                                                      int qty = int.parse(
                                                          _expenseListItemModel[
                                                                  index]
                                                              .itemQTY
                                                              .text);
                                                      int rate = 0;

                                                      _expenseListItemModel[
                                                                  index]
                                                              .itemTotal
                                                              .text =
                                                          (qty * rate)
                                                              .toString();
                                                    }
                                                  });
                                                }),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: TextFieldWidget(
                                                textEditingController:
                                                    _expenseListItemModel[index]
                                                        .itemRate,
                                                hasPrefix: "₹",
                                                maxLength: 10,
                                                type: TextInputType.number,
                                                formatter: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  LengthLimitingTextInputFormatter(
                                                      10),
                                                ],
                                                text: "Rate",
                                                onTypeCallBack: (e) {
                                                  widget
                                                      .bottomSheetSetState(() {
                                                    // _expenseListItemModel[index]
                                                    //     .itemRate.text = e;

                                                    if (_expenseListItemModel[
                                                                index]
                                                            .itemQTY
                                                            .text
                                                            .isNotEmpty &&
                                                        _expenseListItemModel[
                                                                index]
                                                            .itemRate
                                                            .text
                                                            .isNotEmpty) {
                                                      int qty = int.parse(
                                                          _expenseListItemModel[
                                                                  index]
                                                              .itemQTY
                                                              .text);
                                                      int rate = int.parse(
                                                          _expenseListItemModel[
                                                                  index]
                                                              .itemRate
                                                              .text);

                                                      _expenseListItemModel[
                                                                  index]
                                                              .itemTotal
                                                              .text =
                                                          (qty * rate)
                                                              .toString();
                                                    } else if (_expenseListItemModel[
                                                            index]
                                                        .itemQTY
                                                        .text
                                                        .isEmpty) {
                                                      int qty = 0;
                                                      int rate = int.parse(
                                                          _expenseListItemModel[
                                                                  index]
                                                              .itemRate
                                                              .text);

                                                      _expenseListItemModel[
                                                                  index]
                                                              .itemTotal
                                                              .text =
                                                          (qty * rate)
                                                              .toString();
                                                    } else if (_expenseListItemModel[
                                                            index]
                                                        .itemRate
                                                        .text
                                                        .isEmpty) {
                                                      int qty = int.parse(
                                                          _expenseListItemModel[
                                                                  index]
                                                              .itemQTY
                                                              .text);
                                                      int rate = 0;

                                                      _expenseListItemModel[
                                                                  index]
                                                              .itemTotal
                                                              .text =
                                                          (qty * rate)
                                                              .toString();
                                                    }
                                                  });
                                                }),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: TextFieldWidget(
                                                enabled: false,
                                                textEditingController:
                                                    _expenseListItemModel[index]
                                                        .itemTotal,
                                                hasPrefix: "₹",
                                                maxLength: 10,
                                                type: TextInputType.number,
                                                formatter: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  LengthLimitingTextInputFormatter(
                                                      10),
                                                ],
                                                text: "Total Amount",
                                                onTypeCallBack: (e) {}),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextWidget(
                                  overflow: TextOverflow.visible,
                                  text: "TOTAL EXPENSE AMOUNT",
                                  textStyle: _commonClass.getTextStyle(
                                      15,
                                      _colorClass.blackColor,
                                      CommonClass.bold)),
                            ),
                            SizedBox(
                              width: 180,
                              child: TextFieldWidget(
                                  textEditingController:
                                      _allItemTotalController,
                                  maxLength: 10,
                                  enabled: false,
                                  type: TextInputType.number,
                                  formatter: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  text: "Total Amount",
                                  onTypeCallBack: (e) {}),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                            textEditingController: _notesController,
                            maxLength: null,
                            type: TextInputType.text,
                            formatter: null,
                            text: "${_stringFile.notes}(Optional)",
                            onTypeCallBack: (e) {}),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: TextWidget(
                                text: "Uploaded Document",
                                textStyle: _commonClass.getTextStyle(
                                    15,
                                    _colorClass.blackColor,
                                    CommonClass.medium))),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  border: Border.all(
                                      color: _colorClass.secondaryBrandColor)),
                              child: _eDocURL.isNotEmpty&&_documentCroppedFile==null?
                              Image.network(

                                _commonClass
                                    .assetURL +
                                    _eDocURL,
                                fit: BoxFit.cover,
                                height: 40,
                                width: 40,
                                loadingBuilder:
                                    (BuildContext
                                context,
                                    Widget child,
                                    ImageChunkEvent?
                                    loadingProgress) {
                                  if (loadingProgress ==
                                      null) {
                                    return child;
                                  }

                                  return Center(
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Lottie.asset(
                                          _commonClass
                                              .myLoader,
                                          fit: BoxFit
                                              .cover),
                                    ),
                                  );
                                },
                              )
                                  :_documentCroppedFile == null
                                  ? Image.asset(
                                      _commonClass.accountechMainLogo,
                                      width: 40,
                                      height: 40,
                                    )
                                  : Image.file(
                                      File(_documentCroppedFile!.path),
                                      width: 40,
                                      height: 40,
                                    ),
                            ),
                            Container(
                              height: 20,
                              width: 62,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: _colorClass.secondaryBrandColor,
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  border: Border.all(
                                      color: _colorClass.secondaryBrandColor)),
                              child: InkWell(
                                splashColor: _colorClass.bgColor,
                                onTap: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions:
                                        _commonClass.allowedExtensions,
                                  );

                                  if (result != null) {
                                    _documentCroppedFile = await _commonClass
                                        .getCroppedImage(result);
                                    setState(() {});
                                  } else {
                                    _documentCroppedFile = null;
                                    // User canceled the picker
                                  }
                                },
                                child: TextWidget(
                                    text: "UPLOAD",
                                    textStyle: _commonClass.getTextStyle(
                                        10,
                                        _colorClass.whiteColor,
                                        CommonClass.medium)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Material(
          color: _colorClass.mainBrandColor,
          child: InkWell(
            onTap: () {
              _addExpenseValidation();
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

  void calculateTotal() {
    _allItemTotalController.text = '0.0';
    double total = 0.0;
    for (int i = 0; i < _expenseListItemModel.length; i++) {
      if (_expenseListItemModel[i].itemTotal.text.isNotEmpty) {
        total = total + double.parse(_expenseListItemModel[i].itemTotal.text);
      }
    }

    _allItemTotalController.text = total.toString();
  }

  void _addExpenseValidation() {
    if (_selectedParty == null) {
      _commonClass.showMessage(context, "Please select party");
    } else if (_selectedCategory.isEmpty) {
      _commonClass.showMessage(context, "Please select category");
    } else if (_expenseNumberController.text.isEmpty) {
      _commonClass.showMessage(context, "Please enter expense number");
    } else if (_date.isEmpty) {
      _commonClass.showMessage(context, "Please select date");
    } else if (_allItemTotalController.text.isEmpty ||
        _allItemTotalController.text == "0.0") {
      _commonClass.showMessage(context, "Please enter expense item properly");
    } else if (_documentCroppedFile == null && _eDocURL.isEmpty) {
      _commonClass.showMessage(context, "Please upload document");
    } else {
      String itemName = "", qty = "", rate = "", totalAmount = "";
      int i;
      for (i = 0; i < _expenseListItemModel.length; i++) {
        if (_expenseListItemModel[i].itemName.text.trim().isEmpty ||
            _expenseListItemModel[i].itemTotal.text.trim().isEmpty ||
            _expenseListItemModel[i].itemTotal.text == "0") {
          _commonClass.showMessage(
              context, "Please enter expense item properly");
          return;
        } else {
          itemName = itemName + ",${_expenseListItemModel[i].itemName.text}";
          qty = qty + ",${_expenseListItemModel[i].itemQTY.text}";
          rate = rate + ",${_expenseListItemModel[i].itemRate.text}";
          totalAmount =
              totalAmount + ",${_expenseListItemModel[i].itemTotal.text}";
        }

        if (itemName.isNotEmpty &&
            qty.isNotEmpty &&
            rate.isNotEmpty &&
            totalAmount.isNotEmpty) {
          _editExpense(itemName, qty, rate, totalAmount);
        }
      }
    }
  }

  void _editExpense(
      String itemName, String qty, String rate, String totalAmount) {
    debugPrint("$itemName\n$qty\n$rate\n$totalAmount");

    _commonClass.showLoader(context, true);
    if (itemName.isNotEmpty &&
        qty.isNotEmpty &&
        rate.isNotEmpty &&
        totalAmount.isNotEmpty) {
      _expenseController
          .editExpense(
        widget.expensesIndividual.eid!,
              _selectedParty!.id.toString(),
              _selectedCategory,
              _expenseNumberController.text,
              _paymentMode,
              _date,
              itemName,
              qty,
              rate,
              totalAmount,
              _allItemTotalController.text,
              _notesController.text,
              _documentCroppedFile!=null?File(_documentCroppedFile!.path):null)
          .then((value) {
        if (value.status == 200) {
          _commonClass.showLoader(context, false);
          _commonClass.showMessage(context, value.message);
          Navigator.pop(context);
        } else {
          _commonClass.showLoader(context, false);
          Navigator.pop(context);

        }
      });
    } else {}
  }
}
