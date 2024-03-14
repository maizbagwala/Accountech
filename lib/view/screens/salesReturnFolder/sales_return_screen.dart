import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/controller/partyController/party_controller.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:accountech/widgets/commonWidget/purchase_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:accountech/model/goodsInTransit/goods_in_transit_list_model.dart';
import '../../../controller/salesReturnController/sales_return_controller.dart';
import '../../../widgets/textWidgets/text_widget.dart';
import 'add_sales_return_screen.dart';

class SalesReturnScreen extends StatefulWidget {
  static String salesReturnScreenRoute = "/SalesReturnScreen";

  const SalesReturnScreen({Key? key}) : super(key: key);

  @override
  State<SalesReturnScreen> createState() => _SalesReturnScreenState();
}

class _SalesReturnScreenState extends State<SalesReturnScreen>
    with TickerProviderStateMixin {
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();
  final StringFile _stringFile = StringFile();
  var controller = Get.find<SalesReturnController>();

  @override
  void initState() {
    super.initState();
    controller.getSalesReturnList();
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
                text: _stringFile.salesReturn,
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
                                return const AddSalesReturnScreen();
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
          child: GetX<SalesReturnController>(builder: (controller) {
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
                itemCount: controller.salesReturnList.length,
                itemBuilder: (context, index) {
                  return PurchaseListItem(
                    label: "Sales Return",
                    item: Data(
                        id: controller.salesReturnList[index].id,
                        partyName:
                        controller.salesReturnList[index].partyName,
                        goodsInTransitNo: controller
                            .salesReturnList[index].salesReturnNo,
                        dueIn: controller.salesReturnList[index].dueIn,
                        amount:
                        controller.salesReturnList[index].amount),
                    onDelete: () {
                      controller
                          .deleteSaleReturn(controller
                          .salesReturnList[index].id
                          .toString())
                          .then((value) {
                        if (value != "") {
                          controller.getSalesReturnList();
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
