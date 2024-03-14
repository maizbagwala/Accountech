import 'dart:convert';
import 'dart:io';

import 'package:accountech/common/common_class.dart';
import 'package:accountech/model/itemModel/item_category_response.dart'
    as category;
import 'package:accountech/model/itemModel/item_series_response.dart' as series;
import 'package:accountech/model/itemModel/item_brand_response.dart' as brand;
import 'package:accountech/model/itemModel/item_size_response.dart' as size;
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:accountech/widgets/textFieldWidgets/text_field_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../common/color_class.dart';
import '../../../common/string_file.dart';
import '../../../controller/itemController/item_controller.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class CreateItemScreen extends StatefulWidget {
  static String createItemScreenRoute = "/CreateItemScreen";

  const CreateItemScreen({Key? key}) : super(key: key);

  @override
  State<CreateItemScreen> createState() => _CreateItemScreenState();
}

final ColorClass _colorClass = ColorClass();
final StringFile _stringFile = StringFile();
final CommonClass _commonClass = CommonClass();

var itemNameController = TextEditingController();
var itemAlterNameController = TextEditingController();
var itemCodeController = TextEditingController();
var remarkController = TextEditingController();
var salesPriceController = TextEditingController();
var purchasePriceController = TextEditingController();
var mrpController = TextEditingController();
var wholeSalePriceController = TextEditingController();
var openingStockController = TextEditingController();
var reorderStockController = TextEditingController();

bool _batchForThisItem = false;
bool _reOrderWarning = false;
bool? _salePriceWithTax = false;
bool? _purchasePriceWithTax = false;
int _discountStructureCounter = 1;
var itemController = Get.find<ItemController>();

