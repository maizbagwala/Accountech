import 'package:accountech/common/common_class.dart';
import 'package:accountech/view/screens/partiesFolder/widgets/parties_address_details.dart';
import 'package:accountech/view/screens/partiesFolder/widgets/parties_balance_details.dart';
import 'package:accountech/view/screens/partiesFolder/widgets/parties_gst_plans_details.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:accountech/widgets/textFieldWidgets/text_field_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_button/group_button.dart';
import 'package:lottie/lottie.dart';
import '../../../common/color_class.dart';
import '../../../common/string_file.dart';
import '../../../controller/partyController/party_controller.dart';
import '../../../model/partyModels/party_edit_details_model.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class EditParty extends StatefulWidget {
  static String editPartyRoute = "/EditParty";

  const EditParty({Key? key}) : super(key: key);

  @override
  State<EditParty> createState() => _EditPartyState();
}

class _EditPartyState extends State<EditParty> {
  final ColorClass _colorClass = ColorClass();
  final StringFile _stringFile = StringFile();
  final CommonClass _commonClass = CommonClass();
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

  String partyType = "customer";
  String partyClass = "Class 1";
  String creditStatus = "i receive";
  String partyId = "";
  bool? _sameAsMobileNoChecked = false;
  bool? sameToBilling = false;

  late Future<dynamic> _getDetails;
  bool first = true;
  bool first1 = true;

  @override
  void initState() {
    super.initState();
    // _getTransactions=;
    // _getDetails = PartyController().getPartyDetails();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    // var data = args['data'] as Datum;
    if (first) {
      _getDetails =
          PartyController().getPartyEditDetails(args['id'].toString());
      partyId = args['id'].toString();
      first = false;
    }
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(CommonClass.headerHeight),
          child: CommonAppBarWidget(
            title: TextWidget(
              text: _stringFile.editParty,
              textStyle: _commonClass.getTextStyle(
                  20, _colorClass.blackColor, CommonClass.semiBold),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        height: _commonClass.getScreenHeight(context),
        width: _commonClass.getScreenWidth(context),
        color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
        child: FutureBuilder(
            future: _getDetails,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return TextWidget(
                    text: "There is an error please try again...",
                    textStyle: _commonClass.getTextStyle(
                        15, _colorClass.blackColor, CommonClass.semiBold));
              } else if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child:
                        Lottie.asset(_commonClass.myLoader, fit: BoxFit.cover),
                  ),
                );
              } else {
                PartyEditDetailsModel value = snapshot.data;
                if (value.data != null) {
                 if(first1) {
                    partyNameController.text = value.data!.partyName!;
                    contactNumberController.text =
                        value.data!.phoneNo!.toString();
                    whatsappController.text = value.data!.phoneNo!.toString();
                    emailController.text = value.data!.email!;
                    gstController.text = value.data!.gstNo!;
                    panController.text = value.data!.panNo!;
                    aadharController.text = value.data!.udhyamAadhar!;
                    billingPincodeController.text =
                        value.data!.billingPincode!.toString();
                    shippingPincodeController.text =
                        value.data!.shippingPincode!.toString();
                    creditPeriodController.text =
                        value.data!.creditPeriod!.toString();
                    creditLimitController.text =
                        value.data!.creditLimit!.toString();
                    openingBalanceController.text =
                        value.data!.openingBalance!.toString();
                    first1=false;
                  }
                  // if(value.data!){
                  //
                  // }
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
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
                                  textEditingController:
                                      contactNumberController,
                                  maxLength: 10,
                                  type: TextInputType.number,
                                  formatter: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  text: _stringFile.partyContactNumber,
                                  onTypeCallBack: (e) {}),
                              CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
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
                                      12,
                                      _colorClass.blackColor,
                                      CommonClass.light),
                                ),
                              ),
                              _sameAsMobileNoChecked ?? false
                                  ? Container()
                                  : TextFieldWidget(
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
                                textStyle: _commonClass.getTextStyle(14,
                                    _colorClass.blackColor, CommonClass.medium),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              GroupButton(
                                isRadio: true,
                                onSelected: (value, index, isSelected) {
                                  partyType = value.toString().toLowerCase();
                                },
                                buttons: [
                                  _stringFile.customer,
                                  _stringFile.supplier
                                ],
                                controller: GroupButtonController(
                                  selectedIndex: 0,
                                ),
                                options: GroupButtonOptions(
                                    selectedColor: _colorClass.mainBrandColor
                                        .withAlpha(30),
                                    unselectedColor: _colorClass.bgColor,
                                    selectedTextStyle: TextStyle(
                                        color: _colorClass.mainBrandColor),
                                    selectedBorderColor:
                                        _colorClass.mainBrandColor,
                                    unselectedBorderColor:
                                        _colorClass.transparent,
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
                                  onChanged: (value) {
                                    partyClass = value.toString();
                                  },
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
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
                                    labelText: _stringFile.chooseACategory,
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
                                textStyle: _commonClass.getTextStyle(14,
                                    _colorClass.blackColor, CommonClass.medium),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PartiesGstPlansDetails(
                                gstController: gstController,
                                panController: panController,
                                adharController: aadharController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PartiesAddressDetails(
                                billingPincodeController:
                                    billingPincodeController,
                                shippingPincodeController:
                                    shippingPincodeController,
                                getCheckedValue: (value) {
                                  sameToBilling = value;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PartiesBalanceDetails(
                                creditPeriodController: creditPeriodController,
                                creditLimitController: creditLimitController,
                                openingBalanceController:
                                    openingBalanceController,
                                getCreditStatusChangeValue: () {
                                  creditStatus = value.toString().toLowerCase();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
      bottomNavigationBar: Material(
        color: _colorClass.mainBrandColor,
        child: InkWell(
          onTap: () {
            if (partyNameController.text.isNotEmpty &&
                contactNumberController.text.isNotEmpty &&
                whatsappController.text.isNotEmpty &&
                emailController.text.isNotEmpty) {
              editParty(
                  partyId,
                  partyType,
                  partyClass,
                  partyNameController.text.toString(),
                  emailController.text.toString(),
                  contactNumberController.text.toString(),
                  _sameAsMobileNoChecked! ? "yes" : "no",
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
                  creditStatus);
            } else {
              _commonClass.showMessage(context, "Please Fill Required Fields");
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

  void editParty(
      partyId,
      partyType,
      partyClass,
      name,
      email,
      contact,
      sameAsMobile,
      whatsapp,
      gst,
      pan,
      adhar,
      billingPincode,
      billingAddress,
      sameToBilling,
      shippingPincode,
      shippingAddress,
      creditPeriod,
      creditLimit,
      openingBalance,
      creditStatus) {
    _commonClass.showLoader(context, true);
    PartyController()
        .editParty(
            partyId,
            partyType,
            partyClass,
            name,
            email,
            contact,
            sameAsMobile,
            whatsapp,
            gst,
            pan,
            adhar,
            billingPincode,
            billingAddress,
            sameToBilling,
            shippingPincode,
            shippingAddress,
            creditPeriod,
            creditLimit,
            openingBalance,
            creditStatus)
        .then((value) {
      _commonClass.showLoader(context, false);

      _commonClass.showMessage(context, "Party Edited");
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }
}
