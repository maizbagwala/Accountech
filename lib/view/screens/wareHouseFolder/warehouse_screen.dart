import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/controller/warehouseController/warehouse_controller.dart';
import 'package:accountech/model/commonModels/delete_response.dart';
import 'package:accountech/view/screens/wareHouseFolder/detail_item_warehouse_screen.dart';
import 'package:accountech/view/screens/wareHouseFolder/widgets/create_warehouse_bottom_sheet.dart';
import 'package:accountech/view/screens/wareHouseFolder/widgets/edit_warehouse_bottom_sheet.dart';
import 'package:accountech/view/screens/wareHouseFolder/widgets/warehouse_list_item.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../widgets/commonWidget/delete_dialog.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class WarehouseScreen extends StatefulWidget {
  static String wareHouseRoute = "/WarehouseScreen";

  const WarehouseScreen({Key? key}) : super(key: key);

  @override
  State<WarehouseScreen> createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends State<WarehouseScreen>
    with TickerProviderStateMixin {
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();
  final List<int> _itemList = [1, 2, 3, 4, 5, 6];
  var controller = Get.find<WarehouseController>();

  @override
  void initState() {
    super.initState();
    controller.getWarehouse();
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
                text: "Warehouse",
                textStyle: _commonClass.getTextStyle(
                    20, _colorClass.blackColor, CommonClass.semiBold),
              ),
              actions: null,
            ),
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
                  onTap: () async {
                    await showMaterialModalBottomSheet(
                      context: context,
                      expand: true,
                      builder: (context) => StatefulBuilder(
                          builder: (context, bottomSheetSetState) {
                        return const CreateWarehouseBottomSheet();
                      }),
                    ).whenComplete(() => controller.getWarehouse());
                  },
                  child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextWidget(
                          text: "Create Warehouse",
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
          child: GetX<WarehouseController>(builder: (controller) {
            print(controller.warehouseList.length);
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
                    itemCount: controller.warehouseList.length,
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
                                      return DeleteDialog(
                                        onDelete: () {
                                          controller
                                              .deleteWarehouse(controller
                                                  .warehouseList[index].id)
                                              .then((value) {
                                            if (value != "") {
                                              controller.getWarehouse();
                                            }
                                          });
                                        },
                                      );
                                    });
                                  });
                            }),
                            children: [
                              SlidableAction(
                                onPressed: (e) async {
                                  await showMaterialModalBottomSheet(
                                    context: context,
                                    expand: true,
                                    builder: (context) => StatefulBuilder(
                                        builder:
                                            (context, bottomSheetSetState) {
                                      return EditWarehouseBottomSheet(controller
                                          .warehouseList[index]);
                                    }),
                                  ).whenComplete(
                                      () => controller.getWarehouse());
                                },
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
                                          return DeleteDialog(
                                            onDelete: () {
                                              controller
                                                  .deleteWarehouse(controller
                                                      .warehouseList[index].id)
                                                  .then((value) {
                                                if (value != "") {
                                                  controller.getWarehouse();
                                                }
                                              });
                                            },
                                          );
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
                                      DetailItemWarehouseScreen
                                          .detailItemWarehouseRoute);
                                },
                                child: WarehouseListItem(
                                    controller.warehouseList[index])),
                          ),
                        ),
                      );
                    });
          }),
        ),
      ),
    );
  }
}
