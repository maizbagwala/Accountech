import 'package:accountech/common/common_class.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../common/color_class.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class ReminderScreen extends StatefulWidget {
  static String reminderScreenRoute = "/ReminderScreen";

  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

final ColorClass _colorClass = ColorClass();
final CommonClass _commonClass = CommonClass();

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  void initState() {
    super.initState();
  }

  final ExpandableController _toPartyController = ExpandableController();
  final ExpandableController _toYouController = ExpandableController();
  bool _switch1=false,_switch2=false,_switch3=false,_switch4=false,_switch5=false,_switch6=false,_switch7=false,_switch8=false,_switch9=false,_switch10=false,_switch11=false;

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
                      text: "Reminder Settings",
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
          child: Container(
            color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
            height: _commonClass.getScreenHeight(context),
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
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text: "Are You GST Registered?",
                                        textStyle: _commonClass.getTextStyle(
                                            15,
                                            _colorClass.blackColor,
                                            CommonClass.medium),
                                      ),
                                      TextWidget(
                                        overflow: TextOverflow.visible,
                                        text:
                                            "Send SMS to your Party on creating any transaction",
                                        textStyle: _commonClass.getTextStyle(
                                            13,
                                            _colorClass.greyColor,
                                            CommonClass.regular),
                                      ),
                                    ],
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  FlutterSwitch(
                                    activeColor:
                                        _colorClass.secondaryBrandColor,
                                    height: 20,
                                    toggleSize: 10,
                                    width: 40,
                                    value: _switch1,
                                    onToggle: (val) {
                                      setState(() {
                                        _switch1=val;
                                      });
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text:
                                            "Get payment reminders on WhatsApp",
                                        textStyle: _commonClass.getTextStyle(
                                            15,
                                            _colorClass.blackColor,
                                            CommonClass.medium),
                                      ),
                                      TextWidget(
                                        overflow: TextOverflow.visible,
                                        text:
                                            "Get WhatsApp alerts when you have to collect payment from customers`",
                                        textStyle: _commonClass.getTextStyle(
                                            13,
                                            _colorClass.greyColor,
                                            CommonClass.regular),
                                      ),
                                    ],
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  FlutterSwitch(
                                    activeColor:
                                        _colorClass.secondaryBrandColor,
                                    height: 20,
                                    toggleSize: 10,
                                    width: 40,
                                    value: _switch2,
                                    onToggle: (val) {
                                      setState(() {
                                        _switch2=val;
                                      });
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ExpandableNotifier(
                                  child: ScrollOnExpand(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ExpandablePanel(
                                      controller: _toPartyController,
                                      theme: const ExpandableThemeData(
                                        headerAlignment:
                                            ExpandablePanelHeaderAlignment
                                                .center,
                                        hasIcon: true,
                                      ),
                                      header: Container(
                                        color: _colorClass.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 17, horizontal: 0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextWidget(
                                                    text: "TO PARTY",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            15,
                                                            _colorClass
                                                                .blackColor,
                                                            CommonClass
                                                                .semiBold),
                                                  ),
                                                  TextWidget(
                                                    text:
                                                        "Reminders will be sent through sms",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            13,
                                                            _colorClass
                                                                .greyColor,
                                                            CommonClass
                                                                .regular),
                                                  ),
                                                ],
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      collapsed: Container(),
                                      expanded: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: _commonClass
                                                .getScreenWidth(context),
                                            decoration: BoxDecoration(
                                                color: _colorClass.bgColor,
                                                border: Border.all(
                                                    width: 0.5,
                                                    color:
                                                        _colorClass.greyColor),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextWidget(
                                                    text: "Sales Invoice",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            13,
                                                            _colorClass
                                                                .blackColor,
                                                            CommonClass.medium),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  TextWidget(
                                                    text:
                                                        "Get reminded to collect payments on time",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            13,
                                                            _colorClass
                                                                .greyColor,
                                                            CommonClass
                                                                .regular),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Divider(
                                                    height: 0.1,
                                                    color:
                                                        _colorClass.greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: TextWidget(
                                                        text:
                                                            "3 days before due date",
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                12,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .medium),
                                                      )),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      FlutterSwitch(
                                                        activeColor: _colorClass
                                                            .secondaryBrandColor,
                                                        height: 20,
                                                        toggleSize: 10,
                                                        width: 40,
                                                        value: _switch3,
                                                        onToggle: (val) {
                                                          setState(() {
                                                            _switch3=val;
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: TextWidget(
                                                        text: "On due date",
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                12,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .medium),
                                                      )),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      FlutterSwitch(
                                                        activeColor: _colorClass
                                                            .secondaryBrandColor,
                                                        height: 20,
                                                        toggleSize: 10,
                                                        width: 40,
                                                        value: _switch4,
                                                        onToggle: (val) {
                                                          setState(() {
                                                            _switch4=val;
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                              const SizedBox(
                                height: 20,
                              ),
                              ExpandableNotifier(
                                  child: ScrollOnExpand(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ExpandablePanel(
                                      controller: _toYouController,
                                      theme: const ExpandableThemeData(
                                        headerAlignment:
                                            ExpandablePanelHeaderAlignment
                                                .center,
                                        hasIcon: true,
                                      ),
                                      header: Container(
                                        color: _colorClass.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 17, horizontal: 0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextWidget(
                                                    text: "TO YOU",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            15,
                                                            _colorClass
                                                                .blackColor,
                                                            CommonClass
                                                                .semiBold),
                                                  ),
                                                  TextWidget(
                                                    overflow:
                                                        TextOverflow.visible,
                                                    text:
                                                        "Reminders will be sent on mobile app and whatsapp",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            13,
                                                            _colorClass
                                                                .greyColor,
                                                            CommonClass
                                                                .regular),
                                                  ),
                                                ],
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      collapsed: Container(),
                                      expanded: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: _commonClass
                                                .getScreenWidth(context),
                                            decoration: BoxDecoration(
                                                color: _colorClass.bgColor,
                                                border: Border.all(
                                                    width: 0.5,
                                                    color:
                                                        _colorClass.greyColor),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextWidget(
                                                    text: "Sales Invoice",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            13,
                                                            _colorClass
                                                                .blackColor,
                                                            CommonClass.medium),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  TextWidget(
                                                    text:
                                                        "Get reminded to collect payments on time",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            13,
                                                            _colorClass
                                                                .greyColor,
                                                            CommonClass
                                                                .regular),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Divider(
                                                    height: 0.1,
                                                    color:
                                                        _colorClass.greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: TextWidget(
                                                        text:
                                                            "3 days before due date",
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                12,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .medium),
                                                      )),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      FlutterSwitch(
                                                        activeColor: _colorClass
                                                            .secondaryBrandColor,
                                                        height: 20,
                                                        toggleSize: 10,
                                                        width: 40,
                                                        value: _switch5,
                                                        onToggle: (val) {
                                                          setState(() {
                                                            _switch5=val;
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: TextWidget(
                                                        text: "On due date",
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                12,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .medium),
                                                      )),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      FlutterSwitch(
                                                        activeColor: _colorClass
                                                            .secondaryBrandColor,
                                                        height: 20,
                                                        toggleSize: 10,
                                                        width: 40,
                                                        value: _switch6,
                                                        onToggle: (val) {
                                                          setState(() {
                                                            _switch6=val;
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: _commonClass
                                                .getScreenWidth(context),
                                            decoration: BoxDecoration(
                                                color: _colorClass.bgColor,
                                                border: Border.all(
                                                    width: 0.5,
                                                    color:
                                                        _colorClass.greyColor),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextWidget(
                                                    text: "Low Stock",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            13,
                                                            _colorClass
                                                                .blackColor,
                                                            CommonClass.medium),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  TextWidget(
                                                    text:
                                                        "Get reminded to buy stock",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            13,
                                                            _colorClass
                                                                .greyColor,
                                                            CommonClass
                                                                .regular),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Divider(
                                                    height: 0.1,
                                                    color:
                                                        _colorClass.greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: TextWidget(
                                                        text:
                                                            "When stock is below low stock level",
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                12,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .medium),
                                                      )),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      FlutterSwitch(
                                                        activeColor: _colorClass
                                                            .secondaryBrandColor,
                                                        height: 20,
                                                        toggleSize: 10,
                                                        width: 40,
                                                        value: _switch7,
                                                        onToggle: (val) {
                                                          setState(() {
                                                            _switch7=val;
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: _commonClass
                                                .getScreenWidth(context),
                                            decoration: BoxDecoration(
                                                color: _colorClass.bgColor,
                                                border: Border.all(
                                                    width: 0.5,
                                                    color:
                                                        _colorClass.greyColor),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextWidget(
                                                    text: "Purchase Invoice",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            13,
                                                            _colorClass
                                                                .blackColor,
                                                            CommonClass.medium),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  TextWidget(
                                                    text:
                                                        "Get reminded to send payments on time",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            13,
                                                            _colorClass
                                                                .greyColor,
                                                            CommonClass
                                                                .regular),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Divider(
                                                    height: 0.1,
                                                    color:
                                                        _colorClass.greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: TextWidget(
                                                        text:
                                                            "3 days before due date",
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                12,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .medium),
                                                      )),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      FlutterSwitch(
                                                        activeColor: _colorClass
                                                            .secondaryBrandColor,
                                                        height: 20,
                                                        toggleSize: 10,
                                                        width: 40,
                                                        value: _switch8,
                                                        onToggle: (val) {
                                                          setState(() {
                                                            _switch8=val;
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: TextWidget(
                                                        text: "On due date",
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                12,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .medium),
                                                      )),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      FlutterSwitch(
                                                        activeColor: _colorClass
                                                            .secondaryBrandColor,
                                                        height: 20,
                                                        toggleSize: 10,
                                                        width: 40,
                                                        value: _switch9,
                                                        onToggle: (val) {
                                                          setState(() {
                                                            _switch9=val;
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: _commonClass
                                                .getScreenWidth(context),
                                            decoration: BoxDecoration(
                                                color: _colorClass.bgColor,
                                                border: Border.all(
                                                    width: 0.5,
                                                    color:
                                                        _colorClass.greyColor),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextWidget(
                                                    text: "Daily Summary",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            13,
                                                            _colorClass
                                                                .blackColor,
                                                            CommonClass.medium),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  TextWidget(
                                                    text:
                                                        "Get daily updates about",
                                                    textStyle: _commonClass
                                                        .getTextStyle(
                                                            13,
                                                            _colorClass
                                                                .greyColor,
                                                            CommonClass
                                                                .regular),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Divider(
                                                    height: 0.1,
                                                    color:
                                                        _colorClass.greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: TextWidget(
                                                        text:
                                                            "Outstanding Collections and Payments",
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                12,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .medium),
                                                      )),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      FlutterSwitch(
                                                        activeColor: _colorClass
                                                            .secondaryBrandColor,
                                                        height: 20,
                                                        toggleSize: 10,
                                                        width: 40,
                                                        value: _switch10,
                                                        onToggle: (val) {
                                                          setState(() {
                                                            _switch10=val;
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: TextWidget(
                                                        text:
                                                            "Yesterday's Sales",
                                                        textStyle: _commonClass
                                                            .getTextStyle(
                                                                12,
                                                                _colorClass
                                                                    .blackColor,
                                                                CommonClass
                                                                    .medium),
                                                      )),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      FlutterSwitch(
                                                        activeColor: _colorClass
                                                            .secondaryBrandColor,
                                                        height: 20,
                                                        toggleSize: 10,
                                                        width: 40,
                                                        value: _switch11,
                                                        onToggle: (val) {
                                                          setState(() {
                                                            _switch11=val;
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
