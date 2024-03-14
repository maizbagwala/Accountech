import 'package:accountech/controller/partyController/party_controller.dart';
import 'package:accountech/view/screens/goodInTransitFolder/add_good_in_transit_screen.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:accountech/model/partyModels/party_list_model.dart';

import '../../../../common/color_class.dart';
import '../../../../common/common_class.dart';
import '../../../../common/string_file.dart';
import '../../../../widgets/textFieldWidgets/normal_text_field_widget.dart';
import '../../../../widgets/textWidgets/text_widget.dart';
import '../../architectFolder/create_architect.dart';
import '../../partiesFolder/create_party.dart';
import '../../partiesFolder/widgets/parties_common_row_widget.dart';

class GoodsInTransitPartyAdd extends StatefulWidget {
  final Function getSalesManager;
  final Function getArchitect;
  final Function getParty;
  const GoodsInTransitPartyAdd({Key? key, required this.getSalesManager, required this.getArchitect, required this.getParty}) : super(key: key);

  @override
  State<GoodsInTransitPartyAdd> createState() => _GoodsInTransitPartyAddState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();
final StringFile _stringFile = StringFile();

class _GoodsInTransitPartyAddState extends State<GoodsInTransitPartyAdd> {
  String _searchParty = "";
  Datum? _selectedParty;
  var details={"sales_id":"1","architect_id":"1"};


  @override
  Widget build(BuildContext context) {
    widget.getSalesManager("1");
    widget.getArchitect("1");

    return Column(
      children: [
        SizedBox(
          width: _commonClass.getScreenWidth(context),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                      text: _stringFile.partyName,
                      textStyle: _commonClass.getTextStyle(
                          15, _colorClass.blackColor, CommonClass.bold)),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: _colorClass.secondaryBrandColor)),
                    child: ListTile(
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
                              _searchParty = e;
                            });
                          }),
                    ),
                  ),
                  _searchParty.isEmpty
                      ? Container(
                          height: 10,
                        )
                      : FutureBuilder<dynamic>(
                          future: PartyController().searchParty(_searchParty),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return TextWidget(
                                  text: "There is an error please try again...",
                                  textStyle: _commonClass.getTextStyle(
                                      15,
                                      _colorClass.blackColor,
                                      CommonClass.semiBold));
                            } else if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Lottie.asset(_commonClass.myLoader,
                                      fit: BoxFit.cover),
                                ),
                              );
                            } else {
                              dynamic value = snapshot.data;

                              if (value.status != null) {
                                if (value.status == 200 && value.data != null) {
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
                                            setState(() {
                                              _selectedParty = partList[index];
                                              // details["party_id"]= partList[index].id as String;
                                              widget.getParty(partList[index].id.toString());
                                              _searchParty = "";
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
                                                  text: _stringFile.partyName,
                                                  textStyle:
                                                      _commonClass.getTextStyle(
                                                          15,
                                                          _colorClass
                                                              .blackColor,
                                                          CommonClass.bold)),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              TextWidget(
                                                  text: StringUtils.capitalize(
                                                      partList[index].name),
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
                                                  text: "phone Number"
                                                      .toUpperCase(),
                                                  textStyle:
                                                      _commonClass.getTextStyle(
                                                          15,
                                                          _colorClass
                                                              .blackColor,
                                                          CommonClass.bold)),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              TextWidget(
                                                  text: partList[index]
                                                      .mobileNo
                                                      .toString(),
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
                                                  text: "GSTIN".toUpperCase(),
                                                  textStyle:
                                                      _commonClass.getTextStyle(
                                                          15,
                                                          _colorClass
                                                              .blackColor,
                                                          CommonClass.bold)),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              TextWidget(
                                                  text: partList[index]
                                                      .gstNo
                                                      .toString(),
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
                                                  text: "ADDRESS".toUpperCase(),
                                                  textStyle:
                                                      _commonClass.getTextStyle(
                                                          15,
                                                          _colorClass
                                                              .blackColor,
                                                          CommonClass.bold)),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              TextWidget(
                                                  text: partList[index]
                                                      .billingAddress
                                                      .toString(),
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
                                                  text: "Current Party Balance"
                                                      .toUpperCase(),
                                                  textStyle:
                                                      _commonClass.getTextStyle(
                                                          15,
                                                          _colorClass
                                                              .blackColor,
                                                          CommonClass.bold)),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              TextWidget(
                                                  text:
                                                      "₹${partList[index].openingBalance.toString()}",
                                                  textStyle:
                                                      _commonClass.getTextStyle(
                                                          12,
                                                          _colorClass
                                                              .blackColor,
                                                          CommonClass.regular)),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    text: _selectedParty!.mobileNo.toString(),
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
                  DropdownSearch<String>(
                      popupProps: const PopupProps.modalBottomSheet(
                        showSearchBox: true,
                      ),
                      items: const [
                        "1",
                        "2",
                        "3",
                      ],
                      onChanged: (item){
                        widget.getSalesManager(item.toString());

                        // details["sales_id"] = item.toString();
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                        labelStyle:
                            TextStyle(color: _colorClass.secondaryBrandColor),
                        contentPadding: const EdgeInsets.fromLTRB(12, 7, 0, 0),
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
                        labelText: "Sales Manager",
                      )),
                      selectedItem: "1"),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownSearch<String>(
                      popupProps: PopupProps.modalBottomSheet(
                          showSearchBox: true,
                          emptyBuilder: (context, child) {
                            // Your code
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              width: _commonClass.getScreenWidth(context),
                              child: Material(
                                color: _colorClass.secondaryBrandColor,
                                child: InkWell(
                                  splashColor: _colorClass.whiteColor,
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        CreateArchitect.createArchitectRoute);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.userPlus,
                                          color: _colorClass.whiteColor,
                                          size: 15,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: TextWidget(
                                              overflow: TextOverflow.visible,
                                              text: "Add Architecture",
                                              textStyle:
                                                  _commonClass.getTextStyle(
                                                      12,
                                                      _colorClass.whiteColor,
                                                      CommonClass.medium)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                      items: const [
                        "1",
                        "2",
                        "3",
                      ],
                      onChanged: (value) {
                        widget.getArchitect(value.toString());

                        // details["architect_id"]=value.toString();
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                        labelStyle:
                            TextStyle(color: _colorClass.secondaryBrandColor),
                        contentPadding: const EdgeInsets.fromLTRB(12, 7, 0, 0),
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
                        labelText: "Architect",
                      )),
                      selectedItem: "1"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
