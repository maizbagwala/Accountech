import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/controller/cashAndBankController/cash_and_bank_controller.dart';
import 'package:accountech/view/screens/cashAndBankFolder/detail_item_cash_bank_screen.dart';
import 'package:accountech/view/screens/cashAndBankFolder/widgets/add_money_bottom_sheet.dart';
import 'package:accountech/view/screens/cashAndBankFolder/widgets/reduce_money_bottom_sheet.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:accountech/widgets/commonWidget/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../widgets/textWidgets/text_widget.dart';

class CashAndBankScreen extends StatefulWidget {
  static String cashAndBankRoute = "/CashAndBankScreen";

  const CashAndBankScreen({Key? key}) : super(key: key);

  @override
  State<CashAndBankScreen> createState() => _CashAndBankScreenState();
}

class _CashAndBankScreenState extends State<CashAndBankScreen>
    with TickerProviderStateMixin {
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();
  final StringFile _stringFile = StringFile();
  final List<int> _itemList = [1, 2, 3, 4, 5, 6];
  var cashAndBankController = Get.find<CashAndBankController>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    cashAndBankController.getCashInHand();
    cashAndBankController.getBank();
    cashAndBankController.getTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(CommonClass.headerHeight + 45),
        child: Column(
          children: [
            CommonAppBarWidget(
              title: TextWidget(
                text: _stringFile.cashAndBank,
                textStyle: _commonClass.getTextStyle(
                    20, _colorClass.blackColor, CommonClass.semiBold),
              ),
              actions: null,
            ),
            SizedBox(
                width: _commonClass.getScreenWidth(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      indicatorColor: _colorClass.mainBrandColor,
                      labelColor: _colorClass.blackColor,
                      controller: _tabController,
                      tabs: <Widget>[
                        Tab(
                          text: _stringFile.cashInHand,
                        ),
                        Tab(
                          text: _stringFile.bank,
                        ),
                        Tab(
                          text: _stringFile.total,
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Scaffold(
            bottomNavigationBar: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: Material(
                    color: _colorClass.mainBrandColor,
                    child: InkWell(
                      splashColor: _colorClass.bgColor,
                      onTap: () async {
                        await showMaterialModalBottomSheet(
                          context: context,
                          expand: true,
                          builder: (context) => StatefulBuilder(
                              builder: (context, bottomSheetSetState) {
                                return  AddMoneyBottomSheet(bottomSheetSetState: bottomSheetSetState);
                              }),
                        ).whenComplete(() {
                          cashAndBankController.getCashInHand();
                          cashAndBankController.getBank();
                          cashAndBankController.getTotal();
                        });
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextWidget(
                              text: _stringFile.addMoney,
                              textStyle: _commonClass.getTextStyle(15,
                                  _colorClass.whiteColor, CommonClass.bold))),
                    ),
                  )),
                  Expanded(
                      child: Material(
                    color: _colorClass.secondaryBrandColor,
                    child: InkWell(
                      splashColor: _colorClass.bgColor,
                      onTap: () {
                        showMaterialModalBottomSheet(
                          context: context,
                          expand: true,
                          builder: (context) => StatefulBuilder(
                              builder: (context, bottomSheetSetState) {
                            return const ReduceMoneyBottomSheet();
                          }),
                        );
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextWidget(
                              text: _stringFile.reduceMoney,
                              textStyle: _commonClass.getTextStyle(15,
                                  _colorClass.whiteColor, CommonClass.bold))),
                    ),
                  )),
                ],
              ),
            ),
            body: Container(
              color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
              height: _commonClass.getScreenHeight(context),
              child: GetX<CashAndBankController>(builder: (controller) {
                return controller.isLoading.value
                    ? Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Lottie.asset(_commonClass.myLoader,
                              fit: BoxFit.cover),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.cashInHandList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Slidable(
                              key: GlobalKey(),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                dismissible: DismissiblePane(onDismissed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (c) {
                                        return StatefulBuilder(builder:
                                            (context, bottomSheetSetState) {
                                          return DeleteDialog(onDelete: (){},);
                                        });
                                      });
                                }),
                                children: [
                                  SlidableAction(
                                    onPressed: (e) {},
                                    backgroundColor:
                                        _colorClass.secondaryBrandColor,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                  ),
                                  SlidableAction(
                                    onPressed: (e) {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (c) {
                                            return StatefulBuilder(builder:
                                                (context, bottomSheetSetState) {
                                              return DeleteDialog(onDelete: (){},);
                                            });
                                          });
                                    },
                                    backgroundColor: _colorClass.redColor,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                  ),
                                ],
                              ),
                              child: Material(
                                color: _colorClass.whiteColor,
                                child: InkWell(
                                  splashColor: _colorClass.bgColor,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        DetailItemCashBankScreen
                                            .detailItemCashBankRoute);
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: _colorClass
                                                  .secondaryBrandColor),
                                        ),
                                        width: _commonClass
                                            .getScreenWidth(context),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                  overflow:
                                                      TextOverflow.visible,
                                                  text:
                                                      "${controller.cashInHandList[index].paymentDate}",
                                                  textStyle:
                                                      _commonClass.getTextStyle(
                                                          12,
                                                          _colorClass
                                                              .blackColor,
                                                          CommonClass.regular)),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextWidget(
                                                  overflow:
                                                      TextOverflow.visible,
                                                  text: "Party Name : ",//${controller.cashInHandList[index]} ",
                                                  textStyle:
                                                      _commonClass.getTextStyle(
                                                          14,
                                                          _colorClass
                                                              .blackColor,
                                                          CommonClass
                                                              .semiBold)),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile.type
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                                  15,
                                                                  _colorClass
                                                                      .blackColor,
                                                                  CommonClass
                                                                      .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text:
                                                              "${controller.cashInHandList[index].typeOfTransaction}",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                                  12,
                                                                  _colorClass
                                                                      .blackColor,
                                                                  CommonClass
                                                                      .regular)),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile
                                                              .txnNo
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                                  15,
                                                                  _colorClass
                                                                      .blackColor,
                                                                  CommonClass
                                                                      .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text: "TXN No 1 ",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                                  12,
                                                                  _colorClass
                                                                      .blackColor,
                                                                  CommonClass
                                                                      .regular)),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile.mode
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                                  15,
                                                                  _colorClass
                                                                      .blackColor,
                                                                  CommonClass
                                                                      .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text: "${controller.cashInHandList[index].paymentType}",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                                  12,
                                                                  _colorClass
                                                                      .blackColor,
                                                                  CommonClass
                                                                      .regular)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile.paid
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                                  15,
                                                                  _colorClass
                                                                      .blackColor,
                                                                  CommonClass
                                                                      .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text: "₹ ${controller.cashInHandList[index].paymentInNumber}",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                                  12,
                                                                  _colorClass
                                                                      .blackColor,
                                                                  CommonClass
                                                                      .regular)),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile
                                                              .received
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                                  15,
                                                                  _colorClass
                                                                      .blackColor,
                                                                  CommonClass
                                                                      .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text: "₹ ${controller.cashInHandList[index].paymentInNumber}",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                                  12,
                                                                  _colorClass
                                                                      .blackColor,
                                                                  CommonClass
                                                                      .regular)),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile
                                                              .balance
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                                  15,
                                                                  _colorClass
                                                                      .blackColor,
                                                                  CommonClass
                                                                      .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text: "₹ ${controller.cashInHandList[index].paymentInNumber}",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                                  12,
                                                                  _colorClass
                                                                      .blackColor,
                                                                  CommonClass
                                                                      .regular)),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 5,
                                        top: 10,
                                        child: Row(
                                          children: [
                                            RotatedBox(
                                              quarterTurns: 2,
                                              child: SizedBox(
                                                width: 30,
                                                child: Opacity(
                                                  opacity: 0.2,
                                                  child: Lottie.asset(
                                                      _commonClass.swipeLeft),
                                                ),
                                              ),
                                            ),
                                            //   Text("Swipe To Edit Or Delete"),
                                            //   SizedBox(width: 10,),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
              }),
            ),
          ),
          Scaffold(
            bottomNavigationBar: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: Material(
                    color: _colorClass.mainBrandColor,
                    child: InkWell(
                      splashColor: _colorClass.bgColor,
                      onTap: () async {
                        await showMaterialModalBottomSheet(
                          context: context,
                          expand: true,
                          builder: (context) => StatefulBuilder(
                              builder: (context, bottomSheetSetState) {
                            return  AddMoneyBottomSheet(bottomSheetSetState: bottomSheetSetState);
                          }),
                        ).whenComplete(() {
                          cashAndBankController.getCashInHand();
                          cashAndBankController.getBank();
                          cashAndBankController.getTotal();
                        });
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextWidget(
                              text: _stringFile.addMoney,
                              textStyle: _commonClass.getTextStyle(15,
                                  _colorClass.whiteColor, CommonClass.bold))),
                    ),
                  )),
                  Expanded(
                      child: Material(
                    color: _colorClass.secondaryBrandColor,
                    child: InkWell(
                      splashColor: _colorClass.bgColor,
                      onTap: () {
                        showMaterialModalBottomSheet(
                          context: context,
                          expand: true,
                          builder: (context) => StatefulBuilder(
                              builder: (context, bottomSheetSetState) {
                            return const ReduceMoneyBottomSheet();
                          }),
                        );
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextWidget(
                              text: _stringFile.reduceMoney,
                              textStyle: _commonClass.getTextStyle(15,
                                  _colorClass.whiteColor, CommonClass.bold))),
                    ),
                  )),
                ],
              ),
            ),
            body: Container(
              color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
              height: _commonClass.getScreenHeight(context),
              child: GetX<CashAndBankController>(builder: (controller) {
                return controller.isLoading.value
                    ? Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Lottie.asset(_commonClass.myLoader,
                              fit: BoxFit.cover),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.bankList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Slidable(
                              key: GlobalKey(),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                dismissible: DismissiblePane(onDismissed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (c) {
                                        return StatefulBuilder(builder:
                                            (context, bottomSheetSetState) {
                                          return DeleteDialog(onDelete: (){},);
                                        });
                                      });
                                }),
                                children: [
                                  SlidableAction(
                                    onPressed: (e) {},
                                    backgroundColor:
                                    _colorClass.secondaryBrandColor,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                  ),
                                  SlidableAction(
                                    onPressed: (e) {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (c) {
                                            return StatefulBuilder(builder:
                                                (context, bottomSheetSetState) {
                                              return DeleteDialog(onDelete: (){},);
                                            });
                                          });
                                    },
                                    backgroundColor: _colorClass.redColor,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                  ),
                                ],
                              ),
                              child: Material(
                                color: _colorClass.whiteColor,
                                child: InkWell(
                                  splashColor: _colorClass.bgColor,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        DetailItemCashBankScreen
                                            .detailItemCashBankRoute);
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: _colorClass
                                                  .secondaryBrandColor),
                                        ),
                                        width: _commonClass
                                            .getScreenWidth(context),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                  overflow:
                                                  TextOverflow.visible,
                                                  text:
                                                  "${controller.bankList[index].paymentDate}",
                                                  textStyle:
                                                  _commonClass.getTextStyle(
                                                      12,
                                                      _colorClass
                                                          .blackColor,
                                                      CommonClass.regular)),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextWidget(
                                                  overflow:
                                                  TextOverflow.visible,
                                                  text: "Party Name : ",//${controller.cashInHandList[index]} ",
                                                  textStyle:
                                                  _commonClass.getTextStyle(
                                                      14,
                                                      _colorClass
                                                          .blackColor,
                                                      CommonClass
                                                          .semiBold)),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile.type
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              15,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text:
                                                          "${controller.bankList[index].typeOfTransaction}",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              12,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .regular)),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile
                                                              .txnNo
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              15,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text: "TXN No 1 ",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              12,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .regular)),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile.mode
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              15,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text: "${controller.bankList[index].paymentType}",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              12,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .regular)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile.paid
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              15,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text: "₹ ${controller.bankList[index].paymentInNumber}",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              12,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .regular)),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile
                                                              .received
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              15,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text: "₹ ${controller.bankList[index].paymentInNumber}",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              12,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .regular)),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile
                                                              .balance
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              15,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text: "₹ ${controller.bankList[index].paymentInNumber}",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              12,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .regular)),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 5,
                                        top: 10,
                                        child: Row(
                                          children: [
                                            RotatedBox(
                                              quarterTurns: 2,
                                              child: SizedBox(
                                                width: 30,
                                                child: Opacity(
                                                  opacity: 0.2,
                                                  child: Lottie.asset(
                                                      _commonClass.swipeLeft),
                                                ),
                                              ),
                                            ),
                                            //   Text("Swipe To Edit Or Delete"),
                                            //   SizedBox(width: 10,),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
              }),
            ),
          ),
          Scaffold(
            bottomNavigationBar: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: Material(
                    color: _colorClass.mainBrandColor,
                    child: InkWell(
                      splashColor: _colorClass.bgColor,
                      onTap: () async {
                        await showMaterialModalBottomSheet(
                          context: context,
                          expand: true,
                          builder: (context) => StatefulBuilder(
                              builder: (context, bottomSheetSetState) {
                                return  AddMoneyBottomSheet(bottomSheetSetState: bottomSheetSetState);
                              }),
                        ).whenComplete(() {
                          cashAndBankController.getCashInHand();
                          cashAndBankController.getBank();
                          cashAndBankController.getTotal();
                        });
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextWidget(
                              text: _stringFile.addMoney,
                              textStyle: _commonClass.getTextStyle(15,
                                  _colorClass.whiteColor, CommonClass.bold))),
                    ),
                  )),
                  Expanded(
                      child: Material(
                    color: _colorClass.secondaryBrandColor,
                    child: InkWell(
                      splashColor: _colorClass.bgColor,
                      onTap: () {
                        showMaterialModalBottomSheet(
                          context: context,
                          expand: true,
                          builder: (context) => StatefulBuilder(
                              builder: (context, bottomSheetSetState) {
                            return const ReduceMoneyBottomSheet();
                          }),
                        );
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextWidget(
                              text: _stringFile.reduceMoney,
                              textStyle: _commonClass.getTextStyle(15,
                                  _colorClass.whiteColor, CommonClass.bold))),
                    ),
                  )),
                ],
              ),
            ),
            body: Container(
              color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
              height: _commonClass.getScreenHeight(context),
              child: GetX<CashAndBankController>(builder: (controller) {
                return controller.isLoading.value
                    ? Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Lottie.asset(_commonClass.myLoader,
                              fit: BoxFit.cover),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.totalList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Slidable(
                              key: GlobalKey(),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                dismissible: DismissiblePane(onDismissed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (c) {
                                        return StatefulBuilder(builder:
                                            (context, bottomSheetSetState) {
                                          return DeleteDialog(onDelete: (){},);
                                        });
                                      });
                                }),
                                children: [
                                  SlidableAction(
                                    onPressed: (e) {},
                                    backgroundColor:
                                    _colorClass.secondaryBrandColor,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                  ),
                                  SlidableAction(
                                    onPressed: (e) {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (c) {
                                            return StatefulBuilder(builder:
                                                (context, bottomSheetSetState) {
                                              return DeleteDialog(onDelete: (){},);
                                            });
                                          });
                                    },
                                    backgroundColor: _colorClass.redColor,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                  ),
                                ],
                              ),
                              child: Material(
                                color: _colorClass.whiteColor,
                                child: InkWell(
                                  splashColor: _colorClass.bgColor,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        DetailItemCashBankScreen
                                            .detailItemCashBankRoute);
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: _colorClass
                                                  .secondaryBrandColor),
                                        ),
                                        width: _commonClass
                                            .getScreenWidth(context),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                  overflow:
                                                  TextOverflow.visible,
                                                  text:
                                                  "${controller.totalList[index].paymentDate}",
                                                  textStyle:
                                                  _commonClass.getTextStyle(
                                                      12,
                                                      _colorClass
                                                          .blackColor,
                                                      CommonClass.regular)),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextWidget(
                                                  overflow:
                                                  TextOverflow.visible,
                                                  text: "Party Name : ",//${controller.cashInHandList[index]} ",
                                                  textStyle:
                                                  _commonClass.getTextStyle(
                                                      14,
                                                      _colorClass
                                                          .blackColor,
                                                      CommonClass
                                                          .semiBold)),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile.type
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              15,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text:
                                                          "${controller.totalList[index].typeOfTransaction}",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              12,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .regular)),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile
                                                              .txnNo
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              15,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text: "TXN No 1 ",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              12,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .regular)),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile.mode
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              15,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text: "${controller.totalList[index].paymentType}",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              12,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .regular)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile.paid
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              15,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text: "₹ ${controller.totalList[index].paymentInNumber}",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              12,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .regular)),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile
                                                              .received
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              15,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text: "₹ ${controller.totalList[index].paymentInNumber}",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              12,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .regular)),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      TextWidget(
                                                          text: _stringFile
                                                              .balance
                                                              .toUpperCase(),
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              15,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .semiBold)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextWidget(
                                                          text: "₹ ${controller.totalList[index].paymentInNumber}",
                                                          textStyle: _commonClass
                                                              .getTextStyle(
                                                              12,
                                                              _colorClass
                                                                  .blackColor,
                                                              CommonClass
                                                                  .regular)),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 5,
                                        top: 10,
                                        child: Row(
                                          children: [
                                            RotatedBox(
                                              quarterTurns: 2,
                                              child: SizedBox(
                                                width: 30,
                                                child: Opacity(
                                                  opacity: 0.2,
                                                  child: Lottie.asset(
                                                      _commonClass.swipeLeft),
                                                ),
                                              ),
                                            ),
                                            //   Text("Swipe To Edit Or Delete"),
                                            //   SizedBox(width: 10,),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
              }),
            ),
          ),
        ],
      ),
    );
  }
}
