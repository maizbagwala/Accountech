import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/controller/partyController/party_controller.dart';
import 'package:accountech/controller/proformaInvoiceController/proforma_invoice_controller.dart';
import 'package:accountech/controller/purchaseOrderController/purchase_order_controller.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:accountech/widgets/commonWidget/purchase_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:accountech/model/goodsInTransit/goods_in_transit_list_model.dart';

import '../../../widgets/textWidgets/text_widget.dart';
import 'add_proforma_invoice_screen.dart';

class ProformaInvoiceScreen extends StatefulWidget {
  static String proformaInvoiceScreenRoute = "/ProformaInvoiceScreen";

  const ProformaInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<ProformaInvoiceScreen> createState() => _ProformaInvoiceScreenState();
}

class _ProformaInvoiceScreenState extends State<ProformaInvoiceScreen>
    with TickerProviderStateMixin {
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();
  final StringFile _stringFile = StringFile();
  var controller = Get.find<ProformaInvoiceController>();

  @override
  void initState() {
    super.initState();
    controller.getProformaInvoiceList();
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
                text: _stringFile.proformaInvoice,
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
                                return const AddProformaInvoiceScreen();
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
          child: GetX<ProformaInvoiceController>(builder: (controller) {
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
                itemCount: controller.proformaInvoiceList.length,
                itemBuilder: (context, index) {
                  return PurchaseListItem(
                    label: "Proforma Invoice",
                    item: Data(
                        id: controller.proformaInvoiceList[index].id,
                        partyName:
                        controller.proformaInvoiceList[index].partyName,
                        goodsInTransitNo: controller
                            .proformaInvoiceList[index].invoiceNo,
                        dueIn: controller.proformaInvoiceList[index].dueIn,
                        amount:
                        controller.proformaInvoiceList[index].amount),
                    onDelete: () {
                      controller
                          .deleteProformaInvoice(controller
                          .proformaInvoiceList[index].id
                          .toString())
                          .then((value) {
                        if (value != "") {
                          controller.getProformaInvoiceList();
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
