import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../widgets/textFieldWidgets/normal_text_field_widget.dart';
import '../../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../../widgets/textWidgets/text_widget.dart';
import '../../commonScreens/item_listing_screen.dart';

class ReduceMoneyBottomSheet extends StatefulWidget {
  const ReduceMoneyBottomSheet({Key? key}) : super(key: key);

  @override
  State<ReduceMoneyBottomSheet> createState() => _ReduceMoneyBottomSheetState();
}

class _ReduceMoneyBottomSheetState extends State<ReduceMoneyBottomSheet>
    with TickerProviderStateMixin {
  final StringFile _stringFile = StringFile();
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
                          text: _stringFile.reduceMoney,
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
                      text: _stringFile.purchase,
                    ),
                    Tab(
                      text: _stringFile.expense,
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
                                ? Container(
                                    height: 10,
                                  )
                                : Column(
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
                                          text: _stringFile.partyName,
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
                                          text: "+91 7990050433",
                                          textStyle: _commonClass.getTextStyle(
                                              12,
                                              _colorClass.blackColor,
                                              CommonClass.regular)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextWidget(
                                          text: "GSTIN".toUpperCase(),
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.blackColor,
                                              CommonClass.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextWidget(
                                          text: "22ILCPD8235R1Z5",
                                          textStyle: _commonClass.getTextStyle(
                                              12,
                                              _colorClass.blackColor,
                                              CommonClass.regular)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextWidget(
                                          text: "ADDRESS".toUpperCase(),
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.blackColor,
                                              CommonClass.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextWidget(
                                          text:
                                              "22/D Titenium city center, ahmedabad, pincode - 381500",
                                          textStyle: _commonClass.getTextStyle(
                                              12,
                                              _colorClass.blackColor,
                                              CommonClass.regular)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextWidget(
                                          text: "Current Party Balance"
                                              .toUpperCase(),
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.blackColor,
                                              CommonClass.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextWidget(
                                          text: "₹0",
                                          textStyle: _commonClass.getTextStyle(
                                              12,
                                              _colorClass.blackColor,
                                              CommonClass.regular)),
                                    ],
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
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
                            DropdownSearch<String>(
                                popupProps: const PopupProps.modalBottomSheet(
                                  showSearchBox: true,

                                ),
                                items: const [
                                  "CASH",
                                  "CHEQUE",
                                  "ONLINE",
                                ],
                                onChanged: print,
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
                                selectedItem: "Payment Type"),
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
                                text: "PAYMENT IN NUMBER",
                                onTypeCallBack: (e) {}),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldWidget(
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
                                ? Container(
                                    height: 10,
                                  )
                                : Column(
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
                                          text: _stringFile.partyName,
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
                                          text: "+91 7990050433",
                                          textStyle: _commonClass.getTextStyle(
                                              12,
                                              _colorClass.blackColor,
                                              CommonClass.regular)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextWidget(
                                          text: "GSTIN".toUpperCase(),
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.blackColor,
                                              CommonClass.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextWidget(
                                          text: "22ILCPD8235R1Z5",
                                          textStyle: _commonClass.getTextStyle(
                                              12,
                                              _colorClass.blackColor,
                                              CommonClass.regular)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextWidget(
                                          text: "ADDRESS".toUpperCase(),
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.blackColor,
                                              CommonClass.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextWidget(
                                          text:
                                              "22/D Titenium city center, ahmedabad, pincode - 381500",
                                          textStyle: _commonClass.getTextStyle(
                                              12,
                                              _colorClass.blackColor,
                                              CommonClass.regular)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextWidget(
                                          text: "Current Party Balance"
                                              .toUpperCase(),
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.blackColor,
                                              CommonClass.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextWidget(
                                          text: "₹0",
                                          textStyle: _commonClass.getTextStyle(
                                              12,
                                              _colorClass.blackColor,
                                              CommonClass.regular)),
                                    ],
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
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
                            DropdownSearch<String>(
                                popupProps: const PopupProps.modalBottomSheet(
                                  showSearchBox: true,

                                ),
                                items: const [
                                  "CASH",
                                  "CHEQUE",
                                  "ONLINE",
                                ],
                                onChanged: print,
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
                                selectedItem: "Payment Type"),
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
                                text: "PAYMENT IN NUMBER",
                                onTypeCallBack: (e) {}),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldWidget(
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
                                text: "Current Party Balance".toUpperCase(),
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
                            DropdownSearch<String>(
                                popupProps: const PopupProps.modalBottomSheet(
                                  showSearchBox: true,

                                ),
                                items: const [
                                  "CASH",
                                  "CHEQUE",
                                  "ONLINE",
                                ],
                                onChanged: print,
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
                                selectedItem: "Payment Type"),
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
                                text: "PAYMENT IN NUMBER",
                                onTypeCallBack: (e) {}),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldWidget(
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
