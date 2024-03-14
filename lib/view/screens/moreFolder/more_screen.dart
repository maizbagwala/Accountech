import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/view/screens/accountSettings/account_settings_screen.dart';
import 'package:accountech/view/screens/invoiceThemeSettings/invoice_theme_settings_screen.dart';
import 'package:accountech/view/screens/manageBusinessSettings/manage_business_settings_screen.dart';
import 'package:accountech/view/screens/pricingFolder/pricing_screen.dart';
import 'package:accountech/view/screens/reminderFolder/reminder_screen.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_more_widget.dart';
import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../common/common_class.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class MoreScreen extends StatefulWidget {
  final String textName;

  const MoreScreen(this.textName, {Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();
final StringFile _stringFile = StringFile();

class _MoreScreenState extends State<MoreScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(CommonClass.headerHeight - 4),
        child: Column(
          children: [CommonAppBarMoreWidget()],
        ),
      ),
      body: Container(
        width: _commonClass.getScreenWidth(context),
        color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
        height: _commonClass.getScreenHeight(context),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card(
                //   child: InkWell(
                //     onTap: () {},
                //     splashColor: _colorClass.bgColor,
                //     child: ListTile(
                //       leading: Icon(
                //         FontAwesomeIcons.store,
                //         color: _colorClass.mainBrandColor,
                //         size: 20,
                //       ),
                //       horizontalTitleGap: 0,
                //       title: TextWidget(
                //         text: _stringFile.onlineStore,
                //         textStyle: _commonClass.getTextStyle(
                //             15, _colorClass.blackColor, CommonClass.light),
                //       ),
                //       trailing: Icon(
                //         FontAwesomeIcons.angleRight,
                //         color: _colorClass.mainBrandColor,
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                TextWidget(
                  text: _stringFile.settings,
                  textStyle: _commonClass.getTextStyle(
                      15, _colorClass.secondaryBrandColor, CommonClass.semiBold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context,
                          AccountSettingsScreen.accountSettingsScreenRoute);
                    },
                    splashColor: _colorClass.bgColor,
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.userGear,
                        color: _colorClass.mainBrandColor,
                        size: 20,
                      ),
                      horizontalTitleGap: 0,
                      title: TextWidget(
                        text: _stringFile.accountSettings,
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.blackColor, CommonClass.light),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.angleRight,
                        color: _colorClass.mainBrandColor,
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context,
                          ManageBusinessSettingsScreen
                              .manageBusinessSettingsScreenRoute);
                    },
                    splashColor: _colorClass.bgColor,
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.businessTime,
                        color: _colorClass.mainBrandColor,
                        size: 20,
                      ),
                      horizontalTitleGap: 0,
                      title: TextWidget(
                        text: "Manage Business Settings",
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.blackColor, CommonClass.light),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.angleRight,
                        color: _colorClass.mainBrandColor,
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context,
                          InvoiceThemeSettingsScreen
                              .invoiceThemeSettingsScreenRoute);
                    },
                    splashColor: _colorClass.bgColor,
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.businessTime,
                        color: _colorClass.mainBrandColor,
                        size: 20,
                      ),
                      horizontalTitleGap: 0,
                      title: TextWidget(
                        text: "Invoice Theme Settings",
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.blackColor, CommonClass.light),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.angleRight,
                        color: _colorClass.mainBrandColor,
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, ReminderScreen.reminderScreenRoute);
                    },
                    splashColor: _colorClass.bgColor,
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.bell,
                        color: _colorClass.mainBrandColor,
                      ),
                      horizontalTitleGap: 0,
                      title: TextWidget(
                        text: _stringFile.reminderSettings,
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.blackColor, CommonClass.light),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.angleRight,
                        color: _colorClass.mainBrandColor,
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, PricingScreen.pricingScreenRoute);
                    },
                    splashColor: _colorClass.bgColor,
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.bell,
                        color: _colorClass.mainBrandColor,
                      ),
                      horizontalTitleGap: 0,
                      title: TextWidget(
                        text: "Pricing",
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.blackColor, CommonClass.light),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.angleRight,
                        color: _colorClass.mainBrandColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: _stringFile.others,
                  textStyle: _commonClass.getTextStyle(
                      15, _colorClass.secondaryBrandColor, CommonClass.semiBold),
                ),

                Card(
                  child: InkWell(
                    onTap: () {},
                    splashColor: _colorClass.bgColor,
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.star,
                        color: _colorClass.mainBrandColor,
                      ),
                      horizontalTitleGap: 0,
                      title: TextWidget(
                        text: _stringFile.rateAppOnPlaystore,
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.blackColor, CommonClass.light),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.angleRight,
                        color: _colorClass.mainBrandColor,
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {},
                    splashColor: _colorClass.bgColor,
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.info,
                        color: _colorClass.mainBrandColor,
                      ),
                      horizontalTitleGap: 0,
                      title: TextWidget(
                        text: _stringFile.about,
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.blackColor, CommonClass.light),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.angleRight,
                        color: _colorClass.mainBrandColor,
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (c) {
                            return StatefulBuilder(
                                builder: (context, bottomSheetSetState) {
                              return LogoutPlanBottomSheet(bottomSheetSetState);
                            });
                          });
                    },
                    splashColor: _colorClass.bgColor,
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.arrowRightFromBracket,
                        color: _colorClass.mainBrandColor,
                      ),
                      horizontalTitleGap: 0,
                      title: TextWidget(
                        text: _stringFile.logout,
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.blackColor, CommonClass.light),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.angleRight,
                        color: _colorClass.mainBrandColor,
                      ),
                    ),
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

class LogoutPlanBottomSheet extends StatefulWidget {
  final StateSetter? bottomSheetSetState;

  const LogoutPlanBottomSheet(this.bottomSheetSetState, {Key? key})
      : super(key: key);

  @override
  State<LogoutPlanBottomSheet> createState() => _LogoutPlanBottomSheetState();
}

class _LogoutPlanBottomSheetState extends State<LogoutPlanBottomSheet> {
  final _controller = CountDownController();

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
                          text: "Logout ?",
                          textStyle: _commonClass.getTextStyle(
                              15, _colorClass.blackColor, CommonClass.bold)),
                    ),
                    InkWell(
                        onTap: () {
                        _commonClass.logout(context);
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
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                    text: "Automatically logout in",
                    textStyle: _commonClass.getTextStyle(
                        15, _colorClass.blackColor, CommonClass.bold)),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: CountDownProgressIndicator(
                    labelTextStyle: const TextStyle(fontSize: 15),
                    controller: _controller,
                    valueColor: _colorClass.secondaryBrandColor,
                    backgroundColor: _colorClass.bgColor,
                    initialPosition: 0,
                    duration: 5,
                    timeFormatter: (seconds) {
                      return Duration(seconds: seconds)
                          .toString()
                          .split('.')[0]
                          .split(":")[2]
                          .padLeft(0, '.');
                    },
                    timeTextStyle: const TextStyle(fontSize: 35),
                    text: 'Seconds',
                    onComplete: () {
                      _commonClass.logout(context);

                    },
                  ),
                ),
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
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                    child: TextWidget(
                        text: "Cancel",
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
