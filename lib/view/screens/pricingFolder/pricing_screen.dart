import 'package:accountech/common/common_class.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../common/color_class.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class PricingScreen extends StatefulWidget {
  static String pricingScreenRoute = "/PricingScreen";

  const PricingScreen({Key? key}) : super(key: key);

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

final ColorClass _colorClass = ColorClass();
final CommonClass _commonClass = CommonClass();

class _PricingScreenState extends State<PricingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(CommonClass.headerHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonAppBarWidget(
                  title: TextWidget(
                    text: "Pricing",
                    textStyle: _commonClass.getTextStyle(
                        20, _colorClass.blackColor, CommonClass.semiBold),
                  ),
                ),
              ],
            )),
        resizeToAvoidBottomInset: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
          child: SizedBox(
            height: _commonClass.getScreenHeight(context),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (c, i) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: _commonClass.getScreenWidth(context)-40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                            color: _colorClass.greyColor, width: 0.1),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(
                                1,
                                1,
                              ),
                              color: _colorClass.greyColor.withOpacity(0.2),
                              blurRadius: 5)
                        ],
                        color: _colorClass.whiteColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextWidget(
                                    text: "DIAMOND PLAN",
                                    textStyle: _commonClass.getTextStyle(
                                        17,
                                        _colorClass.blackColor,
                                        CommonClass.semiBold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        TextWidget(
                                          text: "₹ 142",
                                          textStyle: _commonClass.getTextStyle(
                                              20,
                                              _colorClass.secondaryBrandColor,
                                              CommonClass.semiBold),
                                        ),
                                        TextWidget(
                                          text: "/ MONTH",
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.blackColor,
                                              CommonClass.semiBold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        TextWidget(
                                          text: "PAY",
                                          textStyle: _commonClass.getTextStyle(
                                              25,
                                              _colorClass.blackColor,
                                              CommonClass.semiBold),
                                        ),
                                        TextWidget(
                                          text: " ₹ 1699 / YEAR",
                                          textStyle: _commonClass.getTextStyle(
                                              25,
                                              _colorClass.secondaryBrandColor,
                                              CommonClass.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const      SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextWidget(
                                        text: "FEATURES",
                                        textStyle: _commonClass.getTextStyle(
                                            15,
                                            _colorClass.blackColor,
                                            CommonClass.semiBold),
                                      ),
                                    )
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: _colorClass.greyColor.withAlpha(100),
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextWidget(
                                        text: "14-days free trial",
                                        textStyle: _commonClass.getTextStyle(
                                            15,
                                            _colorClass.blackColor,
                                            CommonClass.semiBold),
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.check,
                                      color: _colorClass.blackColor,
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: _colorClass.greyColor.withAlpha(100),
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextWidget(
                                        text: "No user limit	  ",
                                        textStyle: _commonClass.getTextStyle(
                                            15,
                                            _colorClass.blackColor,
                                            CommonClass.semiBold),
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.xmark,
                                      color: _colorClass.blackColor,
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: _colorClass.greyColor.withAlpha(100),
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextWidget(
                                        text: "Product Support	",
                                        textStyle: _commonClass.getTextStyle(
                                            15,
                                            _colorClass.blackColor,
                                            CommonClass.semiBold),
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.check,
                                      color: _colorClass.blackColor,
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: _colorClass.greyColor.withAlpha(100),
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextWidget(
                                        text: "Email Support	",
                                        textStyle: _commonClass.getTextStyle(
                                            15,
                                            _colorClass.blackColor,
                                            CommonClass.semiBold),
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.xmark,
                                      color: _colorClass.blackColor,
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: _colorClass.greyColor.withAlpha(100),
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextWidget(
                                        text: "Integrations",
                                        textStyle: _commonClass.getTextStyle(
                                            15,
                                            _colorClass.blackColor,
                                            CommonClass.semiBold),
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.check,
                                      color: _colorClass.blackColor,
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: _colorClass.greyColor.withAlpha(100),
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextWidget(
                                        text: "Removal of Front branding	",
                                        textStyle: _commonClass.getTextStyle(
                                            15,
                                            _colorClass.blackColor,
                                            CommonClass.semiBold),
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.check,
                                      color: _colorClass.blackColor,
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: _colorClass.greyColor.withAlpha(100),
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextWidget(
                                        text: "Active maintenance & support	",
                                        textStyle: _commonClass.getTextStyle(
                                            15,
                                            _colorClass.blackColor,
                                            CommonClass.semiBold),
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.check,
                                      color: _colorClass.blackColor,
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: _colorClass.greyColor.withAlpha(100),
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextWidget(
                                        text: "Data storage for 365 days	",
                                        textStyle: _commonClass.getTextStyle(
                                            15,
                                            _colorClass.blackColor,
                                            CommonClass.semiBold),
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.check,
                                      color: _colorClass.blackColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const        SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin:const  EdgeInsets.symmetric(horizontal: 50),
                            child: Material(
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
                                        text: "Choose Plan",
                                        textStyle: _commonClass.getTextStyle(
                                            12,
                                            _colorClass.whiteColor,
                                            CommonClass.semiBold))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  ListTile myRowDataIcon(IconData iconVal, String rowVal) {
    return ListTile(
      leading: Icon(iconVal, color: _colorClass.whiteColor),
      title: Text(
        rowVal,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
