import 'dart:io';

import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/my_shared_preferences.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/controller/authController/auth_controller.dart';
import 'package:accountech/controller/commonController/common_controller.dart';
import 'package:accountech/model/commonModels/business_type_model.dart';
import 'package:accountech/model/commonModels/industry_type_model.dart';
import 'package:accountech/model/commonModels/package_model.dart';
import 'package:accountech/model/commonModels/place_of_supply_model.dart';
import 'package:accountech/view/screens/authFolder/otp_screen.dart';
import 'package:accountech/view/screens/mainFolder/main_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../common/common_class.dart';
import '../../../widgets/textFieldWidgets/prefix_with_text_field_widget.dart';
import '../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class SignUpScreen extends StatefulWidget {
  static String signUpScreenRoute = "/SignUpScreen";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();
final StringFile _stringFile = StringFile();

final CommonController _commonController = CommonController();

//Account Information Variables
CroppedFile? _accountCroppedFile;
TextEditingController _accountNameController = TextEditingController();
TextEditingController _accountMobileNumberController = TextEditingController();
TextEditingController _accountEmailController = TextEditingController();
TextEditingController _accountPanNumberController = TextEditingController();

//Business Information Variables
CroppedFile? _businessCroppedFile;
TextEditingController _businessNameController = TextEditingController();
TextEditingController _businessCompanyPhoneNumberController =
    TextEditingController();
String _businessBusinessType = "";
List<String> _businessBusinessTypeSelected = [];
String _businessIndustryType = "";
List<String> _businessIndustryTypeSelected = [];
TextEditingController _businessBusinessAddress = TextEditingController();
TextEditingController _businessGSTNumber = TextEditingController();
String _businessPlaceOfSupply = "";
List<String> _businessPlaceOfSupplySelected = [];
int _selectedPlan = 0;

bool _haveGSTNumber = false;
late Future<BusinessTypeModel> _businessTypeModel;
late Future<IndustryTypeModel> _industryTypeModel;
late Future<PlaceOfSupplyModel> _placeOfSupplyModel;
late Future<PackageModel> _packageModel;

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
    _businessTypeModel = _commonController.getBusinessType();
    _industryTypeModel = _commonController.getIndustryType();
    _placeOfSupplyModel = _commonController.getPlaceOfSupply();
    _packageModel = _commonController.getPackages();

    _accountCroppedFile=null;
    _accountNameController.text="";
    _accountMobileNumberController .text="";
    _accountEmailController.text="";
    _accountPanNumberController .text="";

