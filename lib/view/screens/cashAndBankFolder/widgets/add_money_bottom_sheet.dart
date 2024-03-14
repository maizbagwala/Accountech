import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/controller/cashAndBankController/cash_and_bank_controller.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:accountech/model/partyModels/party_list_model.dart';


import '../../../../common/date_picker.dart';
import '../../../../controller/partyController/party_controller.dart';
import '../../../../widgets/textFieldWidgets/normal_text_field_widget.dart';
import '../../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../../widgets/textWidgets/text_widget.dart';

class AddMoneyBottomSheet extends StatefulWidget {
  final StateSetter bottomSheetSetState;

  const AddMoneyBottomSheet({Key? key, required this.bottomSheetSetState}) : super(key: key);

  @override
  State<AddMoneyBottomSheet> createState() => _AddMoneyBottomSheetState();
}

class _AddMoneyBottomSheetState extends State<AddMoneyBottomSheet>
    with TickerProviderStateMixin {
  final StringFile _stringFile = StringFile();
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();

  late TabController _tabController;
  var partyController = Get.find<PartyController>();
  Datum? _selectedParty;

  var amountController =TextEditingController();
  var paymentInNumberController =TextEditingController();
  var notesController =TextEditingController();
  var paymentType="";
  var paymentDate="00-00-0000";



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  String _search = "";

  @override
  Widget build(BuildContext context) {
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
                          text: _stringFile.addMoney,
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
              Card(
                margin: const EdgeInsets.all(0),
                child: TabBar(
                  indicatorColor: _colorClass.mainBrandColor,
                  labelColor: _colorClass.blackColor,
                  controller: _tabController,
                  tabs: <Widget>[
                    Tab(
                      text: _stringFile.sales,
                    ),
                    Tab(
                      text: _stringFile.others,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            SingleChildScrollView(
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
                                          setState(() {
                                            _search = e;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            _search.isEmpty
                                ? Container(height: 10,)
                                : FutureBuilder<dynamic>(
                              future: partyController.searchParty(_search),
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextWidget(
                                        text: "Balance".toUpperCase(),
                                        textStyle: _commonClass.getTextStyle(
                                            15,
                                            _colorClass.blackColor,
                                            CommonClass.bold)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextWidget(
                                        text: "₹${_selectedParty!.openingBalance.toString()}",
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
                              height: 10,
                            ),
                            TextFieldWidget(
                              textEditingController: amountController,
                                maxLength: 10,
                                type: TextInputType.number,
                                formatter: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                text: _stringFile.amount,
                                onTypeCallBack: (e) {}),
                            const SizedBox(
                              height: 10,
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
                                              return  BottomSheetForDateSelection(onSubmit: (value){
                                                print(value);
                                                setState(() {
                                                  paymentDate=value;
                                                });

                                              },);
                                        });
                                      });
                                },
                                child: ListTile(
                                  title: TextWidget(
                                      text: "$paymentDate",
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
                            DropdownSearch<String>(
                                popupProps: const PopupProps.modalBottomSheet(
                                  showSearchBox: true,

                                ),

                                items: const [
                                  "CASH",
                                  "CHEQUE",
                                  "ONLINE",
                                ],
                                onChanged: (value){
                                  setState(() {
                                    paymentType=value.toString().toLowerCase();
                                  });
                                },
                              dropdownDecoratorProps:DropDownDecoratorProps(dropdownSearchDecoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: _colorClass.secondaryBrandColor),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(12, 7, 0, 0),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              _colorClass.secondaryBrandColor,
                                          width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              _colorClass.secondaryBrandColor,
                                          width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              _colorClass.secondaryBrandColor,
                                          width: 1)),
                                  labelText: "Payment Type",
                                )),
                                selectedItem: paymentType==""?"Payment Type":paymentType),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldWidget(
                                textEditingController: paymentInNumberController,
                                maxLength: 10,
                                type: TextInputType.number,
                                formatter: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                text: "PAYMENT IN NUMBER",
                                onTypeCallBack: (e) {}), const SizedBox(
                              height: 20,
                            ),

                            TextFieldWidget(
                                textEditingController: notesController,
                                maxLength: null,
                                type: TextInputType.text,
                                formatter: null,
                                text: _stringFile.notes,
                                onTypeCallBack: (e) {}),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
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



                        TextWidget(
                            text: "Current Party Balance"
                                .toUpperCase(),
                            textStyle: _commonClass.getTextStyle(
                                15,
                                _colorClass.blackColor,
                                CommonClass.semiBold)),
                        const SizedBox(
                          height: 10,
                        ),
                        TextWidget(
                            text: "₹0",
                            textStyle: _commonClass.getTextStyle(
                                13,
                                _colorClass.blackColor,
                                CommonClass.regular)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
                                textEditingController: amountController,
                                maxLength: 10,
                                type: TextInputType.number,
                                formatter: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                text: _stringFile.amount,
                                onTypeCallBack: (e) {}),
                            const SizedBox(
                              height: 10,
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
                                          return  BottomSheetForDateSelection(onSubmit: (value){
                                            print(value);
                                            setState(() {
                                              paymentDate=value;
                                            });
                                          },);
                                        });
                                      });
                                },
                                child: ListTile(
                                  title: TextWidget(
                                      text: "$paymentDate",
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
                            DropdownSearch<String>(
                                popupProps: const PopupProps.modalBottomSheet(
                                  showSearchBox: true,

                                ),
                                items: const [
                                  "CASH",
                                  "CHEQUE",
                                  "ONLINE",
                                ],
                                onChanged: (value){
                                  setState(() {
                                    paymentType=value.toString().toLowerCase();
                                  });
                                },
                              dropdownDecoratorProps:DropDownDecoratorProps(dropdownSearchDecoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: _colorClass.secondaryBrandColor),
                                  contentPadding:
                                  const EdgeInsets.fromLTRB(12, 7, 0, 0),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          _colorClass.secondaryBrandColor,
                                          width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          _colorClass.secondaryBrandColor,
                                          width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          _colorClass.secondaryBrandColor,
                                          width: 1)),
                                  labelText: "Payment Type",
                                )),
                                selectedItem: paymentType==""?"Payment Type":paymentType),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldWidget(
                                textEditingController: paymentInNumberController,
                                maxLength: 10,
                                type: TextInputType.number,
                                formatter: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                text: "PAYMENT IN NUMBER",
                                onTypeCallBack: (e) {}), const SizedBox(
                              height: 20,
                            ),

                            TextFieldWidget(
                                textEditingController: notesController,
                                maxLength: null,
                                type: TextInputType.text,
                                formatter: null,
                                text: _stringFile.notes,
                                onTypeCallBack: (e) {}),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Material(
          color: _colorClass.mainBrandColor,
          child: InkWell(
            onTap: () {
              print(_tabController.index);
              if(
              _tabController.index==0? _selectedParty!=null:true &&
              amountController.text.isNotEmpty &&
              paymentDate.isNotEmpty &&
              paymentType.isNotEmpty &&
              paymentInNumberController.text.isNotEmpty &&
              notesController.text.isNotEmpty
              ){
                var type=_tabController.index==0?"sales":"others";
                save(type,_tabController.index==0?_selectedParty?.id.toString():"",paymentDate,paymentType,paymentInNumberController.text.toString(),notesController.text.toString());
              }
              // Navigator.pop(context);
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

  void save(type,partyID,date,paymentType,paymentInNumber,notes) {
    CashAndBankController().addMoney(type, partyID, date, paymentType, paymentInNumber, notes).then((value) {
      Navigator.pop(context);
      if (value['status'] != 200) {
        print("something went wrong");
      }else{

      }
    });


  }
}
