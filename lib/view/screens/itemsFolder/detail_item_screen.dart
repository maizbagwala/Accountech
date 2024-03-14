import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/model/itemModel/delete_item_response.dart';
import 'package:accountech/model/itemModel/item_response_model.dart';
import 'package:accountech/view/screens/itemsFolder/widgets/item_timeline_widget.dart';
import 'package:accountech/view/screens/itemsFolder/widgets/product_details_widget.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../../../controller/itemController/item_controller.dart';
import '../../../widgets/commonWidget/delete_dialog.dart';
import '../../../widgets/textWidgets/text_widget.dart';
import '../wareHouseFolder/detail_item_warehouse_screen.dart';

class DetailItemScreen extends StatefulWidget {
  static String detailItemRoute = "/DetailItemScreen";

  final String textName;

  const DetailItemScreen(this.textName, {Key? key}) : super(key: key);

  @override
  State<DetailItemScreen> createState() => _DetailItemScreenState();
}

final ColorClass _colorClass = ColorClass();
final CommonClass _commonClass = CommonClass();
final StringFile _stringFile = StringFile();
late TabController _tabController;

class _DetailItemScreenState extends State<DetailItemScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  final itemController = Get.find<ItemController>();
bool first =true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    var data = args['model'] as Data;
    // print(data.itemId);
    if(first){


      first=false;
    }
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: const Size.fromHeight(CommonClass.headerHeight + 220),
        child: AppBarWidget(onDelete: (){
          deleteItem(data.itemId.toString());
        },),
      ),
      body: Container(
        color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
        height: _commonClass.getScreenHeight(context),
        child: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            ItemTimeLineWidget(),
            SingleChildScrollView(child: ProductDetailWidget())
          ],
        ),
      ),
    );
  }
  Future<void> deleteItem(String id) async {

    ItemController().deleteItem(id).then((value) {
      if (value != "") {
        var res = value as DeleteItemResponse;
        if (res.success == true) {

          print("deleted");
          Navigator.pop(context);
        }
      }
    });
  }
}

class AppBarWidget extends StatelessWidget {
  final Function onDelete;
  const AppBarWidget({Key? key, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonAppBarWidget(
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Card(
                color: _colorClass.greenColor,
                child: InkWell(
                  onTap: () {},
                  splashColor: _colorClass.greyColor.withAlpha(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 15,
                      child: TextWidget(
                          text: _stringFile.edit,
                          textStyle: _commonClass.getTextStyle(
                              13, _colorClass.whiteColor, CommonClass.medium)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: _colorClass.redColor,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (c) {
                          return StatefulBuilder(
                              builder: (context, bottomSheetSetState) {
                                return DeleteDialog(
                                  onDelete: () {
                                    onDelete();
                                    // deleteItem(data.itemId.toString());
                                  },
                                );
                              });
                        });

                  },
                  splashColor: _colorClass.greyColor.withAlpha(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 15,
                      child: TextWidget(
                          text: _stringFile.delete,
                          textStyle: _commonClass.getTextStyle(
                              13, _colorClass.whiteColor, CommonClass.medium)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const AppBarBelowDataWidget()
      ],
    );
  }



}

class AppBarBelowDataWidget extends StatefulWidget {
  const AppBarBelowDataWidget({Key? key}) : super(key: key);

  @override
  State<AppBarBelowDataWidget> createState() => _AppBarBelowDataWidgetState();
}

class _AppBarBelowDataWidgetState extends State<AppBarBelowDataWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: _commonClass.getScreenWidth(context),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: "Test Product",
                                textStyle: _commonClass.getTextStyle(14,
                                    _colorClass.blackColor, CommonClass.medium),
                              ),
                              TextWidget(
                                text: "Test Product Category",
                                textStyle: _commonClass.getTextStyle(12,
                                    _colorClass.blackColor, CommonClass.light),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {},
                              splashColor: _colorClass.bgColor,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: TextWidget(
                                  overflow: null,
                                  text: _stringFile.viewItemReport,
                                  textStyle: _commonClass.getTextStyle(
                                      12,
                                      _colorClass.secondaryBrandColor,
                                      CommonClass.light),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: _commonClass.getScreenWidth(context),
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                    text: _stringFile.salePrice,
                                    textStyle: _commonClass.getTextStyle(
                                        11,
                                        _colorClass.blackColor,
                                        CommonClass.medium)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                    text: "₹ 220",
                                    textStyle: _commonClass.getTextStyle(
                                        10,
                                        _colorClass.blackColor,
                                        CommonClass.light)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                    text: _stringFile.purchasePrice,
                                    textStyle: _commonClass.getTextStyle(
                                        11,
                                        _colorClass.blackColor,
                                        CommonClass.medium)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                    text: "₹ 225",
                                    textStyle: _commonClass.getTextStyle(
                                        10,
                                        _colorClass.blackColor,
                                        CommonClass.light)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                    text: _stringFile.stockQuantity,
                                    textStyle: _commonClass.getTextStyle(
                                        11,
                                        _colorClass.blackColor,
                                        CommonClass.medium)),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        DetailItemWarehouseScreen
                                            .detailItemWarehouseRoute);
                                  },
                                  child: TextWidget(
                                      text: "25.0 (PCS)",
                                      textStyle: _commonClass.getTextStyle(
                                          10,
                                          _colorClass.greenColor,
                                          CommonClass.light)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                    text: _stringFile.stockValue,
                                    textStyle: _commonClass.getTextStyle(
                                        11,
                                        _colorClass.blackColor,
                                        CommonClass.medium)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                    text: "₹ 0.0",
                                    textStyle: _commonClass.getTextStyle(
                                        10,
                                        _colorClass.blackColor,
                                        CommonClass.light)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                    text: _stringFile.wholesalePrice,
                                    textStyle: _commonClass.getTextStyle(
                                        11,
                                        _colorClass.blackColor,
                                        CommonClass.medium)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                    text: "--",
                                    textStyle: _commonClass.getTextStyle(
                                        10,
                                        _colorClass.blackColor,
                                        CommonClass.light)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                    text: _stringFile.mrp,
                                    textStyle: _commonClass.getTextStyle(
                                        11,
                                        _colorClass.blackColor,
                                        CommonClass.medium)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                    text: "--",
                                    textStyle: _commonClass.getTextStyle(
                                        10,
                                        _colorClass.greenColor,
                                        CommonClass.light)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: _colorClass.whiteColor,
              child: TabBar(
                indicatorColor: _colorClass.mainBrandColor,
                labelColor: _colorClass.blackColor,
                controller: _tabController,
                tabs: <Widget>[
                  Tab(
                    text: _stringFile.itemTimeline,
                  ),
                  Tab(
                    text: _stringFile.details,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
