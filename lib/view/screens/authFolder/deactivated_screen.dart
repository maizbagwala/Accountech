import 'package:accountech/common/color_class.dart';
import 'package:accountech/controller/authController/auth_controller.dart';
import 'package:accountech/view/screens/authFolder/sign_up_screen.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../common/common_class.dart';
import '../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../widgets/textWidgets/text_widget.dart';
import 'otp_screen.dart';

class DeactivatedScreen extends StatefulWidget {
  static String deactivatedScreenRoute = "/DeactivatedScreen";

  const DeactivatedScreen({Key? key}) : super(key: key);

  @override
  State<DeactivatedScreen> createState() => _DeactivatedScreenState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();

class _DeactivatedScreenState extends State<DeactivatedScreen> {
  final TextEditingController _numberController = TextEditingController();
  String _type = "";
  String _name = "";
  bool? _back;
  late Map<String, dynamic> _routeData;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _routeData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _numberController.text = _routeData['mobile_number'].toString();
    _type = _routeData['type'].toString();
    _name = _routeData['name'].toString();
    _back = _routeData['back'];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: _commonClass.getScreenWidth(context),
          height: _commonClass.getScreenHeight(context),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(_commonClass.authSelectionBgTopLeft),
                    Positioned(
                      left: 20,
                      top: 20,
                      child:_back!=null&&_back==false?
                          Container()
                          : InkWell(
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
                          text: "Verify",
                          textStyle: _commonClass.getTextStyle(
                              35, _colorClass.whiteColor, CommonClass.medium)),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 50, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        _commonClass.accountechMainLogo,
                        width: 150,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                              overflow: TextOverflow.visible,
                              text: "Welcome back to AccountTech! 👋",
                              textStyle: _commonClass.getTextStyle(20,
                                  _colorClass.blackColor, CommonClass.medium)),
                          const SizedBox(
                            height: 5,
                          ),
                          TextWidget(
                              overflow: TextOverflow.visible,
                              text: StringUtils.capitalize(_name),
                              textStyle: _commonClass.getTextStyle(23,
                                  _colorClass.blackColor, CommonClass.medium)),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextWidget(
                          overflow: TextOverflow.visible,
                          text:
                              "Your account is deactivated please verify to reactivate.",
                          textStyle: _commonClass.getTextStyle(
                              15, _colorClass.redColor, CommonClass.medium)),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldWidget(
                          enabled: false,
                          textEditingController: _numberController,
                          maxLength: null,
                          type: TextInputType.number,
                          formatter: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          text: "PHONE NUMBER",
                          onTypeCallBack: (e) {}),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // CheckboxListTile(
                      //   controlAffinity: ListTileControlAffinity.leading,
                      //   contentPadding:
                      //       const EdgeInsets.symmetric(horizontal: 0),
                      //   activeColor: _colorClass.mainBrandColor,
                      //   value: _rememberMe,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _rememberMe = value;
                      //     });
                      //   },
                      //   title: TextWidget(
                      //     text: "Remember Me",
                      //     textStyle: _commonClass.getTextStyle(
                      //         12, _colorClass.blackColor, CommonClass.regular),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      Material(
                        color: _colorClass.mainBrandColor,
                        child: InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            AuthController authController = AuthController();

                            if (_numberController.text.toString().length < 10) {
                              _commonClass.showMessage(
                                  context, "Number can't be empty");
                            } else {
                              _commonClass.showLoader(context, true);
                              authController
                                  .verifyUser(_numberController.text.toString())
                                  .then((value) {
                                _commonClass.showLoader(context, false);

                                _commonClass.showMessage(
                                    context, value.message.toString());
                                if (value.status != null) {
                                  if (value.status == 200) {
                                    Navigator.pushNamed(
                                        context, OTPScreen.oTPScreenRoute,
                                        arguments: {
                                          "mobile_number":
                                              _numberController.text.toString(),
                                          "type": _commonClass.otpType[2]
                                        });
                                  }
                                }
                                // _commonClass.showLoader(context, false);
                                // if (value == "") {
                                //   _commonClass.showMessage(
                                //       context, StringFile.someError);
                                // } else {
                                //   RegisterModel myValue = value;
                                //   _commonClass.showMessage(
                                //       context, myValue.message.toString());
                                // }
                              });
                            }

                            // Navigator.pushNamed(context, OTPScreen.oTPScreenRoute);
                          },
                          child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextWidget(
                                  text: "Verify",
                                  textStyle: _commonClass.getTextStyle(
                                      20,
                                      _colorClass.whiteColor,
                                      CommonClass.semiBold))),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextWidget(
                                text: "Still need help?",
                                textStyle: _commonClass.getTextStyle(
                                    17,
                                    _colorClass.blackColor,
                                    CommonClass.semiBold)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              overflow: TextOverflow.visible,
                                text:
                                    "Our specialists are always happy to help.Contact us during standard business hours or email us 24X7 and we'll get back to you.",
                                textStyle: _commonClass.getTextStyle(
                                    14,
                                    _colorClass.blackColor,
                                    CommonClass.semiBold)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Material(
                              color: _colorClass.secondaryBrandColor,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: TextWidget(
                                        text: "Contact-Us",
                                        textStyle: _commonClass.getTextStyle(
                                            20,
                                            _colorClass.whiteColor,
                                            CommonClass.semiBold))),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     TextWidget(
                      //         text: "New on our platform?",
                      //         textStyle: _commonClass.getTextStyle(12,
                      //             _colorClass.blackColor, CommonClass.regular)),
                      //     const SizedBox(
                      //       width: 5,
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //         Navigator.pushNamed(
                      //             context, SignUpScreen.signUpScreenRoute);
                      //       },
                      //       child: TextWidget(
                      //           text: "Create an account",
                      //           textStyle: _commonClass.getTextStyle(
                      //               15,
                      //               _colorClass.secondaryBrandColor,
                      //               CommonClass.regular,
                      //               line: true)),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
