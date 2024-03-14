import 'dart:io';

import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/my_shared_preferences.dart';
import 'package:accountech/controller/accountController/account_controller.dart';
import 'package:accountech/view/screens/authFolder/deactivated_screen.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:expandable/expandable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../common/color_class.dart';
import '../../../../common/string_file.dart';
import '../../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../../widgets/textWidgets/text_widget.dart';

class AccountSettingsScreen extends StatefulWidget {
  static String accountSettingsScreenRoute = "/AccountSettingsScreen";

  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

final ColorClass _colorClass = ColorClass();
final StringFile _stringFile = StringFile();
final CommonClass _commonClass = CommonClass();

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final AccountController _accountController = AccountController();

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _mobileNumberTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _panNumberTextEditingController =
      TextEditingController();
  String _image = "";
  CroppedFile? _accountCroppedFile;
  final bool _fetched = false;
  bool? _deleteAccount = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(CommonClass.headerHeight),
            child: Container(
              color: _colorClass.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonAppBarWidget(
                    title: TextWidget(
                      text: _stringFile.accountSettings,
                      textStyle: _commonClass.getTextStyle(
                          20, _colorClass.blackColor, CommonClass.semiBold),
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
          child: FutureBuilder<dynamic>(
            future: _accountController.getProfile(),
            builder: (context, snapshot) {
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
                dynamic value = snapshot.data;
                if (value.status != null) {
                  if (value.status == 200 && value.data != null) {
                    if (!_fetched) {
                      _nameTextEditingController.text = value.data.name ?? "";
                      _mobileNumberTextEditingController.text =
                          value.data.mobileNo == null
                              ? ""
                              : value.data.mobileNo.toString();
                      _emailTextEditingController.text = value.data.email ?? "";
                      _panNumberTextEditingController.text =
                          value.data.panNo ?? "";
                      _image = value.data.profileImage ?? "";
                    }
                  }
                }
                return Container(
                  color:
                      _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: _commonClass.getScreenWidth(context),
                          child: Card(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          height: 120,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              clipBehavior: Clip.hardEdge,
                                              child: _accountCroppedFile == null
                                                  ? _image.isEmpty
                                                      ? Image.asset(
                                                          _commonClass
                                                              .noImageAvailable,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.network(
                                                          _commonClass
                                                                  .assetURL +
                                                              _image,
                                                          fit: BoxFit.cover,
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
                                                                height: 100,
                                                                width: 100,
                                                                child: Lottie.asset(
                                                                    _commonClass
                                                                        .myLoader,
                                                                    fit: BoxFit
                                                                        .cover),
                                                              ),
                                                            );
                                                          },
                                                        )
                                                  : Image.file(
                                                      File(_accountCroppedFile!
                                                          .path),
                                                      fit: BoxFit.cover,
                                                    )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Material(
                                                  color: _colorClass
                                                      .mainBrandColor,
                                                  clipBehavior: Clip.hardEdge,
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  child: InkWell(
                                                    splashColor: _colorClass
                                                        .mainBrandColor,
                                                    onTap: () async {
                                                      FilePickerResult? result =
                                                          await FilePicker
                                                              .platform
                                                              .pickFiles(
                                                        type: FileType.custom,
                                                        allowedExtensions:
                                                            _commonClass
                                                                .allowedExtensions,
                                                      );

                                                      if (result != null) {
                                                        _accountCroppedFile =
                                                            await _commonClass
                                                                .getCroppedImage(
                                                                    result);
                                                        setState(() {});
                                                      } else {
                                                        _accountCroppedFile =
                                                            null;
                                                        // User canceled the picker
                                                      }
                                                    },
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10,
                                                                horizontal: 20),
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .upload,
                                                          color: _colorClass
                                                              .whiteColor,
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
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  child: InkWell(
                                                    splashColor:
                                                        _colorClass.bgColor,
                                                    onTap: () {
                                                      setState(() {
                                                        _accountCroppedFile =
                                                            null;
                                                      });
                                                    },
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10,
                                                                horizontal: 10),
                                                        child: const Icon(
                                                          FontAwesomeIcons
                                                              .arrowRotateRight,
                                                          color:
                                                              Color(0xff69809a),
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
                                                text:
                                                    "Allowed JPG, GIF or PNG. Max size of 800K",
                                                overflow: TextOverflow.visible,
                                                textStyle:
                                                    _commonClass.getTextStyle(
                                                        10,
                                                        _colorClass.blackColor,
                                                        CommonClass.regular)),
                                          ],
                                        )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFieldWidget(
                                      myTextInputAction: TextInputAction.next,
                                        textEditingController:
                                            _nameTextEditingController,
                                        maxLength: null,
                                        type: TextInputType.text,
                                        formatter: null,
                                        text: _stringFile.name,
                                        onTypeCallBack: (e) {}),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFieldWidget(                                      myTextInputAction: TextInputAction.next,

                                        textEditingController:
                                            _mobileNumberTextEditingController,
                                        maxLength: null,
                                        enabled: false,
                                        type: TextInputType.number,
                                        formatter: null,
                                        text: _stringFile.mobileNumber,
                                        onTypeCallBack: (e) {}),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFieldWidget(                                      myTextInputAction: TextInputAction.next,

                                        enabled: false,
                                        maxLength: null,
                                        textEditingController:
                                            _emailTextEditingController,
                                        type: TextInputType.text,
                                        formatter: null,
                                        text: _stringFile.email,
                                        onTypeCallBack: (e) {}),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFieldWidget(                                      myTextInputAction: TextInputAction.done,

                                        textEditingController:
                                            _panNumberTextEditingController,
                                        maxLength: null,
                                        type: TextInputType.text,
                                        formatter: null,
                                        text: _stringFile.panNumberOptional,
                                        onTypeCallBack: (e) {}),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Material(
                                      color: _colorClass.mainBrandColor,
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.circular(2),
                                      child: InkWell(
                                        splashColor: _colorClass.mainBrandColor,
                                        onTap: () {
                                          if (_nameTextEditingController
                                                  .text.isEmpty ||
                                              _nameTextEditingController
                                                      .text.length <=
                                                  3) {
                                            _commonClass.showMessage(context,
                                                "Please enter valid name");
                                          } else if (_panNumberTextEditingController
                                              .text.isNotEmpty) {
                                            if (!_commonClass.getPanValidation(
                                                _panNumberTextEditingController
                                                    .text)) {
                                              _commonClass.showMessage(context,
                                                  "Please enter a valid pan number");
                                            }
                                          } else {
                                            _commonClass.showLoader(
                                                context, true);


                                            _accountController
                                                .editProfile(
                                                    _nameTextEditingController
                                                        .text
                                                        .toString(),
                                                    _panNumberTextEditingController
                                                        .text
                                                        .toString(),
                                                    _accountCroppedFile != null
                                                        ? File(
                                                            _accountCroppedFile!
                                                                .path)
                                                        : null)
                                                .then((value) {
                                              _commonClass.showLoader(
                                                  context, false);
                                              _commonClass.pleaseMakeFocusOut();
                                              if (value.status != null) {
                                                if (value.data != null) {
                                                  _commonClass.showMessage(
                                                      context,
                                                      value.message.toString());

                                                  MySharedPreferences.userName.$ =    _nameTextEditingController.text;

                                                } else {
                                                  _commonClass.showMessage(
                                                      context,
                                                      value.message.toString());
                                                }
                                              }
                                            });
                                          }
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 5),
                                            child: TextWidget(
                                                text: "Save Details",
                                                textStyle:
                                                    _commonClass.getTextStyle(
                                                        15,
                                                        _colorClass.whiteColor,
                                                        CommonClass.semiBold))),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          width: _commonClass.getScreenWidth(context),
                          child: Card(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Material(
                                            color: _colorClass.mainBrandColor
                                                .withAlpha(
                                                    CommonClass.bgAlpha + 20),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                              child: TextWidget(
                                                  text: "Standard",
                                                  textStyle:
                                                      _commonClass.getTextStyle(
                                                          10,
                                                          _colorClass
                                                              .mainBrandColor,
                                                          CommonClass
                                                              .semiBold)),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              TextWidget(
                                                  text: "₹",
                                                  textStyle:
                                                      _commonClass.getTextStyle(
                                                          25,
                                                          _colorClass
                                                              .mainBrandColor,
                                                          CommonClass
                                                              .semiBold)),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              TextWidget(
                                                  text: "99",
                                                  textStyle:
                                                      _commonClass.getTextStyle(
                                                          30,
                                                          _colorClass
                                                              .mainBrandColor,
                                                          CommonClass
                                                              .semiBold)),
                                              TextWidget(
                                                  text: "/",
                                                  textStyle:
                                                      _commonClass.getTextStyle(
                                                          20,
                                                          _colorClass.greyColor,
                                                          CommonClass
                                                              .semiBold)),
                                              TextWidget(
                                                  text: "month",
                                                  textStyle:
                                                      _commonClass.getTextStyle(
                                                          15,
                                                          _colorClass.greyColor,
                                                          CommonClass
                                                              .semiBold)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          _colorClass.greyColor,
                                                      shape: BoxShape.circle),
                                                  height: 5,
                                                  width: 5,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: TextWidget(
                                                      text: "10 Users",
                                                      textStyle: _commonClass
                                                          .getTextStyle(
                                                              10,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .semiBold)),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          _colorClass.greyColor,
                                                      shape: BoxShape.circle),
                                                  height: 5,
                                                  width: 5,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: TextWidget(
                                                      text:
                                                          "Up to 10 GB storage",
                                                      textStyle: _commonClass
                                                          .getTextStyle(
                                                              10,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .semiBold)),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          _colorClass.greyColor,
                                                      shape: BoxShape.circle),
                                                  height: 5,
                                                  width: 5,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: TextWidget(
                                                      text: "Basic Support",
                                                      textStyle: _commonClass
                                                          .getTextStyle(
                                                              10,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .semiBold)),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                TextWidget(
                                                    text: "Days",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            12,
                                                            _colorClass
                                                                .blackColor,
                                                            CommonClass
                                                                .semiBold)),
                                                const Spacer(),
                                                TextWidget(
                                                    text: "65% Complete",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            12,
                                                            _colorClass
                                                                .blackColor,
                                                            CommonClass
                                                                .semiBold)),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            LinearPercentIndicator(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              lineHeight: 8,
                                              animation: true,
                                              percent: 0.5,
                                              progressColor: _colorClass
                                                  .secondaryBrandColor,
                                              barRadius:
                                                  const Radius.circular(10),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextWidget(
                                                      text: "4 days remaining",
                                                      textStyle: _commonClass
                                                          .getTextStyle(
                                                              12,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .regular)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Material(
                                      color: _colorClass.mainBrandColor,
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.circular(2),
                                      child: InkWell(
                                        splashColor: _colorClass.mainBrandColor,
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (c) {
                                                return StatefulBuilder(builder:
                                                    (context,
                                                        bottomSheetSetState) {
                                                  return const UpgradePlanBottomSheet();
                                                });
                                              });
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 5),
                                            child: TextWidget(
                                                text: "Upgrade Plan",
                                                textStyle:
                                                    _commonClass.getTextStyle(
                                                        12,
                                                        _colorClass.whiteColor,
                                                        CommonClass.semiBold))),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          width: _commonClass.getScreenWidth(context),
                          child: Card(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: TextWidget(
                                          text: "Delete Account",
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.blackColor,
                                              CommonClass.bold)),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Container(
                                            decoration: const BoxDecoration(
                                              color: Color(0xfffff2e1),
                                            ),
                                            child: Container(
                                              width: _commonClass
                                                  .getScreenWidth(context),
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  TextWidget(
                                                      overflow:
                                                          TextOverflow.visible,
                                                      text:
                                                          "Are you sure you want to delete your account?",
                                                      textStyle: _commonClass
                                                          .getTextStyle(
                                                              13,
                                                              const Color(
                                                                  0xfffdac41),
                                                              CommonClass
                                                                  .semiBold)),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextWidget(
                                                      overflow:
                                                          TextOverflow.visible,
                                                      text:
                                                          "Once you delete your account, there is no going back. Please be certain.",
                                                      textStyle: _commonClass
                                                          .getTextStyle(
                                                              13,
                                                              const Color(
                                                                  0xfffdac41),
                                                              CommonClass
                                                                  .regular)),
                                                ],
                                              ),
                                            ))),
                                    CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 0),
                                      activeColor: _colorClass.redColor,
                                      value: _deleteAccount,
                                      onChanged: (value) {
                                        setState(() {
                                          _deleteAccount = value;
                                        });
                                      },
                                      title: TextWidget(
                                        text:
                                            "I confirm my account deactivation",
                                        textStyle: _commonClass.getTextStyle(
                                            12,
                                            _colorClass.blackColor,
                                            CommonClass.regular),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Material(
                                          color: _colorClass.redColor,
                                          clipBehavior: Clip.hardEdge,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          child: InkWell(
                                            splashColor: _colorClass.redColor,
                                            onTap: () {
                                              if(_deleteAccount!=null && _deleteAccount==true)
                                              {
                                                // _commonClass.showCustomDialog(
                                                //     context, "title", "body", () {
                                                //   Navigator.pop(context);
                                                //
                                                // });


                                                _commonClass.showLoader(
                                                    context, true);


                                                _accountController
                                                    .deleteProfile(
                                              )
                                                    .then((value) {
                                                  _commonClass.showLoader(
                                                      context, false);
                                                  _commonClass.pleaseMakeFocusOut();
                                                  if (value.status != null) {
                                                    if (value.data != null) {
                                                      _commonClass.showMessage(
                                                          context,
                                                          value.message.toString());


                                                      MySharedPreferences.userID.$ =
                                                      0;
                                                      MySharedPreferences.accessToken.$ =
                                                      "";
                                                      MySharedPreferences.userName.$ =
                                                      "";
                                                      Navigator.pushNamedAndRemoveUntil(
                                                          context, DeactivatedScreen.deactivatedScreenRoute,
                                                            (Route<dynamic> route)=>false
,
                                                        arguments: {
                                                            "mobile_number":
                                                            _mobileNumberTextEditingController.text
                                                                .toString(),
                                                            "type": _commonClass.otpType[2],
                                                            "name": _nameTextEditingController.text.toString(),
                                                            "back":false,

                                                          },

                                                      );

                                                    } else {
                                                      _commonClass.showMessage(
                                                          context,
                                                          value.message.toString());
                                                    }
                                                  }
                                                });
                                              }
                                              else{
                                                _commonClass.showMessage(context, "Please check the condition first.\nI CONFIRM MY ACCOUNT DEACTIVATION ");
                                              }

                                            },
                                            child: Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                child: TextWidget(
                                                    text: "Deactivate Account",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            12,
                                                            _colorClass
                                                                .whiteColor,
                                                            CommonClass
                                                                .regular))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class UpgradePlanBottomSheet extends StatefulWidget {
  const UpgradePlanBottomSheet({Key? key}) : super(key: key);

  @override
  State<UpgradePlanBottomSheet> createState() => _UpgradePlanBottomSheetState();
}

class _UpgradePlanBottomSheetState extends State<UpgradePlanBottomSheet> {
  int planChoosed = 0;

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
                          text: "Upgrade Plan",
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
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                            text: "Select Plan",
                            textStyle: _commonClass.getTextStyle(20,
                                _colorClass.blackColor, CommonClass.semiBold)),
                        TextWidget(
                            text: "Select plan as per your requirement",
                            textStyle: _commonClass.getTextStyle(12,
                                _colorClass.greyColor, CommonClass.semiBold)),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              InkWell(
                                child: Container(
                                  width: 200,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: _colorClass.greyColor,
                                          width: 1)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextWidget(
                                          text: "Diamond Plan",
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.blackColor,
                                              CommonClass.semiBold)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextWidget(
                                          overflow: TextOverflow.visible,
                                          text:
                                              "A simple start for start ups and small businesses",
                                          textStyle: _commonClass.getTextStyle(
                                              12,
                                              _colorClass.greyColor,
                                              CommonClass.regular)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextWidget(
                                            text: "₹ 142",
                                            textStyle:
                                                _commonClass.getTextStyle(
                                                    20,
                                                    _colorClass
                                                        .secondaryBrandColor,
                                                    CommonClass.semiBold),
                                          ),
                                          TextWidget(
                                            text: "/ MONTH",
                                            textStyle:
                                                _commonClass.getTextStyle(
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
                                            color: planChoosed == 0
                                                ? _colorClass.mainBrandColor
                                                : null,
                                            border: Border.all(
                                                width: 1.5,
                                                color: _colorClass
                                                    .mainBrandColor)),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    planChoosed = 0;
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    planChoosed = 1;
                                  });
                                },
                                child: Container(
                                  width: 200,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: _colorClass.greyColor,
                                          width: 1)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextWidget(
                                          text: "Platinum Plan",
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.blackColor,
                                              CommonClass.semiBold)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextWidget(
                                          overflow: TextOverflow.visible,
                                          text:
                                              "For small to medium businesses",
                                          textStyle: _commonClass.getTextStyle(
                                              12,
                                              _colorClass.greyColor,
                                              CommonClass.regular)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextWidget(
                                            text: "₹ 242",
                                            textStyle:
                                                _commonClass.getTextStyle(
                                                    20,
                                                    _colorClass
                                                        .secondaryBrandColor,
                                                    CommonClass.semiBold),
                                          ),
                                          TextWidget(
                                            text: "/ MONTH",
                                            textStyle:
                                                _commonClass.getTextStyle(
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
                                            color: planChoosed == 1
                                                ? _colorClass.mainBrandColor
                                                : null,
                                            border: Border.all(
                                                width: 1.5,
                                                color: _colorClass
                                                    .mainBrandColor)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    planChoosed = 2;
                                  });
                                },
                                child: Container(
                                  width: 200,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: _colorClass.greyColor,
                                          width: 1)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextWidget(
                                          text: "Enterprise Plan",
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.blackColor,
                                              CommonClass.semiBold)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextWidget(
                                          overflow: TextOverflow.visible,
                                          text:
                                              "Solution for huge enterprise & organizations ",
                                          textStyle: _commonClass.getTextStyle(
                                              12,
                                              _colorClass.greyColor,
                                              CommonClass.regular)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextWidget(
                                            text: "₹ 500",
                                            textStyle:
                                                _commonClass.getTextStyle(
                                                    20,
                                                    _colorClass
                                                        .secondaryBrandColor,
                                                    CommonClass.semiBold),
                                          ),
                                          TextWidget(
                                            text: "/ MONTH",
                                            textStyle:
                                                _commonClass.getTextStyle(
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
                                            color: planChoosed == 2
                                                ? _colorClass.mainBrandColor
                                                : null,
                                            border: Border.all(
                                                width: 1.5,
                                                color: _colorClass
                                                    .mainBrandColor)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Material(
                              color: _colorClass.mainBrandColor,
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(2),
                              child: InkWell(
                                splashColor: _colorClass.mainBrandColor,
                                onTap: () {},
                                child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: TextWidget(
                                        text: "Upgrade",
                                        textStyle: _commonClass.getTextStyle(
                                            12,
                                            _colorClass.whiteColor,
                                            CommonClass.semiBold))),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: _colorClass.greyColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  text: "User Current plan is standard plan",
                                  textStyle: _commonClass.getTextStyle(
                                      12,
                                      _colorClass.blackColor,
                                      CommonClass.semiBold)),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  TextWidget(
                                      text: "₹",
                                      textStyle: _commonClass.getTextStyle(
                                          25,
                                          _colorClass.mainBrandColor,
                                          CommonClass.semiBold)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  TextWidget(
                                      text: "99",
                                      textStyle: _commonClass.getTextStyle(
                                          30,
                                          _colorClass.mainBrandColor,
                                          CommonClass.semiBold)),
                                  TextWidget(
                                      text: "/",
                                      textStyle: _commonClass.getTextStyle(
                                          20,
                                          _colorClass.greyColor,
                                          CommonClass.semiBold)),
                                  TextWidget(
                                      text: "month",
                                      textStyle: _commonClass.getTextStyle(
                                          15,
                                          _colorClass.greyColor,
                                          CommonClass.semiBold)),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: _colorClass.redColor,
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(2),
              child: InkWell(
                splashColor: _colorClass.redColor,
                onTap: () {},
                child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                    child: TextWidget(
                        text: "Cancel Subscription",
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.whiteColor, CommonClass.semiBold))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
