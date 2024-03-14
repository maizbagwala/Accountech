import 'package:accountech/common/common_class.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:accountech/widgets/textFieldWidgets/text_field_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../common/color_class.dart';
import '../../../common/string_file.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class CreateArchitect extends StatefulWidget {
  static String createArchitectRoute = "/CreateArchitect";

  const CreateArchitect({Key? key}) : super(key: key);

  @override
  State<CreateArchitect> createState() => _CreateArchitectState();
}

class _CreateArchitectState extends State<CreateArchitect> {
  final ColorClass _colorClass = ColorClass();
  final StringFile _stringFile = StringFile();
  final CommonClass _commonClass = CommonClass();
  bool? _sameAsMobileNoChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(CommonClass.headerHeight),
          child: CommonAppBarWidget(
            title: TextWidget(
              text: "Create New Architect",
              textStyle: _commonClass.getTextStyle(
                  20, _colorClass.blackColor, CommonClass.semiBold),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
      body: Container(
        height: _commonClass.getScreenHeight(context),
        width: _commonClass.getScreenWidth(context),
        color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Material(
                color: _colorClass.whiteColor,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldWidget(
                          maxLength: null,
                          type: TextInputType.text,
                          formatter: null,
                          text: "Architecture Name",
                          onTypeCallBack: (e) {}),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFieldWidget(
                          maxLength: null,
                          type: TextInputType.text,
                          formatter: null,
                          text: "Form Name",
                          onTypeCallBack: (e) {}),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFieldWidget(
                          maxLength: null,
                          type: TextInputType.text,
                          formatter: null,
                          text: "Email",
                          onTypeCallBack: (e) {}),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFieldWidget(
                          maxLength: 10,
                          type: TextInputType.number,
                          formatter: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          text: _stringFile.partyContactNumber,
                          onTypeCallBack: (e) {}),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        activeColor: _colorClass.mainBrandColor,
                        value: _sameAsMobileNoChecked,
                        onChanged: (value) {
                          setState(() {
                            _sameAsMobileNoChecked = value;
                          });
                        },
                        title: TextWidget(
                          text: _stringFile.sameAsMobileNo,
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.blackColor, CommonClass.light),
                        ),
                      ),
                      _sameAsMobileNoChecked ?? false
                          ? Container()
                          : TextFieldWidget(
                              maxLength: 10,
                              type: TextInputType.number,
                              formatter: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              text: _stringFile.whatsappNumber,
                              onTypeCallBack: (e) {}),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFieldWidget(
                          maxLength: 6,
                          type: TextInputType.number,
                          formatter: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
                          text: "Pincode",
                          onTypeCallBack: (e) {}),
                      const SizedBox(
                        height: 15,
                      ),
                      DropdownSearch<String>(
                          popupProps: const PopupProps.modalBottomSheet(
                            showSearchBox: true,
                          ),
                          items: const [
                            "Data 1",
                            "Data 2",
                            "Data 3",
                            'Data 4',
                            'Data 5'
                          ],
                          onChanged: print,
                          dropdownDecoratorProps:DropDownDecoratorProps(

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
                              labelText: "Select State",
                            ),

                          ),


                          selectedItem: "Data 1"),
                      const SizedBox(
                        height: 15,
                      ),
                      DropdownSearch<String>(
                          popupProps: const PopupProps.modalBottomSheet(
                            showSearchBox: true,
                          ),
                          items: const [
                            "Data 1",
                            "Data 2",
                            "Data 3",
                            'Data 4',
                            'Data 5'
                          ],
                          onChanged: print,
                        dropdownDecoratorProps:DropDownDecoratorProps(

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
                            labelText: "Select City",
                          ),),
                          selectedItem: "Data 1"),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFieldWidget(
                          maxLines: true,
                          maxLength: null,
                          type: TextInputType.text,
                          formatter: null,
                          text: "Full Address",
                          onTypeCallBack: (e) {}),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFieldWidget(
                          maxLength: null,
                          type: TextInputType.number,
                          formatter: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          text: "Commission",
                          hasPrefix: "",
                          onTypeCallBack: (e) {}),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