class _CreateItemScreenState extends State<CreateItemScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      itemController.getCategory();
      itemController.getSeries();
      itemController.getBrand();
      itemController.getSize();
    });

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(CommonClass.headerHeight + 285),
            child: Container(
              color: _colorClass.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonAppBarWidget(
                    title: TextWidget(
                      text: _stringFile.createNewItem,
                      textStyle: _commonClass.getTextStyle(
                          20, _colorClass.blackColor, CommonClass.semiBold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldWidget(
                            textEditingController: itemNameController,
                            maxLength: null,
                            type: TextInputType.text,
                            formatter: null,
                            text: _stringFile.itemName,
                            onTypeCallBack: (e) {}),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFieldWidget(
                            textEditingController: itemAlterNameController,
                            maxLength: null,
                            type: TextInputType.text,
                            formatter: null,
                            text: _stringFile.alternateItemName,
                            onTypeCallBack: (e) {}),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFieldWidget(
                            textEditingController: itemCodeController,
                            maxLength: null,
                            type: TextInputType.text,
                            formatter: null,
                            text: _stringFile.itemCode,
                            onTypeCallBack: (e) {}),
                        const SizedBox(
                          height: 15,
                        ),
                        // TextWidget(
                        //   overflow: TextOverflow.ellipsis,
                        //   text: _stringFile.itemType,
                        //   textStyle: _commonClass.getTextStyle(
                        //       14, _colorClass.blackColor, CommonClass.medium),
                        // ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        // GroupButton(
                        //   isRadio: true,
                        //   onSelected: (index, isSelected) {},
                        //   buttons: [_stringFile.product, _stringFile.service],
                        //   controller: GroupButtonController(
                        //     selectedIndex: 0,
                        //   ),
                        //   options: GroupButtonOptions(
                        //       selectedColor:
                        //           _colorClass.mainBrandColor.withAlpha(30),
                        //       unselectedColor: _colorClass.bgColor,
                        //       selectedTextStyle:
                        //           TextStyle(color: _colorClass.mainBrandColor),
                        //       selectedBorderColor: _colorClass.mainBrandColor,
                        //       unselectedBorderColor: _colorClass.transparent,
                        //       borderRadius: BorderRadius.circular(20)),
                        // ),
                        TabBar(
                          indicatorColor: _colorClass.mainBrandColor,
                          labelColor: _colorClass.blackColor,
                          controller: _tabController,
                          tabs: <Widget>[
                            Tab(
                              text: _stringFile.details,
                            ),
                            Tab(
                              text: _stringFile.pricing,
                            ),
                            Tab(
                              text: _stringFile.stock,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: const Icon(FontAwesomeIcons.gear),
        //   backgroundColor: _colorClass.mainBrandColor,
        //   tooltip: _stringFile.settings,
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Container(
          height: _commonClass.getScreenHeight(context),
          width: _commonClass.getScreenWidth(context),
          color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
          child: TabBarView(
            controller: _tabController,
            children: const [
              OtherCard(),
              PricingCard(),
              StockCard(),
            ],
          ),
        ),
        bottomNavigationBar: Material(
          color: _colorClass.mainBrandColor,
          child: InkWell(
            onTap: () {
              if (itemCodeController.text.toString().isNotEmpty &&
                  itemNameController.text.toString().isNotEmpty &&
                  itemAlterNameController.text.toString().isNotEmpty) {
                save(
                    itemCodeController.text.toString(),
                    itemNameController.text.toString(),
                    itemAlterNameController.text.toString(),
                    itemController.categoryParentId.value.toString(),
                    itemController.subCategoryId.value.toString(),
                    itemController.seriesParentId.value.toString(),
                    itemController.subSeriesId.value.toString(),
                    itemController.brandId.value.toString(),
                    itemController.sizeId.value.toString(),
                    remarkController.text.toString(),
                    itemController.hsn.value.toString(),
                    itemController.gst.value.toString(),
                    salesPriceController.text.toString(),
                    purchasePriceController.text.toString(),
                    mrpController.text.toString(),
                    _salePriceWithTax! ? "1" : "0",
                    _purchasePriceWithTax! ? "1" : "0",
                    _batchForThisItem ? "1" : "0",
                    "0",
                    "0",
                    "0",
                    openingStockController.text.toString(),
                    itemController.stockAsOnDate.value.toString(),
                    "0",
                    _reOrderWarning ? "1" : "0",
                    reorderStockController.text.toString(),
                    "",
                    "",
                    "",
                    itemController.imageList
                        .map((element) => element.toString())
                        .toList());
              }

            },
            splashColor: _colorClass.bgColor,
            child: Container(
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextWidget(
                    text: _stringFile.save,
                    textStyle: _commonClass.getTextStyle(
                        15, _colorClass.whiteColor, CommonClass.bold))),
          ),
        ),
      ),
    );
  }

  void save(
      item_code,
      item_name,
      item_alt_name,
      category_id,
      subcategory_id,
      series_id,
      subseries_id,
      brand_id,
      size_id,
      remark,
      hsn,
      gst,
      sales_price,
      purchase_price,
      mrp,
      sales_tax_include,
      purchase_tax_include,
      is_batch,
      batch_warehouse,
      batch_no,
      qty,
      opening_stock,
      stock_date,
      warehouse,
      reorder_warning,
      reorder_stock,
      main_unit_id,
      unit_id,
      conversation_rate,
      List<String> images) {
    ItemController()
        .addItem(
            item_code,
            item_name,
            item_alt_name,
            category_id,
            subcategory_id,
            series_id,
            subseries_id,
            brand_id,
            size_id,
            remark,
            hsn,
            gst,
            sales_price,
            purchase_price,
            mrp,
            sales_tax_include,
            purchase_tax_include,
            is_batch,
            batch_warehouse,
            batch_no,
            qty,
            opening_stock,
            stock_date,
            warehouse,
            reorder_warning,
            reorder_stock,
            main_unit_id,
            unit_id,
            conversation_rate,
            images)
        .then((value) {
          if(value){
            Navigator.pop(context);
          }
    });
  }
}

class OtherCard extends StatefulWidget {
  const OtherCard({Key? key}) : super(key: key);

  @override
  State<OtherCard> createState() => _OtherCardState();
}

class _OtherCardState extends State<OtherCard> {
  ExpandableController controller = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return ExpandableTheme(
      data: ExpandableThemeData(
        iconColor: _colorClass.mainBrandMaterialColor,
        collapseIcon: FontAwesomeIcons.circleMinus,
        expandIcon: FontAwesomeIcons.circlePlus,
        useInkWell: true,
      ),
      child: SingleChildScrollView(
        child: Card(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetX<ItemController>(builder: (controller) {
                  return controller.imageList.length == 5
                      ? Container()
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Card(
                            color: _colorClass.mainBrandColor,
                            child: InkWell(
                              splashColor: _colorClass.bgColor,
                              onTap: () async {
                                var image = await CommonClass().pickImage();
                                itemController.imageList.add(image?.paths[0]);
                                print(image);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextWidget(
                                    text: _stringFile.addMoreImages,
                                    textStyle: _commonClass.getTextStyle(
                                        12,
                                        _colorClass.whiteColor,
                                        CommonClass.medium)),
                              ),
                            ),
                          ),
                        );
                }),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 82,
                  child: GetX<ItemController>(builder: (controller) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: controller.imageList.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        border: Border.all(
                                            color: _colorClass
                                                .secondaryBrandColor)),
                                    child: Image.file(
                                      File(controller.imageList[index]),
                                      width: 40,
                                      height: 40,
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 62,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: _colorClass.secondaryBrandColor,
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        border: Border.all(
                                            color: _colorClass
                                                .secondaryBrandColor)),
                                    child: InkWell(
                                      splashColor: _colorClass.bgColor,
                                      onTap: () {
                                        controller.imageList.removeAt(index);
                                      },
                                      child: TextWidget(
                                          text: "DELETE",
                                          textStyle: _commonClass.getTextStyle(
                                              10,
                                              _colorClass.whiteColor,
                                              CommonClass.medium)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          );
                        });
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GetX<ItemController>(builder: (controller) {
                        return DropdownSearch<category.Data>(
                          popupProps: const PopupProps.modalBottomSheet(
                            showSearchBox: true,
                          ),
                          itemAsString: (d) {
                            return d.categoryName!;
                          },
                          items: controller.categoryList.toList(),
                          onChanged: (v) {
                            controller.categoryParentId.value =
                                v!.id.toString();
                            itemController.getSubCategory(v.id);
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: _colorClass.secondaryBrandColor),
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 7, 0, 0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            labelText: _stringFile.selectCategory,
                          )), /*selectedItem: controller.categoryList.isNotEmpty?controller.categoryList[0].categoryName:""*/
                        );
                      }),
                    ),
                    Card(
                      color: _colorClass.mainBrandColor,
                      child: InkWell(
                        splashColor: _colorClass.bgColor,
                        onTap: () async {
                          showModalBottomSheet(
                              context: context,
                              builder: (c) {
                                return StatefulBuilder(
                                    builder: (context, bottomSheetSetState) {
                                  return const AddBottomSheet(
                                    title: "Category",
                                  );
                                });
                              });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GetX<ItemController>(builder: (controller) {
                        return DropdownSearch<category.Data>(
                          popupProps: const PopupProps.modalBottomSheet(
                            showSearchBox: true,
                          ),
                          itemAsString: (d) {
                            return d.categoryName!;
                          },
                          items: controller.subCategoryList.toList(),
                          onChanged: (v) {
                            controller.subCategoryId.value = v!.id.toString();
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: _colorClass.secondaryBrandColor),
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 7, 0, 0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            labelText: _stringFile.selectSubCategory,
                          )),
                        );
                        // selectedItem: controller.subCategoryList.isNotEmpty?controller.subCategoryList[0].categoryName:"");
                      }),
                    ),
                    Card(
                      color: _colorClass.mainBrandColor,
                      child: InkWell(
                        splashColor: _colorClass.bgColor,
                        onTap: () async {
                          showModalBottomSheet(
                              context: context,
                              builder: (c) {
                                return StatefulBuilder(
                                    builder: (context, bottomSheetSetState) {
                                  return GetX<ItemController>(
                                      builder: (controller) {
                                    return AddBottomSheet(
                                      title: "Sub Category",
                                      id: controller.categoryParentId.value
                                          .toString(),
                                    );
                                  });
                                });
                              });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GetX<ItemController>(builder: (controller) {
                        return DropdownSearch<series.Data>(
                          popupProps: const PopupProps.modalBottomSheet(
                            showSearchBox: true,
                          ),
                          itemAsString: (d) => d.seriesName!,
                          items: controller.seriesList.toList(),
                          onChanged: (v) {
                            controller.seriesParentId.value = v!.id.toString();
                            itemController.getSubSeries(v.id);
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: _colorClass.secondaryBrandColor),
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 7, 0, 0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            labelText: _stringFile.selectSeries,
                          )),
                        );
                        // selectedItem: controller.seriesList.isNotEmpty?controller.seriesList[0].seriesName:"");
                      }),
                    ),
                    Card(
                      color: _colorClass.mainBrandColor,
                      child: InkWell(
                        splashColor: _colorClass.bgColor,
                        onTap: () async {
                          showModalBottomSheet(
                              context: context,
                              builder: (c) {
                                return StatefulBuilder(
                                    builder: (context, bottomSheetSetState) {
                                  return const AddBottomSheet(
                                    title: "Series",
                                  );
                                });
                              });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GetX<ItemController>(builder: (controller) {
                        return DropdownSearch<series.Data>(
                          popupProps: const PopupProps.modalBottomSheet(
                            showSearchBox: true,
                          ),
                          itemAsString: (d) => d.seriesName!,
                          items: controller.subSeriesList.toList(),
                          onChanged: (v) {
                            controller.subSeriesId.value = v!.id.toString();
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: _colorClass.secondaryBrandColor),
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 7, 0, 0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            labelText: _stringFile.selectSubSeries,
                          )),
                        );
                      }),
                    ),
                    Card(
                      color: _colorClass.mainBrandColor,
                      child: InkWell(
                        splashColor: _colorClass.bgColor,
                        onTap: () async {
                          showModalBottomSheet(
                              context: context,
                              builder: (c) {
                                return StatefulBuilder(
                                    builder: (context, bottomSheetSetState) {
                                  return GetX<ItemController>(
                                      builder: (controller) {
                                    return AddBottomSheet(
                                      title: "Sub Series",
                                      id: controller.seriesParentId.value
                                          .toString(),
                                    );
                                  });
                                });
                              });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GetX<ItemController>(builder: (controller) {
                        return DropdownSearch<brand.Data>(
                          popupProps: const PopupProps.modalBottomSheet(
                            showSearchBox: true,
                          ),
                          itemAsString: (d) => d.brandName!,
                          items: controller.brandList.toList(),
                          onChanged: (v) {
                            controller.brandId.value = v!.id.toString();
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: _colorClass.secondaryBrandColor),
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 7, 0, 0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            labelText: _stringFile.selectBrand,
                          )),
                        );
                        // selectedItem: "Brand 1");
                      }),
                    ),
                    Card(
                      color: _colorClass.mainBrandColor,
                      child: InkWell(
                        splashColor: _colorClass.bgColor,
                        onTap: () async {
                          showModalBottomSheet(
                              context: context,
                              builder: (c) {
                                return StatefulBuilder(
                                    builder: (context, bottomSheetSetState) {
                                  return const AddBottomSheet(
                                    title: "Brand",
                                  );
                                });
                              });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GetX<ItemController>(builder: (controller) {
                        return DropdownSearch<size.Data>(
                          popupProps: const PopupProps.modalBottomSheet(
                            showSearchBox: true,
                          ),
                          itemAsString: (d) => d.sizeName!,
                          items: controller.sizeList.toList(),
                          onChanged: (v) {
                            controller.sizeId.value = v!.id.toString();
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: _colorClass.secondaryBrandColor),
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 7, 0, 0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _colorClass.secondaryBrandColor,
                                    width: 1)),
                            labelText: _stringFile.selectSize,
                          )),
                        );
                        // selectedItem: "Size 1");
                      }),
                    ),
                    Card(
                      color: _colorClass.mainBrandColor,
                      child: InkWell(
                        splashColor: _colorClass.bgColor,
                        onTap: () async {
                          showModalBottomSheet(
                              context: context,
                              builder: (c) {
                                return StatefulBuilder(
                                    builder: (context, bottomSheetSetState) {
                                  return const AddBottomSheet(
                                    title: "Size",
                                  );
                                });
                              });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     TextWidget(
                //       text: _stringFile.showInOnlineStore,
                //       textStyle: _commonClass.getTextStyle(
                //           15, _colorClass.blackColor, CommonClass.medium),
                //     ),
                //     FlutterSwitch(
                //       activeColor: _colorClass.secondaryBrandColor,
                //       height: 20,
                //       toggleSize: 10,
                //       width: 40,
                //       value: status1,
                //       onToggle: (val) {
                //         setState(() {
                //           status1 = val;
                //         });
                //       },
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                    textEditingController: remarkController,
                    maxLength: null,
                    type: TextInputType.text,
                    formatter: null,
                    text: _stringFile.addRemark,
                    onTypeCallBack: (e) {}),
                ExpandableNotifier(
                    child: ScrollOnExpand(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ExpandablePanel(
                        controller: controller,
                        theme: const ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
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
                                    child: TextWidget(
                                  text: _stringFile.addGSTAndTaxDetails,
                                  textStyle: _commonClass.getTextStyle(
                                      15,
                                      _colorClass.blackColor,
                                      CommonClass.medium),
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
                            DropdownSearch<String>(
                                popupProps: const PopupProps.modalBottomSheet(
                                  showSearchBox: true,
                                ),
                                items: const [
                                  "HSN 1",
                                  "HSN 2",
                                  "HSN 3",
                                  'HSN 4',
                                  'HSN 5'
                                ],
                                onChanged: (v) {
                                  itemController.hsn.value = v.toString();
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: _colorClass.secondaryBrandColor),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(12, 7, 0, 0),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              _colorClass.secondaryBrandColor,
                                          width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              _colorClass.secondaryBrandColor,
                                          width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              _colorClass.secondaryBrandColor,
                                          width: 1)),
                                  labelText: _stringFile.hsn,
                                )),
                                selectedItem: "HSN 1"),
                            const SizedBox(
                              height: 10,
                            ),
                            DropdownSearch<String>(
                                popupProps: const PopupProps.modalBottomSheet(
                                  showSearchBox: true,
                                ),
                                items: const [
                                  "111",
                                  "222",
                                  "333",
                                  '444',
                                  '555'
                                ],
                                onChanged: (v) {
                                  itemController.gst.value = v.toString();
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: _colorClass.secondaryBrandColor),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(12, 7, 0, 0),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              _colorClass.secondaryBrandColor,
                                          width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              _colorClass.secondaryBrandColor,
                                          width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              _colorClass.secondaryBrandColor,
                                          width: 1)),
                                  labelText: _stringFile.gst,
                                )),
                                selectedItem: "GST 1"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StockCard extends StatefulWidget {
  const StockCard({Key? key}) : super(key: key);

  @override
  State<StockCard> createState() => _StockCardState();
}

