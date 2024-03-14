import 'package:accountech/common/common_class.dart';
import 'package:accountech/controller/partyController/party_controller.dart';
import 'package:accountech/view/screens/partiesFolder/widgets/parties_address_details.dart';
import 'package:accountech/view/screens/partiesFolder/widgets/parties_balance_details.dart';
import 'package:accountech/view/screens/partiesFolder/widgets/parties_gst_plans_details.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:accountech/widgets/textFieldWidgets/text_field_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_button/group_button.dart';
import '../../../common/color_class.dart';
import '../../../common/string_file.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class CreateParty extends StatefulWidget {
  static String createPartyRoute = "/CreateParty";

  const CreateParty({Key? key}) : super(key: key);

  @override
  State<CreateParty> createState() => _CreatePartyState();
}

class _CreatePartyState extends State<CreateParty> {
  final ColorClass _colorClass = ColorClass();
  final StringFile _stringFile = StringFile();
  final CommonClass _commonClass = CommonClass();
  bool? _sameAsMobileNoChecked = false;
  bool? sameToBilling = false;

  TextEditingController partyNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController billingPincodeController = TextEditingController();
  TextEditingController shippingPincodeController = TextEditingController();
  TextEditingController creditPeriodController = TextEditingController();
  TextEditingController creditLimitController = TextEditingController();
  TextEditingController openingBalanceController = TextEditingController();

  String partyType="customer";
  String partyClass="Class 1";
  String creditStatus="i receive";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(CommonClass.headerHeight),
          child: CommonAppBarWidget(
            title: TextWidget(
              text: _stringFile.createNewParty,
              textStyle: _commonClass.getTextStyle(
                  20, _colorClass.blackColor, CommonClass.semiBold),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                        textEditingController: partyNameController,
                          maxLength: null,
                          type: TextInputType.text,
                          formatter: null,
                          text: _stringFile.partyName,
                          onTypeCallBack: (e) {}),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFieldWidget(
                          maxLength: 10,
                          textEditingController: contactNumberController,
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
                          ? Container() : TextFieldWidget(
                          maxLength: 10,
                          textEditingController: whatsappController,
                          type: TextInputType.number,
                          formatter: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          text: _stringFile.whatsappNumber,
                          onTypeCallBack: (e) {}),


                      const SizedBox(
                        height: 15,
                      ),
                      TextFieldWidget(
                          maxLength: null,
                          textEditingController: emailController,
                          type: TextInputType.emailAddress,
                          formatter: null,
                          text: "Party Email",
                          onTypeCallBack: (e) {}),

                      const SizedBox(
                        height: 15,
                      ),
                      TextWidget(
                        overflow: TextOverflow.ellipsis,
                        text: _stringFile.partyType,
                        textStyle: _commonClass.getTextStyle(
                            14, _colorClass.blackColor, CommonClass.medium),
                      ),

                      const SizedBox(
                        height: 5,
                      ),
                      GroupButton(
                        isRadio: true,
                        onSelected: (value, index, isSelected) {
                          partyType=value.toString().toLowerCase();
                        },
                        buttons: [_stringFile.customer, _stringFile.vendor],
                        controller: GroupButtonController(
                          selectedIndex: 0,
                        ),
                        options: GroupButtonOptions(
                            selectedColor:
                            _colorClass.mainBrandColor.withAlpha(30),
                            unselectedColor: _colorClass.bgColor,
                            selectedTextStyle:
                            TextStyle(color: _colorClass.mainBrandColor),
                            selectedBorderColor: _colorClass.mainBrandColor,
                            unselectedBorderColor: _colorClass.transparent,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DropdownSearch<String>(
                          popupProps: const PopupProps.modalBottomSheet(
                            showSearchBox: true,

                          ),
                          items: const [
                            "Class 1",
                            "Class 2",
                            "Class 3",
                            'Class 4',
                            'Class 5'
                          ],
                          onChanged: (value){
                            partyClass=value.toString();
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
                                labelText: _stringFile.choosePartyClass,
                              )),
                          selectedItem: "Class 1"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                color: _colorClass.whiteColor,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: _stringFile.optionalDetails,
                        textStyle: _commonClass.getTextStyle(
                            14, _colorClass.blackColor, CommonClass.medium),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       PartiesGstPlansDetails(gstController: gstController, panController: panController, adharController: aadharController,),
                      const SizedBox(
                        height: 10,
                      ),
                       PartiesAddressDetails(billingPincodeController: billingPincodeController, shippingPincodeController: shippingPincodeController, getCheckedValue: (value){
                         sameToBilling=value;
                       },),
                      const SizedBox(
                        height: 10,
                      ),
                      PartiesBalanceDetails(creditPeriodController: creditPeriodController, creditLimitController: creditLimitController, openingBalanceController: openingBalanceController, getCreditStatusChangeValue: (value){
                        creditStatus=value.toString().toLowerCase();
                        },),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Material(
        color: _colorClass.mainBrandColor,
        child: InkWell(
          onTap: () {
            if(partyNameController.text.isNotEmpty && contactNumberController.text.isNotEmpty && whatsappController.text.isNotEmpty && emailController.text.isNotEmpty ){
              createParty(
                partyType,
                partyClass,
                partyNameController.text.toString(),
                emailController.text.toString(),
                contactNumberController.text.toString(),
                _sameAsMobileNoChecked! ? "yes":"no",
                whatsappController.text.toString(),
                gstController.text.toString(),
                panController.text.toString(),
                aadharController.text.toString(),
                billingPincodeController.text.toString(),
                "hhh",
                sameToBilling! ? "yes" : "no",
                shippingPincodeController.text.toString(),
                "hhh",
                creditPeriodController.text.toString(),
                creditLimitController.text.toString(),
                openingBalanceController.text.toString(),
                creditStatus
              );
            }
            else{
              _commonClass.showMessage(
                  context, "Please Fill Required Fields");
            }
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

  void createParty(
      String partyType,
      String partyClass,
      String partyName,
      String email,
      String phoneNo,
      String sameToPhone,
      String whatsappNo,
      String gstNo,
      String panNo,
      String udhyamAadhar,
      String billingPincode,
      String billingAddress,
      String sameToBilling,
      String shippingPincode,
      String shippingAddress,
      String creditPeriod,
      String creditLimit,
      String openingBalance,
      String crStatus
      ) {
    _commonClass.showLoader(context, true);
    PartyController().createParty(
        partyType,
        partyClass,
        partyName,
        email,
        phoneNo,
        sameToPhone,
        whatsappNo,
        gstNo,
        panNo,
        udhyamAadhar,
        billingPincode,
        billingAddress,
        sameToBilling,
        shippingPincode,
        shippingAddress,
        creditPeriod,
        creditLimit,
        openingBalance,
        crStatus
    ).then((value) {
    _commonClass.showLoader(context, false);

    _commonClass.showMessage(
    context, "Party Created");
      Navigator.pop(context);

    });
  }
}