_businessCroppedFile=null;
    _businessNameController .text="";
    _businessCompanyPhoneNumberController .text="";
    _businessBusinessType="";
   _businessBusinessTypeSelected.clear();
    _businessIndustryType = "";
   _businessIndustryTypeSelected .clear();
    _businessBusinessAddress  .text="";
     _businessGSTNumber  .text="";
     _businessPlaceOfSupply = "";
   _businessPlaceOfSupplySelected.clear();
     _selectedPlan = 0;
  }

  int activeStep = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(CommonClass.headerHeight + 110),
            child: Container(
              color: _colorClass.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.asset(_commonClass.authSelectionBgTopLeft),
                      Positioned(
                        left: 20,
                        top: 20,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.arrowLeftLong,
                                    color: _colorClass.whiteColor,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  TextWidget(
                                      text: "Back",
                                      textStyle: _commonClass.getTextStyle(
                                          13,
                                          _colorClass.whiteColor,
                                          CommonClass.medium)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 65,
                        child: TextWidget(
                            text: "SignUp",
                            textStyle: _commonClass.getTextStyle(35,
                                _colorClass.whiteColor, CommonClass.medium)),
                      ),
                    ],
                  ),
                ],
              ),
            )),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  activeStep == 0
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(bottom: 5, right: 10),
                          child: Material(
                            color: _colorClass.mainBrandColor,
                            child: InkWell(
                              onTap: () {
                                if (activeStep == 2) {
                                  setState(() {
                                    activeStep = 1;
                                  });
                                } else if (activeStep == 1) {
                                  setState(() {
                                    activeStep = 0;
                                  });
                                } else {
                                  setState(() {
                                    activeStep = 0;
                                  });
                                }
                              },
                              splashColor: _colorClass.bgColor,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      child: TextWidget(
                                          text: "Previous",
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.whiteColor,
                                              CommonClass.semiBold))),
                                ],
                              ),
                            ),
                          ),
                        ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5, right: 10),
                    child: Material(
                      color: _colorClass.mainBrandColor,
                      child: activeStep == 2
                          ? InkWell(
                              onTap: () {
                                if (_selectedPlan == 0) {
                                  _commonClass.showMessage(
                                      context, "Please select any one plan");
                                } else {
                                  _commonClass.showLoader(context, true);

                                  AuthController authController =
                                      AuthController();
                                  authController
                                      .register(
                                          _accountNameController.text
                                              .toString(),
                                          _accountEmailController.text
                                              .toString(),
                                          _accountMobileNumberController.text
                                              .toString(),
                                          _accountPanNumberController.text
                                              .toString(),
                                          _businessNameController.text
                                              .toString(),
                                          _businessCompanyPhoneNumberController
                                              .text
                                              .toString(),
                                          _businessBusinessType,
                                          _businessIndustryType,
                                          _businessBusinessAddress.text
                                              .toString(),
                                          _businessGSTNumber.text.toString(),
                                          _businessPlaceOfSupply,
                                         _accountCroppedFile!=null?File(_accountCroppedFile!.path):null ,
                                          _businessCroppedFile!=null?
                                          File(_businessCroppedFile!.path)         :null,
                                          _selectedPlan.toString())
                                      .then((value) {
                                    _commonClass.showLoader(context, false);

                                    _commonClass.showMessage(
                                        context, value.message.toString());
                                    if (value.status != null) {
                                      if (value.status == 200) {
                                        // MySharedPreferences.userID.$ =
                                        //     value.data!.id!;
                                        // MySharedPreferences.accessToken.$ =
                                        //     value.data!.accessToken!;
                                        // MySharedPreferences.userName.$ =
                                        //     value.data!.name!;
                                        Navigator.pushNamed(
                                            context, OTPScreen.oTPScreenRoute,
                                            arguments: {
                                              "mobile_number":
                                                  _accountMobileNumberController.text
                                                      .toString(),
                                              "type": _commonClass.otpType[0]
                                            });
                                      }
                                    }
                                  });
                                }
                              },
                              splashColor: _colorClass.bgColor,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      child: TextWidget(
                                          text: "Submit",
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.whiteColor,
                                              CommonClass.semiBold))),
                                ],
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                if (activeStep == 0) {
                                  // if (_accountCroppedFile == null) {
                                  //   _commonClass.showMessage(
                                  //       context, "Please add image first");
                                  // } else
                                  //
                                    if (_accountNameController
                                          .text.isEmpty ||
                                      _accountNameController.text.length <= 3) {
                                    _commonClass.showMessage(
                                        context, "Please enter valid name");
                                  } else if (_accountMobileNumberController
                                          .text.isEmpty ||
                                      _accountMobileNumberController
                                              .text.length <
                                          10) {
                                    _commonClass.showMessage(context,
                                        "Please enter a valid mobile number");
                                  } else if (!_commonClass.getEmailValidation(
                                      _accountEmailController.text)) {
                                    _commonClass.showMessage(
                                        context, "Please enter a valid email");
                                  } else if (_accountPanNumberController
                                      .text.isNotEmpty) {
                                    if (!_commonClass.getPanValidation(
                                        _accountPanNumberController.text)) {
                                      _commonClass.showMessage(context,
                                          "Please enter a valid pan number");
                                    }
                                  } else {
                                    _commonClass.showLoader(context, true);

                                    AuthController authController =
                                        AuthController();
                                    authController
                                        .checkUser(
                                      _accountMobileNumberController.text
                                          .toString(),
                                      _accountEmailController.text.toString(),
                                    )
                                        .then((value) {
                                      _commonClass.showLoader(context, false);
                                      _commonClass.pleaseMakeFocusOut();
                                      if (value.status != null) {
                                        if (value.data != null) {
                                          setState(() {
                                            activeStep = 1;
                                          });
                                        } else {
                                          _commonClass.showMessage(context,
                                              value.message.toString());
                                        }
                                      }
                                    });
                                  }
                                } else if (activeStep == 1) {
                                  // if (_businessCroppedFile == null) {
                                  //   _commonClass.showMessage(
                                  //       context, "Please add image first");
                                  // } else

                                    if (_businessNameController
                                          .text.isEmpty ||
                                      _accountNameController.text.length <= 3) {
                                    _commonClass.showMessage(
                                        context, "Please enter valid name");
                                  } else if (_businessCompanyPhoneNumberController
                                          .text.isEmpty ||
                                      _accountMobileNumberController
                                              .text.length <
                                          10) {
                                    _commonClass.showMessage(context,
                                        "Please enter a valid mobile number");
                                  } else if (_businessBusinessType.isEmpty) {
                                    _commonClass.showMessage(context,
                                        "Please select at least one business type");
                                  } else if (_businessIndustryType.isEmpty) {
                                    _commonClass.showMessage(
                                        context, "Please select industry type");
                                  } else if (_businessBusinessAddress.text
                                      .toString()
                                      .isEmpty) {
                                    _commonClass.showMessage(
                                        context, "Please enter address");
                                  } else if (_haveGSTNumber &&
                                      _businessGSTNumber.text.isEmpty) {
                                    _commonClass.showMessage(
                                        context, "Please enter GST Number");
                                  } else if (_businessPlaceOfSupply.isEmpty) {
                                    _commonClass.showMessage(context,
                                        "Please select place of supply");
                                  } else {
                                    _commonClass.pleaseMakeFocusOut();
                                    setState(() {
                                      activeStep = 2;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    activeStep = 0;
                                  });
                                }
                              },
                              splashColor: _colorClass.bgColor,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      child: TextWidget(
                                          text: "Next",
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.whiteColor,
                                              CommonClass.semiBold))),
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
        body: SizedBox(
          width: _commonClass.getScreenWidth(context),
          height: _commonClass.getScreenHeight(context),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20, top: 50, right: 20),
                    child: returnStep()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget returnStep() {
    if (activeStep == 0) {
      return const AccountDetailStep();
    } else if (activeStep == 1) {
      return const BusinessDetailStep();
    } else if (activeStep == 2) {
      return const BillingDetailStep();
    } else {
      return Container();
    }
  }
}