class _StockCardState extends State<StockCard> {
  int _batchCounter = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextWidget(
                    text: _stringFile.batchingForThisItem,
                    textStyle: _commonClass.getTextStyle(
                        15, _colorClass.blackColor, CommonClass.medium),
                  ),
                  FlutterSwitch(
                    activeColor: _colorClass.secondaryBrandColor,
                    height: 20,
                    toggleSize: 10,
                    width: 40,
                    value: _batchForThisItem,
                    onToggle: (val) {
                      setState(() {
                        _batchForThisItem = val;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              _batchForThisItem
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Card(
                            color: _colorClass.mainBrandColor,
                            child: InkWell(
                              splashColor: _colorClass.bgColor,
                              onTap: () {
                                setState(() {
                                  _batchCounter += 1;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextWidget(
                                    text: _stringFile.addMoreBatches,
                                    textStyle: _commonClass.getTextStyle(
                                        12,
                                        _colorClass.whiteColor,
                                        CommonClass.medium)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: _batchCounter,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 0,
                                color: _colorClass.secondaryBrandColor
                                    .withAlpha(CommonClass.bgAlpha),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          splashColor: _colorClass.bgColor,
                                          onTap: () {
                                            setState(() {
                                              _batchCounter -= 1;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 18.0, horizontal: 10),
                                            child: Icon(
                                              FontAwesomeIcons.trash,
                                              color: _colorClass.redColor,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DropdownSearch<String>(
                                          popupProps:
                                              const PopupProps.modalBottomSheet(
                                            showSearchBox: true,
                                          ),
                                          items: const [
                                            "Warehouse 1",
                                            "Warehouse 2",
                                            "Warehouse 3",
                                            'Warehouse 4',
                                            'Warehouse 5'
                                          ],
                                          onChanged: print,
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                            labelStyle: TextStyle(
                                                color: _colorClass
                                                    .secondaryBrandColor),
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    12, 7, 0, 0),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: _colorClass
                                                        .secondaryBrandColor,
                                                    width: 1)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: _colorClass
                                                        .secondaryBrandColor,
                                                    width: 1)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: _colorClass
                                                        .secondaryBrandColor,
                                                    width: 1)),
                                            labelText:
                                                _stringFile.chooseWarehouse,
                                          )),
                                          selectedItem: "Warehouse 1"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: TextFieldWidget(
                                                maxLength: null,
                                                type: TextInputType.text,
                                                formatter: null,
                                                text: _stringFile.batchNo,
                                                onTypeCallBack: (e) {}),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: TextFieldWidget(
                                                maxLength: null,
                                                type: TextInputType.text,
                                                formatter: null,
                                                text: _stringFile.batchQTY,
                                                onTypeCallBack: (e) {}),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    )
                  : Container(),
              const SizedBox(
                height: 15,
              ),
              TextFieldWidget(
                  textEditingController: openingStockController,
                  hasSuffix: "IN",
                  maxLength: null,
                  type: TextInputType.text,
                  formatter: null,
                  text: _stringFile.openingStock,
                  onTypeCallBack: (e) {}),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: _colorClass.secondaryBrandColor)),
                child: InkWell(
                  splashColor: _colorClass.bgColor,
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (c) {
                          return StatefulBuilder(
                              builder: (context, bottomSheetSetState) {
                            return const BottomSheetForDateSelection();
                          });
                        });
                  },
                  child: ListTile(
                    title: GetX<ItemController>(builder: (controller) {
                      return TextWidget(
                          text:
                              "${_stringFile.stockAsOn} (${controller.stockAsOnDate})",
                          textStyle: _commonClass.getTextStyle(
                              12,
                              _colorClass.secondaryBrandColor,
                              CommonClass.medium));
                    }),
                    trailing: Icon(
                      FontAwesomeIcons.calendar,
                      color: _colorClass.secondaryBrandColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: GetX<ItemController>(builder: (controller) {
                      return DropdownSearch<String>(
                        popupProps: const PopupProps.modalBottomSheet(
                          showSearchBox: true,
                        ),
                        // itemAsString: (d) {
                        //   return d.categoryName!;
                        // },
                        items: controller.unitList.toList(),
                        onChanged: (v) {
                          // controller.categoryParentId.value=v!.id.toString();
                          // itemController.getSubCategory(v.id);
                        },
                        dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                          labelStyle:
                              TextStyle(color: _colorClass.secondaryBrandColor),
                          contentPadding:
                              const EdgeInsets.fromLTRB(12, 7, 0, 0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _colorClass.secondaryBrandColor,
                                  width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _colorClass.secondaryBrandColor,
                                  width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _colorClass.secondaryBrandColor,
                                  width: 1)),
                          labelText: _stringFile.unit,
                        )), /*selectedItem: controller.categoryList.isNotEmpty?controller.categoryList[0].categoryName:""*/
                      );
                    }),
                  ),
                  Card(
                    color: _colorClass.mainBrandColor,
                    child: InkWell(
                      splashColor: _colorClass.bgColor,
                      onTap: () async {
                        showModalBottomSheet(
                            context: context,
                            builder: (c) {
                              return StatefulBuilder(
                                  builder: (context, bottomSheetSetState) {
                                return const AddUnitBottomSheet();
                              });
                            });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextWidget(
                    text: _stringFile.lowStockWarning,
                    textStyle: _commonClass.getTextStyle(
                        15, _colorClass.blackColor, CommonClass.medium),
                  ),
                  FlutterSwitch(
                    activeColor: _colorClass.secondaryBrandColor,
                    height: 20,
                    toggleSize: 10,
                    width: 40,
                    value: _reOrderWarning,
                    onToggle: (val) {
                      setState(() {
                        _reOrderWarning = val;
                      });
                    },
                  ),
                ],
              ),
              _reOrderWarning
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        TextFieldWidget(
                            textEditingController: reorderStockController,
                            maxLength: null,
                            type: TextInputType.text,
                            formatter: null,
                            hasSuffix: "/IN",
                            text: _stringFile.reorderStockQuantity,
                            onTypeCallBack: (e) {}),
                      ],
                    )
                  : Container(),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: _colorClass.secondaryBrandColor,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (c) {
                                return StatefulBuilder(
                                    builder: (context, bottomSheetSetState) {
                                  return const QRCodeBottomSheet();
                                });
                              });
                        },
                        splashColor: _colorClass.bgColor,
                        child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: TextWidget(
                                overflow: TextOverflow.visible,
                                text: _stringFile.generateQRCode,
                                textStyle: _commonClass.getTextStyle(15,
                                    _colorClass.whiteColor, CommonClass.bold))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Material(
                      color: _colorClass.secondaryBrandColor,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (c) {
                                return StatefulBuilder(
                                    builder: (context, bottomSheetSetState) {
                                  return const BarcodeBottomSheet();
                                });
                              });
                        },
                        splashColor: _colorClass.bgColor,
                        child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: TextWidget(
                                overflow: TextOverflow.visible,
                                text: _stringFile.generateBarcode,
                                textStyle: _commonClass.getTextStyle(15,
                                    _colorClass.whiteColor, CommonClass.bold))),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Image.asset(
                        _commonClass.barcodeScanner,
                        width: 30,
                        height: 30,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomSheetForDateSelection extends StatefulWidget {
  const BottomSheetForDateSelection({Key? key}) : super(key: key);

  @override
  State<BottomSheetForDateSelection> createState() =>
      _BottomSheetForDateSelectionState();
}

class _BottomSheetForDateSelectionState
    extends State<BottomSheetForDateSelection> {
  // String _selectedDate = '';
  // String _dateCount = '';
  // String _range = '';
  // String _rangeCount = '';

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // setState(() {
    if (args.value is PickerDateRange) {
      // _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
      //     ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
    } else if (args.value is DateTime) {
      // _selectedDate = args.value.toString();
      itemController.stockAsOnDate.value =
          DateFormat('dd-MM-yyyy').format(args.value);
    } else if (args.value is List<DateTime>) {
      // _dateCount = args.value.length.toString();
    } else {
      // _rangeCount = args.value.length.toString();
    }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SfDateRangePicker(
        onCancel: () {
          Navigator.pop(context);
        },
        onSubmit: (value) {
          Navigator.pop(context);
        },
        backgroundColor:
            _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
        onSelectionChanged: _onSelectionChanged,
        selectionMode: DateRangePickerSelectionMode.single,
        selectionColor: _colorClass.mainBrandColor,
        showTodayButton: false,
        showActionButtons: true,
        initialSelectedRange: null,
      ),
    );
  }
}

