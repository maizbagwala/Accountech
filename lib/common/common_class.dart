import 'package:accountech/common/api_services.dart';
import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/my_shared_preferences.dart';
import 'package:accountech/view/screens/authFolder/auth_selection_screen.dart';
import 'package:accountech/widgets/textWidgets/text_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lottie/lottie.dart';

class CommonClass extends ApiServices {
  static const black = 'MontserratAlternatesBlack';
  static const bold = 'MontserratAlternatesBold';
  static const extraBold = 'MontserratAlternatesExtraBold';
  static const extraLight = 'MontserratAlternatesExtraLight';
  static const light = 'MontserratAlternatesLight';
  static const medium = 'MontserratAlternatesMedium';
  static const regular = 'MontserratAlternatesRegular';
  static const semiBold = 'MontserratAlternatesSemiBold';
  static const thin = 'MontserratAlternatesThin';
  static int languageCode = 1;
  static const headerHeight = 60.0;
  static const bgAlpha = 20;

  String _accountechMainLogo = "";
  String _barcodeScanner = "";
  String _demoBarcode = "";
  String _swipeLeft = "";
  String _myLoader = "";
  String _demoQRCode = "";
  String _demoUser = "";
  String _demoMasterCard = "";
  String _demoVisa = "";
  String _demoSignature = "";
  String _demoInvoice = "";
  String _authSelectionBgTopLeft = "";
  String _authBG = "";
  String _noImageAvailable = "";
  ColorClass colorClass = ColorClass();
  final String _mainPathForImages = "assets/images/";
  final String _mainPathForLottieFiles = "assets/lottie_animations/";
  final int _splashTick = 1;
  final int _totalSplashTick = 3;
  final int _totalLanguageChangeTick = 3;
  final List<String> _allowedExtensions = ['jpg', 'png'];
  final List<String> _otpType = ['register', 'login', 'activation'];

  List<String> get otpType => _otpType;

  List<String> get allowedExtensions => _allowedExtensions;

  String get authSelectionBgTopLeft => _authSelectionBgTopLeft;

  CommonClass() {
    _accountechMainLogo = _mainPathForImages + "accountech_main_logo.png";
    _barcodeScanner = _mainPathForImages + "barcode_scanner.png";
    _demoBarcode = _mainPathForImages + "demo_barcode.jpeg";
    _swipeLeft = _mainPathForLottieFiles + "swipe_left.json";
    _myLoader = _mainPathForLottieFiles + "my_loader.json";
    _demoQRCode = _mainPathForImages + "demo_qr_code.jpeg";
    _demoQRCode = _mainPathForImages + "demo_qr_code.jpeg";
    _demoUser = _mainPathForImages + "demo_user.png";
    _demoMasterCard = _mainPathForImages + "demo_mastercard.png";
    _demoVisa = _mainPathForImages + "demo_visa.png";
    _demoSignature = _mainPathForImages + "demo_signature.png";
    _demoInvoice = _mainPathForImages + "demo_invoice.png";
    _authSelectionBgTopLeft = mainPathForImages + "auth_selection_bg_top.png";
    _authBG = mainPathForImages + "auth_bg.png";
    _noImageAvailable = mainPathForImages + "no_image_available.png";
  }

  String get myLoader => _myLoader;

  getEmailValidation(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  getPanValidation(String panNumber) {
    bool panValid = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(panNumber);
    return panValid;
  }

  showMessage(BuildContext context, String msg) {
    var snackBar = SnackBar(
        duration: const Duration(seconds: 1),
        content: TextWidget(
          text: msg,
          overflow: TextOverflow.visible,
          textStyle:
              getTextStyle(15, colorClass.whiteColor, CommonClass.semiBold),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  getCroppedImage(result) {
    return ImageCropper().cropImage(
      sourcePath: result.files.single.path.toString(),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        // CropAspectRatioPreset.ratio3x2,
        // CropAspectRatioPreset.original,
        // CropAspectRatioPreset.ratio4x3,
        // CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: colorClass.secondaryBrandColor,
            toolbarWidgetColor: colorClass.whiteColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );
  }

  String get noImageAvailable => _noImageAvailable;

  String get authBG => _authBG;

  String get demoInvoice => _demoInvoice;

  String get demoSignature => _demoSignature;

  String get demoMasterCard => _demoMasterCard;

  String get demoUser => _demoUser;

  String get demoQRCode => _demoQRCode;

  String get swipeLeft => _swipeLeft;

  String get mainPathForLottieFiles => _mainPathForLottieFiles;

  String get demoBarcode => _demoBarcode;

  String get barcodeScanner => _barcodeScanner;

  int get totalLanguageChangeTick => _totalLanguageChangeTick;

  String get mainPathForImages => _mainPathForImages;

  TextStyle getTextStyle(double textSize, Color color, String fontFamily,
      {bool? line}) {
    return TextStyle(
      color: color,
      fontSize: textSize,
      fontFamily: fontFamily,
      decoration: line == null ? null : TextDecoration.underline,
    );
  }

  showLoader(BuildContext context, bool showLoader) {
    if (!showLoader) {
      Navigator.pop(context);
    } else {
      showDialog(
          barrierColor: Colors.white.withOpacity(0.7),
          context: context,
          builder: (c) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Lottie.asset(myLoader, fit: BoxFit.cover),
                ),
              ],
            );
          });
    }
  }

  showCustomDialog(
      BuildContext context, String title, String body, Function onYesClick) {
    showDialog(
        context: context,
        builder: (c) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: getScreenWidth(context),
                color: colorClass.whiteColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: colorClass.whiteColor,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 1),
                                color: colorClass.greyColor.withAlpha(50))
                          ]),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextWidget(
                              text: title,
                              overflow: TextOverflow.visible,
                              textStyle: getTextStyle(17, colorClass.blackColor,
                                  CommonClass.regular),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                FontAwesomeIcons.xmark,
                                size: 20,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 200,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: body,
                                overflow: TextOverflow.visible,
                                textStyle: getTextStyle(15,
                                    colorClass.blackColor, CommonClass.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.pop(c);
                          },
                          child: Container(
                              color: colorClass.greyColor,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 5),
                              child: TextWidget(
                                  text: "Cancel X",
                                  textStyle: getTextStyle(
                                      12,
                                      colorClass.whiteColor,
                                      CommonClass.semiBold))),
                        )),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            onYesClick();
                          },
                          child: Container(
                              color: colorClass.redColor,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5),
                              child: TextWidget(
                                  text: "Done ✔️",
                                  textStyle: getTextStyle(
                                      12,
                                      colorClass.whiteColor,
                                      CommonClass.semiBold))),
                        )),
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  String get accountechMainLogo => _accountechMainLogo;

  double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  logout(BuildContext context) {
    MySharedPreferences.userID.$ = -1;
    MySharedPreferences.accessToken.$ = "";
    MySharedPreferences.userName.$ = "";
    Navigator.pushNamedAndRemoveUntil(
        context,
        AuthSelectionScreen.authSelectionScreenRoute,
        (Route<dynamic> route) => false);
  }

  double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  pleaseMakeFocusOut() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<FilePickerResult?> pickImage() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _allowedExtensions,
    );
  }

  int get totalSplashTick => _totalSplashTick;

  int get splashTick => _splashTick;

  String get demoVisa => _demoVisa;
}
