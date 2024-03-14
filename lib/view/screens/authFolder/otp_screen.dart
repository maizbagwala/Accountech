import 'dart:async';

import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/my_shared_preferences.dart';
import 'package:accountech/controller/authController/auth_controller.dart';
import 'package:accountech/controller/companyController/company_controller.dart';
import 'package:accountech/view/screens/mainFolder/main_screen.dart';
import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../common/common_class.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class OTPScreen extends StatefulWidget {
  static String oTPScreenRoute = "/OTPScreen";

  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  Map<String, String>? routeValue = null;
  final _controller = CountDownController();
  bool _resendTextShow = false;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    routeValue =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.arrowLeftLong,
                        color: _colorClass.blackColor,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextWidget(
                          text: "Back",
                          textStyle: _commonClass.getTextStyle(
                              13, _colorClass.blackColor, CommonClass.medium)),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 50, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Image.asset(
                      _commonClass.accountechMainLogo,
                      width: 150,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextWidget(
                        overflow: TextOverflow.visible,
                        text: "Two Step Verification",
                        textStyle: _commonClass.getTextStyle(
                            20, _colorClass.blackColor, CommonClass.medium)),
                    const SizedBox(
                      height: 10,
                    ),
                    TextWidget(
                        overflow: TextOverflow.visible,
                        text:
                            "We sent a verification code to your mobile. Enter the code from the mobile in the field below.",
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.greyColor, CommonClass.medium)),
                    const SizedBox(
                      height: 10,
                    ),
                    TextWidget(
                        overflow: TextOverflow.visible,
                        text: "+91 ${routeValue!['mobile_number']}",
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.blackColor, CommonClass.semiBold)),
                    const SizedBox(
                      height: 10,
                    ),
                    TextWidget(
                        overflow: TextOverflow.visible,
                        text: "Type your 6 digit security code",
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.greyColor, CommonClass.semiBold)),
                    const SizedBox(
                      height: 15,
                    ),

                    Form(
                      key: formKey,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 0),
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 6,
                            obscureText: false,

                            blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.length < 3) {
                                return "* Please fill up all the cells properly";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              activeColor: _colorClass.secondaryBrandColor,
                              activeFillColor: _colorClass.whiteColor,
                              selectedFillColor: _colorClass.whiteColor,
                              inactiveColor: _colorClass.secondaryBrandColor,
                              selectedColor: _colorClass.secondaryBrandColor,
                              inactiveFillColor: _colorClass.whiteColor,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              borderWidth: 1,
                              fieldHeight: 50,
                              fieldWidth: 40,
                            ),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            keyboardType: TextInputType.number,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            onCompleted: (v) {},
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {
                              debugPrint(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          )),
                    ),

                    _resendTextShow
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Didn't receive the code? ",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15),
                              ),
                              TextButton(
                                onPressed: () {
                                  _commonClass.showLoader(context, true);

                                  AuthController authController =
                                      AuthController();
                                  authController
                                      .resendOTP(
                                          routeValue!['mobile_number']
                                              .toString(),
                                          routeValue!['type'].toString())
                                      .then((value) {
                                    _commonClass.showLoader(context, false);

                                    _commonClass.showMessage(
                                        context, value.message.toString());
                                    setState(() {
                                      _resendTextShow = false;
                                    });
                                  });
                                },
                                child: Text(
                                  "RESEND",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: _colorClass.secondaryBrandColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Resend code after",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15),
                              ),
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: CountDownProgressIndicator(
                                  labelTextStyle: const TextStyle(fontSize: 10),
                                  controller: _controller,
                                  valueColor: _colorClass.secondaryBrandColor,
                                  backgroundColor: _colorClass.bgColor,
                                  initialPosition: 0,
                                  duration: 60,
                                  timeFormatter: (seconds) {
                                    return Duration(seconds: seconds)
                                        .toString()
                                        .split('.')[0]
                                        .split(":")[2]
                                        .padLeft(0, '.');
                                  },
                                  timeTextStyle: const TextStyle(fontSize: 10),
                                  text: 'Seconds',
                                  onComplete: () {
                                    setState(() {
                                      _resendTextShow = true;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                    Material(
                      color: _colorClass.mainBrandColor,
                      child: InkWell(
                        onTap: () {
                          formKey.currentState!.validate();
                          // conditions for validating
                          if (currentText.length != 6) {
                            errorController!.add(ErrorAnimationType
                                .shake); // Triggering error shake animation
                            setState(() => hasError = true);
                          } else {
                            _commonClass.showLoader(context, true);

                            AuthController authController = AuthController();
                            authController
                                .verifyOTP(
                                    routeValue!['mobile_number'].toString(),
                                    currentText.toString(),
                                    routeValue!['type'].toString())
                                .then((value) {
                              _commonClass.showLoader(context, false);

                              _commonClass.showMessage(
                                  context, value.message.toString());
                              if (value.status != null) {
                                if (value.status == 200) {
                                  MySharedPreferences.userID.$ =
                                      value.data!.id!;
                                  MySharedPreferences.accessToken.$ =
                                      value.data!.accessToken!;
                                  MySharedPreferences.userName.$ =
                                      value.data!.name!;

                                  CompanyController companyController =
                                      CompanyController();

                                  companyController
                                      .getBusinessList()
                                      .then((businessValue) {
                                    if (value.status != null) {
                                      if (value.status == 200) {

                                        if(businessValue.data.isNotEmpty)
                                          {
                                            debugPrint("business list====${businessValue.data}");
                                            MySharedPreferences.businessSelectedID.$=businessValue.data[0].id;
                                            MySharedPreferences.businessSelectedName.$=businessValue.data[0].businessName;
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                MainScreen.mainScreenRoute,
                                                    (Route<dynamic> route) => false);
                                          }else{
                                          _commonClass.showMessage(
                                              context, value.message.toString());
                                        }
                                      }
                                    }
                                  });


                                }
                              }
                            });
                          }
                        },
                        splashColor: _colorClass.bgColor,
                        child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextWidget(
                                text: "VERIFY",
                                textStyle: _commonClass.getTextStyle(
                                    20,
                                    _colorClass.whiteColor,
                                    CommonClass.semiBold))),
                      ),
                    ),
                    // Container(
                    //   margin:
                    //   const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30),
                    //   child: ButtonTheme(
                    //     height: 50,
                    //     child: TextButton(
                    //       onPressed: () {
                    //         formKey.currentState!.validate();
                    //         // conditions for validating
                    //         if (currentText.length != 6 || currentText != "123456") {
                    //           errorController!.add(ErrorAnimationType
                    //               .shake); // Triggering error shake animation
                    //           setState(() => hasError = true);
                    //         } else {
                    //           setState(
                    //                 () {
                    //               hasError = false;
                    //               snackBar("OTP Verified!!");
                    //             },
                    //           );
                    //         }
                    //       },
                    //       child: Center(
                    //           child: Text(
                    //             "VERIFY".toUpperCase(),
                    //             style: const TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 18,
                    //                 fontWeight: FontWeight.bold),
                    //           )),
                    //     ),
                    //   ),
                    //   decoration: BoxDecoration(
                    //       color: Colors.green.shade300,
                    //       borderRadius: BorderRadius.circular(5),
                    //       boxShadow: [
                    //         BoxShadow(
                    //             color: Colors.green.shade200,
                    //             offset: const Offset(1, -2),
                    //             blurRadius: 5),
                    //         BoxShadow(
                    //             color: Colors.green.shade200,
                    //             offset: const Offset(-1, 2),
                    //             blurRadius: 5)
                    //       ]),
                    // ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Flexible(
                    //         child: TextButton(
                    //           child: const Text("Clear"),
                    //           onPressed: () {
                    //             textEditingController.clear();
                    //           },
                    //         )),
                    //     Flexible(
                    //         child: TextButton(
                    //           child: const Text("Set Text"),
                    //           onPressed: () {
                    //             setState(() {
                    //               textEditingController.text = "123456";
                    //             });
                    //           },
                    //         )),
                    //   ],
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