class PricingCard extends StatefulWidget {
  const PricingCard({Key? key}) : super(key: key);

  @override
  State<PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<PricingCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpandableTheme(
                data: ExpandableThemeData(
                  iconColor: _colorClass.mainBrandMaterialColor,
                  collapseIcon: FontAwesomeIcons.circleMinus,
                  expandIcon: FontAwesomeIcons.circlePlus,
                  useInkWell: true,
                ),
                child: const MyCard(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatefulWidget {
  const MyCard({Key? key}) : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  final ExpandableController _discountController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: ScrollOnExpand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFieldWidget(
              textEditingController: salesPriceController,
              hasSuffix: "/IN",
              hasPrefix: "₹",
              maxLength: null,
              type: TextInputType.text,
              formatter: null,
              text: _stringFile.salesPrice,
              onTypeCallBack: (e) {}),

          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            activeColor: _colorClass.mainBrandColor,
            value: _salePriceWithTax,
            onChanged: (value) {
              setState(() {
                _salePriceWithTax = value;
              });
            },
            title: TextWidget(
              text: _stringFile.salePriceAreWithTax,
              textStyle: _commonClass.getTextStyle(
                  12, _colorClass.blackColor, CommonClass.light),
            ),
          ),

          TextFieldWidget(
              textEditingController: purchasePriceController,
              hasSuffix: "/IN",
              hasPrefix: "₹",
              maxLength: null,
              type: TextInputType.text,
              formatter: null,
              text: _stringFile.purchasePrice,
              onTypeCallBack: (e) {}),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            activeColor: _colorClass.mainBrandColor,
            value: _purchasePriceWithTax,
            onChanged: (value) {
              setState(() {
                _purchasePriceWithTax = value;
              });
            },
            title: TextWidget(
              text: _stringFile.purchasePriceAreWithTax,
              textStyle: _commonClass.getTextStyle(
                  12, _colorClass.blackColor, CommonClass.light),
            ),
          ),

          TextFieldWidget(
              textEditingController: mrpController,
              hasSuffix: "/IN",
              hasPrefix: "₹",
              maxLength: null,
              type: TextInputType.text,
              formatter: null,
              text: "MRP",
              onTypeCallBack: (e) {}),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
              textEditingController: wholeSalePriceController,
              hasSuffix: "/IN",
              hasPrefix: "₹",
              maxLength: null,
              type: TextInputType.text,
              formatter: null,
              text: "Wholesale Price",
              onTypeCallBack: (e) {}),
          ExpandableNotifier(
              child: ScrollOnExpand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ExpandablePanel(
                  controller: _discountController,
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
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
                              child: TextWidget(
                            text: _stringFile.discountStructure,
                            textStyle: _commonClass.getTextStyle(
                                15, _colorClass.blackColor, CommonClass.medium),
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: Card(
                          color: _colorClass.mainBrandColor,
                          child: InkWell(
                            splashColor: _colorClass.bgColor,
                            onTap: () {
                              setState(() {
                                _discountStructureCounter += 1;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextWidget(
                                  text: _stringFile.addMoreDiscountStructure,
                                  textStyle: _commonClass.getTextStyle(
                                      12,
                                      _colorClass.whiteColor,
                                      CommonClass.medium)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _discountStructureCounter,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 0,
                              color: _colorClass.secondaryBrandColor
                                  .withAlpha(CommonClass.bgAlpha),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        splashColor: _colorClass.bgColor,
                                        onTap: () {
                                          setState(() {
                                            _discountStructureCounter -= 1;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 18.0, horizontal: 10),
                                          child: Icon(
                                            FontAwesomeIcons.trash,
                                            color: _colorClass.redColor,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: DropdownSearch<String>(
                                              popupProps: const PopupProps
                                                  .modalBottomSheet(
                                                showSearchBox: true,
                                              ),
                                              items: const [
                                                "Class 1",
                                                "Class 2",
                                                "Class 3",
                                                'Class 4',
                                                'Class 5'
                                              ],
                                              onChanged: print,
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                      dropdownSearchDecoration:
                                                          InputDecoration(
                                                labelStyle: TextStyle(
                                                    color: _colorClass
                                                        .secondaryBrandColor),
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        12, 7, 0, 0),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: _colorClass
                                                            .secondaryBrandColor,
                                                        width: 1)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: _colorClass
                                                            .secondaryBrandColor,
                                                        width: 1)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: _colorClass
                                                            .secondaryBrandColor,
                                                        width: 1)),
                                                labelText: _stringFile
                                                    .choosePartyClass,
                                              )),
                                              selectedItem: "Class 1"),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: TextFieldWidget(
                                              hasSuffix: "%",
                                              maxLength: null,
                                              type: TextInputType.text,
                                              formatter: null,
                                              text: _stringFile
                                                  .enterDiscountDetails,
                                              onTypeCallBack: (e) {}),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ))
          // const SizedBox(
          //   height: 10,
          // ),
          // TextFieldWidget(
          //     hasSuffix: "/IN",
          //     hasPrefix: "₹",
          //     maxLength: null,
          //     type: TextInputType.text,
          //     formatter: null,
          //     text: _stringFile.wholesalePrice,
          //     onTypeCallBack: (e) {}),
          // const SizedBox(
          //   height: 10,
          // ),
          // TextFieldWidget(
          //     hasSuffix: "IN",
          //     hasPrefix: "₹",
          //     maxLength: null,
          //     type: TextInputType.text,
          //     formatter: null,
          //     text: _stringFile.minWholesaleQTY,
          //     onTypeCallBack: (e) {}),
        ],
      ),
    ));
  }
}

