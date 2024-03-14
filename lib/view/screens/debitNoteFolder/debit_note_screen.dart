import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/controller/cashAndBankController/cash_and_bank_controller.dart';
import 'package:accountech/controller/goodsInTransitController/goods_in_transit_controller.dart';
import 'package:accountech/controller/partyController/party_controller.dart';
import 'package:accountech/view/screens/cashAndBankFolder/detail_item_cash_bank_screen.dart';
import 'package:accountech/view/screens/cashAndBankFolder/widgets/add_money_bottom_sheet.dart';
import 'package:accountech/view/screens/debitNoteFolder/add_debit_note_screen.dart';
import 'package:accountech/view/screens/goodInTransitFolder/add_good_in_transit_screen.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:accountech/widgets/commonWidget/delete_dialog.dart';
import 'package:accountech/widgets/commonWidget/purchase_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:accountech/model/goodsInTransit/goods_in_transit_list_model.dart'
    as goods;

import '../../../common/my_shared_preferences.dart';
import '../../../controller/debitNoteController/debit_note_controller.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class DebitNoteScreen extends StatefulWidget {
  static String debitNoteScreen = "/debitNoteScreen";

  const DebitNoteScreen({Key? key}) : super(key: key);

  @override
  State<DebitNoteScreen> createState() => _DebitNoteScreenState();
}

class _DebitNoteScreenState extends State<DebitNoteScreen>
    with TickerProviderStateMixin {
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();
  final StringFile _stringFile = StringFile();
  var controller = Get.find<DebitNoteController>();

  @override
  void initState() {
    super.initState();
    controller.getDebitNoteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(CommonClass.headerHeight),
        child: Column(
          children: [
            CommonAppBarWidget(
              title: TextWidget(
                text: _stringFile.debitNote,
                textStyle: _commonClass.getTextStyle(
                    20, _colorClass.blackColor, CommonClass.semiBold),
              ),
              actions: null,
            )
          ],
        ),
      ),
      body: Scaffold(
        bottomNavigationBar: SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                  child: Material(
                color: _colorClass.mainBrandColor,
                child: InkWell(
                  splashColor: _colorClass.bgColor,
                  onTap: () {
                    showMaterialModalBottomSheet(
                      context: context,
                      expand: true,
                      builder: (context) => StatefulBuilder(
                          builder: (context, bottomSheetSetState) {
                        return const AddDebitNoteScreen();
                      }),
                    ).whenComplete(() {
                      controller.resetVariables();
                      PartyController();
                    });
                  },
                  child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextWidget(
                          text: _stringFile.add,
                          textStyle: _commonClass.getTextStyle(
                              15, _colorClass.whiteColor, CommonClass.bold))),
                ),
              )),
            ],
          ),
        ),
        body: Container(
          color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
          height: _commonClass.getScreenHeight(context),
          child: GetX<DebitNoteController>(builder: (controller) {
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
                    itemCount: controller.debitNoteList.length,
                    itemBuilder: (context, index) {
                      return PurchaseListItem(
                        label:"debit note",
                        item: goods.Data(
                            id: controller.debitNoteList[index].id,
                            partyName:
                                controller.debitNoteList[index].partyName,
                            goodsInTransitNo:
                                controller.debitNoteList[index].debitNoteNo,
                            dueIn: controller.debitNoteList[index].dueIn,
                            amount: controller.debitNoteList[index].amount),
                        onDelete: () {
                          controller
                              .deleteDebitNote(
                                  controller.debitNoteList[index].id.toString())
                              .then((value) {
                            if (value != "") {
                              controller.getDebitNoteList();
                            }
                          });
                        },
                        onEdit: () {},
                      );
                    });
          }),
        ),
      ),
    );
  }
}
