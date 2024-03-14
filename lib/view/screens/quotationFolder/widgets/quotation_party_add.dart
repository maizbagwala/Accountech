import 'package:accountech/view/screens/architectFolder/create_architect.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../common/color_class.dart';
import '../../../../common/common_class.dart';
import '../../../../common/string_file.dart';
import '../../../../widgets/textFieldWidgets/normal_text_field_widget.dart';
import '../../../../widgets/textWidgets/text_widget.dart';
import '../../partiesFolder/create_party.dart';
import '../../partiesFolder/widgets/parties_common_row_widget.dart';

class QuotationPartyAdd extends StatefulWidget {
  const QuotationPartyAdd({Key? key}) : super(key: key);

  @override
  State<QuotationPartyAdd> createState() => _QuotationPartyAddState();
}
String _searchParty = "";
final CommonClass _commonClass=CommonClass();
final ColorClass _colorClass=ColorClass();
final StringFile _stringFile=StringFile();
class _QuotationPartyAddState extends State<QuotationPartyAdd> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
                    textStyle: _commonClass.getTextStyle(15,
                        _colorClass.blackColor, CommonClass.bold)),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: _colorClass.secondaryBrandColor)),
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
                const SizedBox(
                  height: 20,
                ),
                DropdownSearch<String>(
                    popupProps: const PopupProps.modalBottomSheet(
                      showSearchBox: true,

                    ),
                    items: const [
                      "Data 1",
                      "Data 1",
                      "Data 1",
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
                      labelText: "Sales Manager",
                    )),
                    selectedItem: "Data 1"),
                const SizedBox(
                  height: 20,
                ),

                DropdownSearch<String>(
                    popupProps:   PopupProps.modalBottomSheet(
                      showSearchBox: true,
                      emptyBuilder:(context, child) {
                        // Your code
                        return               Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                          width: _commonClass.getScreenWidth(context),
                          child: Material(
                            color: _colorClass.secondaryBrandColor,
                            child: InkWell(
                              splashColor: _colorClass.whiteColor,
                              onTap: () {
Navigator.pushNamed(context, CreateArchitect.createArchitectRoute);
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
                        );
                      }


                    ),
                    items: const [
                      "Dataasdasdasdsd 1",
                      "Data 1",
                      "Data 1",
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
                      labelText: "Architect",
                    )),
                    selectedItem: "Data 1"),
              ],
            ),
          ),
        ),
      ),
      _searchParty.isEmpty
          ? Container()
          : SizedBox(
        width: _commonClass.getScreenWidth(context),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  width: _commonClass.getScreenWidth(context),
                  child: Material(
                    color: _colorClass.secondaryBrandColor,
                    child: InkWell(
                      splashColor: _colorClass.whiteColor,
                      onTap: () {
                        Navigator.pushNamed(context,
                            CreateParty.createPartyRoute);
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
                                  overflow:
                                  TextOverflow.visible,
                                  text:
                                  "${_stringFile.addDetailsFor} $_searchParty",
                                  textStyle: _commonClass
                                      .getTextStyle(
                                      12,
                                      _colorClass
                                          .whiteColor,
                                      CommonClass
                                          .medium)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GridView.builder(
                    physics:
                    const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 20,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 16 / 10,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return PartiesCommonRowWidget(
                        onTap: (String value) {}, data: null,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),

    ],);
  }
}