class AddUnitBottomSheet extends StatefulWidget {
  const AddUnitBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddUnitBottomSheet> createState() => _AddUnitBottomSheetState();
}

class _AddUnitBottomSheetState extends State<AddUnitBottomSheet> {
  int _counter = 1;

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
                          text: _stringFile.addUnit,
                          textStyle: _commonClass.getTextStyle(
                              15, _colorClass.blackColor, CommonClass.bold)),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownSearch<String>(
                    popupProps: const PopupProps.modalBottomSheet(
                      showSearchBox: true,
                    ),
                    items: const [
                      "Category 1",
                      "Category 2",
                      "Category 3",
                      'Category 4',
                      'Category 5'
                    ],
                    onChanged: print,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: _colorClass.secondaryBrandColor),
                      contentPadding: const EdgeInsets.fromLTRB(12, 7, 0, 0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: _colorClass.secondaryBrandColor,
                              width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: _colorClass.secondaryBrandColor,
                              width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: _colorClass.secondaryBrandColor,
                              width: 1)),
                      labelText: _stringFile.primaryUnit,
                    )),
                    selectedItem: "Category 1"),
                const SizedBox(
                  height: 20,
                ),
                TextWidget(
                    text: _stringFile.addConversionRate,
                    textStyle: _commonClass.getTextStyle(
                        14, _colorClass.blackColor, CommonClass.semiBold)),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Card(
                    color: _colorClass.mainBrandColor,
                    child: InkWell(
                      splashColor: _colorClass.bgColor,
                      onTap: () {
                        setState(() {
                          _counter += 1;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWidget(
                            text: _stringFile.addMoreUnits,
                            textStyle: _commonClass.getTextStyle(12,
                                _colorClass.whiteColor, CommonClass.medium)),
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _counter,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                              text: "1 INCHES (IN) =",
                              textStyle: _commonClass.getTextStyle(12,
                                  _colorClass.blackColor, CommonClass.light)),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFieldWidget(
                                    maxLength: 10,
                                    type: TextInputType.number,
                                    formatter: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    text: _stringFile.enterDetails,
                                    onTypeCallBack: (e) {}),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: DropdownSearch<String>(
                                    popupProps:
                                        const PopupProps.modalBottomSheet(
                                      showSearchBox: true,
                                    ),
                                    items: const [
                                      "Unit 1",
                                      "Unit 2",
                                      "Unit 3",
                                      'Unit 4',
                                      'Unit 5'
                                    ],
                                    onChanged: print,
                                    dropdownDecoratorProps:
                                        DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                      labelStyle: TextStyle(
                                          color:
                                              _colorClass.secondaryBrandColor),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          12, 7, 0, 0),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: _colorClass
                                                  .secondaryBrandColor,
                                              width: 1)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: _colorClass
                                                  .secondaryBrandColor,
                                              width: 1)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: _colorClass
                                                  .secondaryBrandColor,
                                              width: 1)),
                                      labelText: _stringFile.alternateUnit,
                                    )),
                                    selectedItem: "Unit 1"),
                              ),
                              Card(
                                child: InkWell(
                                  splashColor: _colorClass.bgColor,
                                  onTap: () {
                                    setState(() {
                                      _counter -= 1;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18.0, horizontal: 10),
                                    child: Icon(
                                      FontAwesomeIcons.trash,
                                      color: _colorClass.redColor,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Material(
          color: _colorClass.mainBrandColor,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            splashColor: _colorClass.bgColor,
            child: Container(
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextWidget(
                    text: _stringFile.done,
                    textStyle: _commonClass.getTextStyle(
                        15, _colorClass.whiteColor, CommonClass.bold))),
          ),
        ),
      ),
    );
  }
}