class AccountDetailStep extends StatefulWidget {
  const AccountDetailStep({Key? key}) : super(key: key);

  @override
  State<AccountDetailStep> createState() => _AccountDetailStepState();
}

class _AccountDetailStepState extends State<AccountDetailStep> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: _colorClass.mainBrandColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                FontAwesomeIcons.house,
                size: 15,
                color: _colorClass.whiteColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                      text: "Account",
                      textStyle: _commonClass.getTextStyle(
                          15, _colorClass.mainBrandColor, CommonClass.medium)),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                      text: "Account Details",
                      textStyle: _commonClass.getTextStyle(
                          15, _colorClass.greyColor, CommonClass.medium)),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        TextWidget(
            text: "Account Information",
            textStyle: _commonClass.getTextStyle(
                20, _colorClass.blackColor, CommonClass.semiBold)),
        TextWidget(
            text: "Enter Your Account Details",
            textStyle: _commonClass.getTextStyle(
                12, _colorClass.greyColor, CommonClass.semiBold)),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: _accountCroppedFile != null
                          ? Image.file(
                              File(_accountCroppedFile!.path.toString()),
                              fit: BoxFit.contain,
                            )
                          : Image.asset(
                              _commonClass.noImageAvailable,
                              fit: BoxFit.cover,
                            )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Material(
                          color: _colorClass.mainBrandColor,
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(2),
                          child: InkWell(
                            splashColor: _colorClass.mainBrandColor,
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions:
                                    _commonClass.allowedExtensions,
                              );

                              if (result != null) {
                                _accountCroppedFile =
                                    await _commonClass.getCroppedImage(result);
                                setState(() {});
                              } else {
                                // User canceled the picker
                              }
                            },
                            child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Icon(
                                  FontAwesomeIcons.upload,
                                  color: _colorClass.whiteColor,
                                  size: 20,
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Material(
                          color: _colorClass.bgColor,
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(2),
                          child: InkWell(
                            splashColor: _colorClass.bgColor,
                            onTap: () {
                              setState(() {
                                _accountCroppedFile = null;
                              });
                            },
                            child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: const Icon(
                                  FontAwesomeIcons.arrowRotateRight,
                                  color: Color(0xff69809a),
                                  size: 20,
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextWidget(
                        text: "Allowed JPG, GIF or PNG. Max size of 800K",
                        overflow: TextOverflow.visible,
                        textStyle: _commonClass.getTextStyle(
                            10, _colorClass.blackColor, CommonClass.regular)),
                  ],
                )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
                myTextInputAction: TextInputAction.next,
                textEditingController: _accountNameController,
                maxLength: null,
                type: TextInputType.text,
                formatter: null,
                text: _stringFile.name,
                onTypeCallBack: (e) {}),
            const SizedBox(
              height: 15,
            ),
            PrefixWithTextFieldWidget(
                myTextInputAction: TextInputAction.next,
                hasPrefix: "+91",
                textEditingController: _accountMobileNumberController,
                maxLength: 10,
                type: TextInputType.number,
                formatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                text: _stringFile.mobileNumber,
                onTypeCallBack: (e) {}),
            const SizedBox(
              height: 15,
            ),
            TextFieldWidget(
                myTextInputAction: TextInputAction.next,
                textEditingController: _accountEmailController,
                maxLength: null,
                type: TextInputType.text,
                formatter: null,
                text: _stringFile.email,
                onTypeCallBack: (e) {}),
            const SizedBox(
              height: 15,
            ),
            TextFieldWidget(
                myTextInputAction: TextInputAction.done,
                hasUpperCase: true,
                textEditingController: _accountPanNumberController,
                maxLength: 10,
                type: TextInputType.text,
                formatter: null,
                text: _stringFile.panNumberOptional,
                onTypeCallBack: (e) {
                  setState(() {
                    _accountPanNumberController.text.toUpperCase();
                  });
                }),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class BusinessDetailStep extends StatefulWidget {
  const BusinessDetailStep({Key? key}) : super(key: key);

  @override
  State<BusinessDetailStep> createState() => _BusinessDetailStepState();
}

class _BusinessDetailStepState extends State<BusinessDetailStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: _colorClass.mainBrandColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                FontAwesomeIcons.user,
                size: 15,
                color: _colorClass.whiteColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                      text: "Business",
                      textStyle: _commonClass.getTextStyle(
                          15, _colorClass.mainBrandColor, CommonClass.medium)),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                      text: "Enter Information",
                      textStyle: _commonClass.getTextStyle(
                          15, _colorClass.greyColor, CommonClass.medium)),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        TextWidget(
            text: "Business Information",
            textStyle: _commonClass.getTextStyle(
                20, _colorClass.blackColor, CommonClass.semiBold)),
        TextWidget(
            text: "Enter Your Personal Information",
            textStyle: _commonClass.getTextStyle(
                12, _colorClass.greyColor, CommonClass.semiBold)),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: _businessCroppedFile != null
                      ? Image.file(
                          File(_businessCroppedFile!.path),
                          fit: BoxFit.contain,
                        )
                      : Image.asset(
                          _commonClass.noImageAvailable,
                          fit: BoxFit.cover,
                        )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Material(
                      color: _colorClass.mainBrandColor,
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(2),
                      child: InkWell(
                        splashColor: _colorClass.mainBrandColor,
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: _commonClass.allowedExtensions,
                          );

                          if (result != null) {
                            _businessCroppedFile =
                                await _commonClass.getCroppedImage(result);
                            setState(() {});
                          } else {
                            // User canceled the picker
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Icon(
                              FontAwesomeIcons.upload,
                              color: _colorClass.whiteColor,
                              size: 20,
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Material(
                      color: _colorClass.bgColor,
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(2),
                      child: InkWell(
                        splashColor: _colorClass.bgColor,
                        onTap: () {
                          setState(() {
                            _businessCroppedFile = null;
                          });
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: const Icon(
                              FontAwesomeIcons.arrowRotateRight,
                              color: Color(0xff69809a),
                              size: 20,
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                    text: "Allowed JPG, GIF or PNG. Max size of 800K",
                    overflow: TextOverflow.visible,
                    textStyle: _commonClass.getTextStyle(
                        10, _colorClass.blackColor, CommonClass.regular)),
              ],
            )),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFieldWidget(
            myTextInputAction: TextInputAction.next,
            textEditingController: _businessNameController,
            maxLength: null,
            type: TextInputType.text,
            formatter: null,
            text: "Business Name",
            onTypeCallBack: (e) {}),
        const SizedBox(
          height: 15,
        ),
        PrefixWithTextFieldWidget(
            myTextInputAction: TextInputAction.next,
            textEditingController: _businessCompanyPhoneNumberController,
            maxLength: 10,
            type: TextInputType.number,
            formatter: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            text: "Company Phone Number",
            onTypeCallBack: (e) {}),
        const SizedBox(
          height: 5,
        ),
        FutureBuilder<BusinessTypeModel>(
          future: _businessTypeModel, // async work
          builder: (BuildContext context,
              AsyncSnapshot<BusinessTypeModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Text('Loading....');
              default:
                if (snapshot.hasError) {
                  return const Text('Error: getting business type');
                } else {
                  List<String> _types = [];
                  _types.addAll(snapshot.data!.data.map((e) => e.businessType));
                  return DropdownSearch<String>.multiSelection(
                      popupProps: PopupPropsMultiSelection.modalBottomSheet(
                        showSearchBox: true,
                      ),
                      items: [..._types],
                      onChanged: (data) {
                        List<String> _typesID = [];
                        _typesID.addAll(
                            data.map((e) => _types.indexOf(e).toString()));

                        _businessBusinessType = _typesID.join(",");
                        _businessBusinessTypeSelected.clear();
                        _businessBusinessTypeSelected.addAll(data);
                        setState(() {});
                      },
            dropdownDecoratorProps:DropDownDecoratorProps(dropdownSearchDecoration: InputDecoration(
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
                        labelText: "Business Type",
                      )),
                      selectedItems: _businessBusinessTypeSelected);
                }
            }
          },
        ),
        const SizedBox(
          height: 15,
        ),
        FutureBuilder<IndustryTypeModel>(
          future: _industryTypeModel, // async work
          builder: (BuildContext context,
              AsyncSnapshot<IndustryTypeModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Text('Loading....');
              default:
                if (snapshot.hasError) {
                  return const Text('Error: getting industry type');
                } else {
                  List<String> _types = [];
                  List<String> _typesID = [];
                  _types.addAll(snapshot.data!.data.map((e) => e.industryType));
                  _typesID
                      .addAll(snapshot.data!.data.map((e) => e.id.toString()));
                  return DropdownSearch<String>(
                    popupProps: const PopupProps.modalBottomSheet(
                      showSearchBox: true,
                    ),
                    items: [..._types],
                    onChanged: (data) {
                      _businessIndustryType =
                          _typesID[_types.indexOf(data.toString())];
                      _businessIndustryTypeSelected.clear();
                      _businessIndustryTypeSelected.add(data.toString());
                      setState(() {});
                    },
            dropdownDecoratorProps:DropDownDecoratorProps(dropdownSearchDecoration: InputDecoration(
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
                      labelText: "Industry Type",
                    )),
                    selectedItem: _businessIndustryTypeSelected.isEmpty
                        ? null
                        : _businessIndustryTypeSelected.first,
                  );
                }
            }
          },
        ),
        const SizedBox(
          height: 15,
        ),
        TextFieldWidget(
            myTextInputAction: TextInputAction.next,
            textEditingController: _businessBusinessAddress,
            maxLength: null,
            type: TextInputType.text,
            formatter: null,
            text: "Business Address",
            onTypeCallBack: (e) {}),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextWidget(
              text: "Are You GST Registered?",
              textStyle: _commonClass.getTextStyle(
                  15, _colorClass.blackColor, CommonClass.medium),
            ),
            FlutterSwitch(
              activeColor: _colorClass.secondaryBrandColor,
              height: 20,
              toggleSize: 10,
              width: 40,
              value: _haveGSTNumber,
              onToggle: (val) {
                setState(() {
                  _haveGSTNumber = val;
                });
              },
            ),
          ],
        ),
        _haveGSTNumber
            ? Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                      myTextInputAction: TextInputAction.done,
                      textEditingController: _businessGSTNumber,
                      maxLength: null,
                      type: TextInputType.text,
                      formatter: null,
                      text: "GST Number",
                      onTypeCallBack: (e) {}),
                ],
              )
            : Container(),
        const SizedBox(
          height: 15,
        ),
        FutureBuilder<PlaceOfSupplyModel>(
          future: _placeOfSupplyModel, // async work
          builder: (BuildContext context,
              AsyncSnapshot<PlaceOfSupplyModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Text('Loading....');
              default:
                if (snapshot.hasError) {
                  return const Text('Error: getting place of supply');
                } else {
                  List<String> _types = [];
                  List<String> _typesID = [];
                  _types.addAll(snapshot.data!.data.map((e) => e.placeName));
                  _typesID
                      .addAll(snapshot.data!.data.map((e) => e.id.toString()));
                  return DropdownSearch<String>(
                    popupProps: const PopupProps.modalBottomSheet(
                      showSearchBox: true,
                    ),
                    items: [..._types],
                    onChanged: (data) {
                      _businessPlaceOfSupply =
                          _typesID[_types.indexOf(data.toString())];
                      _businessPlaceOfSupplySelected.clear();
                      _businessPlaceOfSupplySelected.add(data.toString());
                      setState(() {});
                    },
            dropdownDecoratorProps:DropDownDecoratorProps(dropdownSearchDecoration: InputDecoration(
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
                      labelText: "Place Of Supply",
                    )),
                    selectedItem: _businessPlaceOfSupplySelected.isEmpty
                        ? null
                        : _businessPlaceOfSupplySelected.first,
                  );
                }
            }
          },
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class BillingDetailStep extends StatefulWidget {
  const BillingDetailStep({Key? key}) : super(key: key);

  @override
  State<BillingDetailStep> createState() => _BillingDetailStepState();
}

