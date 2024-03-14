import 'package:accountech/common/common_class.dart';
import 'package:accountech/view/screens/goodInTransitFolder/widgets/good_in_transit_body_widget.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../common/color_class.dart';
import '../../../common/date_picker.dart';
import '../../../common/string_file.dart';
import '../../../controller/goodsInTransitController/goods_in_transit_controller.dart';
import '../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class AddGoodsInTransitScreen extends StatefulWidget {
  static String addGoodsInTransitScreenRoute = "/addGoodsInTransitScreen";

  const AddGoodsInTransitScreen({Key? key}) : super(key: key);

  @override
  State<AddGoodsInTransitScreen> createState() =>
      _AddGoodsInTransitScreenState();
}

final ColorClass _colorClass = ColorClass();
final StringFile _stringFile = StringFile();
final CommonClass _commonClass = CommonClass();

final controller = Get.find<GoodsInTransitController>();

class _AddGoodsInTransitScreenState extends State<AddGoodsInTransitScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(CommonClass.headerHeight + 120),
            child: Container(
              color: _colorClass.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonAppBarWidget(
                    title: TextWidget(
                      text: "Create New Goods In Transit",
                      textStyle: _commonClass.getTextStyle(
                          20, _colorClass.blackColor, CommonClass.semiBold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Material(
                          color: _colorClass.whiteColor,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (c) {
                                    return StatefulBuilder(builder:
                                        (context, bottomSheetSetState) {
                                      return const EditDateBottomSheet();
                                    });
                                  });
                            },
                            splashColor: _colorClass.bgColor,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GetX<GoodsInTransitController>(
                                      builder: (controller) {
                                    return TextWidget(
                                        text:
                                            "Goods In Transit #${controller.goodsInTransitNo}",
                                        textStyle: _commonClass.getTextStyle(
                                            15,
                                            _colorClass.secondaryBrandColor,
                                            CommonClass.semiBold));
                                  }),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.pencil,
                                    size: 15,
                                    color: _colorClass.secondaryBrandColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (c) {
                                                return StatefulBuilder(builder:
                                                    (context,
                                                        bottomSheetSetState) {
                                                  return BottomSheetForDateSelection(
                                                    onSubmit: () {},
                                                  );
                                                });
                                              });
                                        },
                                        child: Icon(
                                          FontAwesomeIcons.calendar,
                                          color:
                                              _colorClass.secondaryBrandColor,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                            text: _stringFile.date,
                                            textStyle:
                                                _commonClass.getTextStyle(
                                                    13,
                                                    _colorClass.blackColor,
                                                    CommonClass.regular)),
                                        GetX<GoodsInTransitController>(
                                            builder: (controller) {
                                          return TextWidget(
                                              text: "${controller.date}",
                                              textStyle:
                                                  _commonClass.getTextStyle(
                                                      10,
                                                      _colorClass.blackColor,
                                                      CommonClass.light));
                                        })
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
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
          child: GoodsInTransitBodyWidget(
            getSalesManager: (v) => controller.salesId.value = v.toString(),
            getArchitect: (v) => controller.architectId.value = v.toString(),
            getParty: (v) => controller.partyId.value = v.toString(),
            getNote: (v) => controller.note.value = v.toString(),
            getDiscountPrice: (v) =>
                controller.discountPrice.value = v.toString(),
            getDiscountPercent: (v) =>
                controller.discountPercent.value = v.toString(),
            getRoundOffPercent: (v) =>
                controller.roundOffPercent.value = v.toString(),
            getRoundOffAmount: (v) =>
                controller.roundOffAmount.value = v.toString(),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: _colorClass.greyColor.withAlpha(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                        overflow: TextOverflow.visible,
                        text: _stringFile.totalAmount,
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.blackColor, CommonClass.semiBold),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextWidget(
                          overflow: TextOverflow.visible,
                          text: "₹ ${controller.totalAmount.value}",
                          textStyle: _commonClass.getTextStyle(
                              15, _colorClass.blackColor, CommonClass.semiBold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Material(
              color: _colorClass.secondaryBrandColor,
              child: InkWell(
                onTap: () {
                  GoodsInTransitController()
                      .addGoodsInTransit(
                          controller.goodsInTransitNo.value,
                          controller.date.value,
                          "terms",
                          controller.validityDate.value,
                          "1",
                          "1",
                          controller.salesId.value,
                          controller.architectId.value,
                          controller.partyId.value,
                          controller.note.value,
                          "terms condition",
                          "abc",
                          controller.discountPercent.value,
                          controller.discountPrice.value,
                          controller.roundOffPercent.value,
                          controller.roundOffAmount.value,
                          controller.totalAmount.value,
                          "yes",
                          "cash",
                          "0",
                          "0",
                          controller.chargeName.value,
                          controller.chargeAmount.value,
                          "account_no",
                          "holder_name",
                          "ifsc_code",
                          "bank_name",
                          "")
                      .then((value) => {print(value)});
                  Navigator.pop(context);
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
          ],
        ),
      ),
    );
  }
}

class EditDateBottomSheet extends StatefulWidget {
  const EditDateBottomSheet({Key? key}) : super(key: key);

  @override
  State<EditDateBottomSheet> createState() => _EditDateBottomSheetState();
}

class _EditDateBottomSheetState extends State<EditDateBottomSheet> {
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
                        text: "Edit Goods In Transit Date & Number",
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.blackColor, CommonClass.medium),
                      ),
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
        body: ExpandableTheme(
          data: ExpandableThemeData(
            iconColor: _colorClass.mainBrandMaterialColor,
            collapseIcon: FontAwesomeIcons.circleMinus,
            expandIcon: FontAwesomeIcons.circlePlus,
            useInkWell: true,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: _colorClass.secondaryBrandColor)),
                    child: InkWell(
                      splashColor: _colorClass.bgColor,
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (c) {
                              return StatefulBuilder(
                                  builder: (context, bottomSheetSetState) {
                                return BottomSheetForDateSelection(
                                  onSubmit: (value) {
                                    controller.date.value = value;
                                  },
                                );
                              });
                            });
                      },
                      child: ListTile(
                        title: GetX<GoodsInTransitController>(
                            builder: (controller) {
                          return TextWidget(
                              text:
                                  "Goods In Transit Date (${controller.date})",
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
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: _colorClass.secondaryBrandColor)),
                    child: InkWell(
                      splashColor: _colorClass.bgColor,
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (c) {
                              return StatefulBuilder(
                                  builder: (context, bottomSheetSetState) {
                                return BottomSheetForDateSelection(
                                  onSubmit: (value) {
                                    controller.validityDate.value = value;
                                  },
                                );
                              });
                            });
                      },
                      child: ListTile(
                        title: GetX<GoodsInTransitController>(
                            builder: (controller) {
                          return TextWidget(
                              text:
                                  "Validity Date (${controller.validityDate})",
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
                    height: 20,
                  ),
                  TextFieldWidget(
                      maxLength: 10,
                      type: TextInputType.number,
                      formatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      text: "Goods In Transit No",
                      onTypeCallBack: (e) {
                        controller.goodsInTransitNo.value = e;
                      }),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Material(
          color: _colorClass.secondaryBrandColor,
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
                    text: _stringFile.save,
                    textStyle: _commonClass.getTextStyle(
                        15, _colorClass.whiteColor, CommonClass.bold))),
          ),
        ),
      ),
    );
  }
}