class BarcodeBottomSheet extends StatefulWidget {
  const BarcodeBottomSheet({Key? key}) : super(key: key);

  @override
  State<BarcodeBottomSheet> createState() => _BarcodeBottomSheetState();
}

class _BarcodeBottomSheetState extends State<BarcodeBottomSheet> {
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
                          text: _stringFile.barcode,
                          textStyle: _commonClass.getTextStyle(
                              15, _colorClass.blackColor, CommonClass.bold)),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: TextWidget(
                              text: "Test",
                              textStyle: _commonClass.getTextStyle(15,
                                  _colorClass.blackColor, CommonClass.medium)),
                        ),
                        Image.asset(
                          _commonClass.demoBarcode,
                          height: 150,
                          width: double.infinity,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextWidget(
                            text: "Test Item",
                            textStyle: _commonClass.getTextStyle(11,
                                _colorClass.blackColor, CommonClass.medium)),
                        const SizedBox(
                          height: 10,
                        ),
                        TextWidget(
                            text: _stringFile.printThisBarcode,
                            textStyle: _commonClass.getTextStyle(
                                13, _colorClass.blackColor, CommonClass.light))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Material(
                      color: _colorClass.whiteColor,
                      child: InkWell(
                          onTap: () {},
                          splashColor: _colorClass.bgColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              FontAwesomeIcons.trash,
                              color: _colorClass.redColor,
                            ),
                          ))),
                ),
                Expanded(
                  child: Material(
                      color: _colorClass.whiteColor,
                      child: InkWell(
                          onTap: () {},
                          splashColor: _colorClass.bgColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              FontAwesomeIcons.shareNodes,
                              color: _colorClass.secondaryBrandColor,
                            ),
                          ))),
                ),
                Expanded(
                  child: Material(
                      color: _colorClass.whiteColor,
                      child: InkWell(
                          onTap: () {},
                          splashColor: _colorClass.bgColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              FontAwesomeIcons.print,
                              color: _colorClass.secondaryBrandColor,
                            ),
                          ))),
                ),
                Expanded(
                  child: Material(
                      color: _colorClass.whiteColor,
                      child: InkWell(
                          onTap: () {},
                          splashColor: _colorClass.bgColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              FontAwesomeIcons.download,
                              color: _colorClass.secondaryBrandColor,
                            ),
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QRCodeBottomSheet extends StatefulWidget {
  const QRCodeBottomSheet({Key? key}) : super(key: key);

  @override
  State<QRCodeBottomSheet> createState() => _QRCodeBottomSheetState();
}

class _QRCodeBottomSheetState extends State<QRCodeBottomSheet> {
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
                          text: _stringFile.qrCode,
                          textStyle: _commonClass.getTextStyle(
                              15, _colorClass.blackColor, CommonClass.bold)),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: TextWidget(
                              text: "Test",
                              textStyle: _commonClass.getTextStyle(15,
                                  _colorClass.blackColor, CommonClass.medium)),
                        ),
                        Image.asset(
                          _commonClass.demoQRCode,
                          height: 150,
                          width: double.infinity,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextWidget(
                            text: "Test Item",
                            textStyle: _commonClass.getTextStyle(11,
                                _colorClass.blackColor, CommonClass.medium)),
                        const SizedBox(
                          height: 10,
                        ),
                        TextWidget(
                            text: _stringFile.printThisBarcode,
                            textStyle: _commonClass.getTextStyle(
                                13, _colorClass.blackColor, CommonClass.light))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Material(
                      color: _colorClass.whiteColor,
                      child: InkWell(
                          onTap: () {},
                          splashColor: _colorClass.bgColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              FontAwesomeIcons.trash,
                              color: _colorClass.redColor,
                            ),
                          ))),
                ),
                Expanded(
                  child: Material(
                      color: _colorClass.whiteColor,
                      child: InkWell(
                          onTap: () {},
                          splashColor: _colorClass.bgColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              FontAwesomeIcons.shareNodes,
                              color: _colorClass.secondaryBrandColor,
                            ),
                          ))),
                ),
                Expanded(
                  child: Material(
                      color: _colorClass.whiteColor,
                      child: InkWell(
                          onTap: () {},
                          splashColor: _colorClass.bgColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              FontAwesomeIcons.print,
                              color: _colorClass.secondaryBrandColor,
                            ),
                          ))),
                ),
                Expanded(
                  child: Material(
                      color: _colorClass.whiteColor,
                      child: InkWell(
                          onTap: () {},
                          splashColor: _colorClass.bgColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              FontAwesomeIcons.download,
                              color: _colorClass.secondaryBrandColor,
                            ),
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddBottomSheet extends StatefulWidget {
  final String title;
  final String id;

  const AddBottomSheet({Key? key, required this.title, this.id = "0"})
      : super(key: key);

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  var value;

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
                        text: "Add ${widget.title}",
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.blackColor, CommonClass.bold)),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextFieldWidget(
            maxLength: null,
            type: TextInputType.text,
            formatter: null,
            text: widget.title,
            onTypeCallBack: (e) {
              setState(() {
                value = e;
              });
            }),
      ),
      bottomNavigationBar: Material(
        color: _colorClass.mainBrandColor,
        child: InkWell(
          onTap: () {
            addItemProperties(widget.title, value, id: widget.id);
            Navigator.pop(context);
          },
          splashColor: _colorClass.bgColor,
          child: Container(
              height: 50,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextWidget(
                  text: _stringFile.add,
                  textStyle: _commonClass.getTextStyle(
                      15, _colorClass.whiteColor, CommonClass.bold))),
        ),
      ),
    ));
  }

  void addItemProperties(String title, value, {id = "0"}) {
    switch (title) {
      case "Category":
        {
          ItemController().addCategory(value).then((value) {
            itemController.getCategory();
            var res = json.decode(value);
            if (res['status'] != 200) {
              print("something went wrong");
            }
          });
        }
        break;
      case "Sub Category":
        {
          ItemController().addSubCategory(id, value).then((value) {
            itemController.getSubCategory(id);
            var res = json.decode(value);
            if (res['status'] != 200) {
              print("something went wrong");
            }
          });
        }
        break;
      case "Series":
        {
          ItemController().addSeries(value).then((value) {
            itemController.getSeries();
            var res = json.decode(value);
            if (res['status'] != 200) {
              print("something went wrong");
            }
          });
        }
        break;
      case "Sub Series":
        {
          ItemController().addSubSeries(id, value).then((value) {
            itemController.getSubSeries(id);
            var res = json.decode(value);
            if (res['status'] != 200) {
              print("something went wrong");
            }
          });
        }
        break;
      case "Brand":
        {
          ItemController().addBrand(value).then((value) {
            itemController.getBrand();
            var res = json.decode(value);
            if (res['status'] != 200) {
              print("something went wrong");
            }
          });
        }
        break;
      case "Size":
        {
          ItemController().addSize(value).then((value) {
            itemController.getSize();
            var res = json.decode(value);
            if (res['status'] != 200) {
              print("something went wrong");
            }
          });
        }
        break;
    }
  }
}
