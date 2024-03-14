import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/controller/itemController/item_controller.dart';
import 'package:accountech/view/screens/itemsFolder/create_item_screen.dart';
import 'package:accountech/view/screens/itemsFolder/detail_item_screen.dart';
import 'package:accountech/view/screens/itemsFolder/widgets/items_below_app_bar_widget.dart';
import 'package:accountech/view/screens/itemsFolder/widgets/items_common_row_widget.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../widgets/textWidgets/text_widget.dart';

class ItemsScreen extends StatefulWidget {
  final String textName;

  const ItemsScreen(this.textName, {Key? key}) : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();
  final StringFile _stringFile = StringFile();
  final itemController = Get.find<ItemController>();

  @override
  void initState() {
    super.initState();
    itemController.getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(CommonClass.headerHeight + 51),
        child: Column(
          children: [
            CommonAppBarItemsWidget(),
            Container(
                margin: const EdgeInsets.only(top: 5),
                child: const ItemsBelowAppBarWidget()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateItemScreen.createItemScreenRoute);
        },
        backgroundColor: _colorClass.mainBrandColor,
        tooltip: _stringFile.createNewItem,
        child: const Icon(FontAwesomeIcons.circlePlus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
        height: _commonClass.getScreenHeight(context),
        child: GetX<ItemController>(builder: (controller) {
          if (!controller.isLoading.value && controller.itemList.isEmpty) {
            return TextWidget(
                text: "No Data...",
                textStyle: _commonClass.getTextStyle(
                    15, _colorClass.blackColor, CommonClass.semiBold));
          } else if (controller.isLoading.value) {
            return Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset(_commonClass.myLoader, fit: BoxFit.cover),
              ),
            );
          } else {
            return GridView.builder(
                shrinkWrap: true,
                itemCount: controller.itemList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 16 / 14, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return ItemsCommonRowWidget(
                    onTap: (String value) {
                      Navigator.pushNamed(
                              context, DetailItemScreen.detailItemRoute,
                              arguments: {"model": controller.itemList[index]})
                          .then((value) {
                        itemController.getItems();
                      });
                    },
                    data: controller.itemList[index],
                  );
                });
          }
        }),
      ),
    );
  }
}
