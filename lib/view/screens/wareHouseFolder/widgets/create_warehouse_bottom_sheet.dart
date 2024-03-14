import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../controller/partyController/party_controller.dart';
import '../../../../controller/warehouseController/warehouse_controller.dart';
import '../../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../../widgets/textWidgets/text_widget.dart';
import 'package:accountech/model/commonModels/pincode_response.dart';

class CreateWarehouseBottomSheet extends StatefulWidget {
  const CreateWarehouseBottomSheet({Key? key}) : super(key: key);

  @override
  State<CreateWarehouseBottomSheet> createState() =>
      _CreateWarehouseBottomSheetState();
}

class _CreateWarehouseBottomSheetState extends State<CreateWarehouseBottomSheet>
    with TickerProviderStateMixin {
  final StringFile _stringFile = StringFile();
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();
  var controller = Get.find<WarehouseController>();
  var partyController = Get.find<PartyController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(CommonClass.headerHeight + 62),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                          text: "Create Warehouse",
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: _commonClass.getScreenWidth(context),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldWidget(
                            maxLength: null,
                            type: TextInputType.text,
                            formatter: null,
                            text: "Warehouse Code",
                            onTypeCallBack: (e) {
                              controller.warehouseCode.value = e;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                            maxLength: null,
                            type: TextInputType.text,
                            formatter: null,
                            text: "Warehouse Name",
                            onTypeCallBack: (e) {
                              controller.warehouseName.value = e;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                            maxLength: null,
                            type: TextInputType.text,
                            formatter: null,
                            text: "Incharge Name",
                            onTypeCallBack: (e) {
                              controller.inchargeName.value = e;
                            }),
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
                            text: "Contact No.",
                            onTypeCallBack: (e) {
                              controller.contactNo.value = e;
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        TextWidget(
                            text: "LOCATION DETAILS",
                            textStyle: _commonClass.getTextStyle(
                                15,
                                _colorClass.secondaryBrandColor,
                                CommonClass.medium)),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: _colorClass.bgColor,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                            maxLength: 6,
                            type: TextInputType.number,
                            formatter: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                            text: "Pincode",
                            onTypeCallBack: (e) {
                              controller.pincode.value = e;
                              if (controller.pincode.value.length == 6) {
                                getCityStateFromPincode(
                                        controller.pincode.value)
                                    .then((value) {
                                  controller.cityState.value = value;
                                });
                              }
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: _colorClass.greyColor)),
                                child: ListTile(
                                  title: GetX<WarehouseController>(
                                      builder: (controller) {
                                    return TextWidget(
                                        text: controller.cityState.value.state ??
                                            "State",
                                        textStyle: _commonClass.getTextStyle(
                                            12,
                                            _colorClass.greyColor,
                                            CommonClass.medium));
                                  }),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: _colorClass.greyColor)),
                                child: ListTile(
                                  title: GetX<WarehouseController>(
                                      builder: (controller) {
                                    return TextWidget(
                                        text: controller.cityState.value.city ??
                                            "City",
                                        textStyle: _commonClass.getTextStyle(
                                            12,
                                            _colorClass.greyColor,
                                            CommonClass.medium));
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                            maxLength: 255,
                            type: TextInputType.text,
                            formatter: null,
                            text: "Address & City",
                            onTypeCallBack: (e) {
                              controller.address.value = e;
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Material(
          color: _colorClass.mainBrandColor,
          child: InkWell(
            onTap: () {
              createWarehouse();
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

  Future<Data> getCityStateFromPincode(String mainPincode) async {
    var value = await PartyController().getCityStateFromPincode(mainPincode);

    var data = value as List<Data>;
    if (data.isNotEmpty) {
      return data[0];
    }

    return Data();
  }

  Future<void> createWarehouse() async {
    if (controller.warehouseCode.value.isNotEmpty &&
        controller.warehouseName.value.isNotEmpty &&
        controller.inchargeName.value.isNotEmpty &&
        controller.contactNo.value.isNotEmpty &&
        controller.pincode.value.isNotEmpty &&
        controller.state.value.isNotEmpty &&
        controller.city.value.isNotEmpty &&
        controller.address.value.isNotEmpty) {
      var res = await controller.createWarehouse(
          controller.warehouseCode.value,
          controller.warehouseName.value,
          controller.inchargeName.value,
          controller.contactNo.value,
          controller.pincode.value,
          controller.cityState.value.id.toString(),
          controller.cityState.value.id.toString(),
          controller.address.value);
      if (res.status == 200) {
        controller.resetVariable();
        Navigator.pop(context);
      }
    }
  }
}
