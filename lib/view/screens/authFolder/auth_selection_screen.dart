import 'package:accountech/common/color_class.dart';
import 'package:accountech/view/screens/authFolder/sign_in_screen.dart';
import 'package:accountech/view/screens/authFolder/sign_up_screen.dart';
import 'package:flutter/material.dart';
import '../../../common/common_class.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class AuthSelectionScreen extends StatefulWidget {
  static String authSelectionScreenRoute = "/AuthSelectionScreen";

  const AuthSelectionScreen({Key? key}) : super(key: key);

  @override
  State<AuthSelectionScreen> createState() => _AuthSelectionScreenState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();

class _AuthSelectionScreenState extends State<AuthSelectionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: _commonClass.getScreenWidth(context),
          height: _commonClass.getScreenHeight(context),
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(_commonClass.authBG))),
          child: Column(
            children: [
              const Spacer(),
              Container(
                margin:
                    const EdgeInsets.only(bottom: 10, left: 100, right: 100),
                child: Column(
                  children: [
                    Container(
                      child: InkWell(
                        splashColor: _colorClass.mainBrandColor,
                        onTap: () {
                          Navigator.pushNamed(
                              context, SignInScreen.signInScreenRoute);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: TextWidget(
                                text: "Sign In",
                                textStyle: _commonClass.getTextStyle(
                                    12,
                                    _colorClass.whiteColor,
                                    CommonClass.semiBold))),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                              color: _colorClass.whiteColor, width: 1)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: InkWell(
                        splashColor: _colorClass.mainBrandColor,
                        onTap: () {
                          Navigator.pushNamed(
                              context, SignUpScreen.signUpScreenRoute);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: TextWidget(
                                text: "Sign Up",
                                textStyle: _commonClass.getTextStyle(
                                    12,
                                    _colorClass.whiteColor,
                                    CommonClass.semiBold))),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                              color: _colorClass.whiteColor, width: 1)),
                    ),
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

// ClipPath(
//
// clipper: MyClipper(),
// child: Container(
// color: _colorClass.greyColor,
// height: 200,))
// class MyClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path =new Path();
//     path.lineTo(0, size.height);
//     var firstPoint = Offset(size.width / 8, size.height);
//     var firstEnd = Offset(size.width/5 , size.height-20);
//     path.quadraticBezierTo(firstPoint.dx,firstPoint.dy,firstEnd.dx,firstEnd.dy);
//
//     // var secondPoint = Offset(size.width / 5, size.height);
//     // var secondEnd = Offset(size.width/2.5 , size.height-50);
//     // path.quadraticBezierTo(secondPoint.dx,secondPoint.dy,secondEnd.dx,secondEnd.dy);
//     path.lineTo(size.width/2, 0);
//
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
//
// }