class _BillingDetailStepState extends State<BillingDetailStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: _colorClass.mainBrandColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                FontAwesomeIcons.sackDollar,
                size: 15,
                color: _colorClass.whiteColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                      text: "Billing",
                      textStyle: _commonClass.getTextStyle(
                          15, _colorClass.mainBrandColor, CommonClass.medium)),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                      text: "Payment Details",
                      textStyle: _commonClass.getTextStyle(
                          15, _colorClass.greyColor, CommonClass.medium)),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        TextWidget(
            text: "Select Plan",
            textStyle: _commonClass.getTextStyle(
                20, _colorClass.blackColor, CommonClass.semiBold)),
        TextWidget(
            text: "Select plan as per your requirement",
            textStyle: _commonClass.getTextStyle(
                12, _colorClass.greyColor, CommonClass.semiBold)),
        const SizedBox(
          height: 20,
        ),
        FutureBuilder<PackageModel>(
          future: _packageModel, // async work
          builder:
              (BuildContext context, AsyncSnapshot<PackageModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Text('Loading....');
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  PackageModel packageModel = snapshot.data!;
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: packageModel.data.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (c, i) {
                        return InkWell(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 200,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: _colorClass.greyColor, width: 1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                    text: packageModel.data[i].packageName
                                        .toString(),
                                    textStyle: _commonClass.getTextStyle(
                                        15,
                                        _colorClass.blackColor,
                                        CommonClass.semiBold)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                    overflow: TextOverflow.visible,
                                    text: packageModel
                                        .data[i].packageDescription
                                        .toString(),
                                    textStyle: _commonClass.getTextStyle(
                                        12,
                                        _colorClass.greyColor,
                                        CommonClass.regular)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                      text: packageModel.data[i].packageAmount
                                          .toString(),
                                      textStyle: _commonClass.getTextStyle(
                                          20,
                                          _colorClass.secondaryBrandColor,
                                          CommonClass.semiBold),
                                    ),
                                    TextWidget(
                                      text:
                                          "/ ${packageModel.data[i].packageType.toUpperCase()}",
                                      textStyle: _commonClass.getTextStyle(
                                          15,
                                          _colorClass.blackColor,
                                          CommonClass.semiBold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _selectedPlan ==
                                              packageModel.data[i].packageId
                                          ? _colorClass.mainBrandColor
                                          : null,
                                      border: Border.all(
                                          width: 1.5,
                                          color: _colorClass.mainBrandColor)),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedPlan = packageModel.data[i].packageId;
                            });
                          },
                        );
                      },
                    ),
                  );
                }
            }
          },
        ),
      ],
    );
  }
}
