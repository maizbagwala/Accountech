import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/model/warehouse/warehouse_response.dart';
import 'package:accountech/view/screens/itemsFolder/create_item_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../controller/partyController/party_controller.dart';
import '../../../../controller/warehouseController/warehouse_controller.dart';
import '../../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../../widgets/textWidgets/text_widget.dart';
import 'package:accountech/model/commonModels/pincode_response.dart' as pc;

class EditWarehouseBottomSheet extends StatefulWidget {
  final Data item;

  const EditWarehouseBottomSheet(this.item, {Key? key}) : super(key: key);

  @override
  State<EditWarehouseBottomSheet> createState() =>
      _EditWarehouseBottomSheetState();
}

class _EditWarehouseBottomSheetState extends State<EditWarehouseBottomSheet>
    with TickerProviderStateMixin {
  final StringFile _stringFile = StringFile();
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();
  var controller = Get.find<WarehouseController>();
  var partyController = Get.find<PartyController>();
  var warehouseNameController = TextEditingController();
  var warehouseCodeController = TextEditingController();
  var warehouseInchargeNameController = TextEditingController();
  var warehouseContactController = TextEditingController();
  var warehouseAddressController = TextEditingController();

  var first = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      warehouseNameController.text = widget.item.warehouseName!;
      warehouseCodeController.text = widget.item.warehouseNo!;
      warehouseInchargeNameController.text = widget.item.inchargeName!;
      warehouseContactController.text = widget.item.contactNo!.toString();
      warehouseAddressController.text = widget.item.address!;
      // controller.pincode.value=widget.item.
      first = false;
    }
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
                            textEditingController: warehouseCodeController,
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
                            textEditingController: warehouseNameController,
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
                            textEditingController:
                                warehouseInchargeNameController,
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
                            textEditingController: warehouseContactController,
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
                                        text:
                                            controller.cityState.value.state ??
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
                            textEditingController: warehouseAddressController,
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
              editWarehouse();
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

  Future<pc.Data> getCityStateFromPincode(String mainPincode) async {
    var value = await PartyController().getCityStateFromPincode(mainPincode);

    var data = value as List<pc.Data>;
    if (data.isNotEmpty) {
      return data[0];
    }

    return pc.Data();
  }

  Future<void> editWarehouse() async {
    if (warehouseNameController.text.isNotEmpty &&
        warehouseCodeController.text.isNotEmpty &&
        warehouseInchargeNameController.text.isNotEmpty &&
        warehouseContactController.text.isNotEmpty &&
        warehouseAddressController.text.isNotEmpty &&
        controller.pincode.value.length == 6) {
      var res = await controller.editWarehouse(
          widget.item.id.toString(),
          warehouseCodeController.text,
          warehouseNameController.text,
          warehouseInchargeNameController.text,
          warehouseContactController.text,
          controller.pincode.value,
          controller.cityState.value.id.toString(),
          controller.cityState.value.id.toString(),
          warehouseAddressController.text);
      if (res.status == 200) {
        controller.resetVariable();
        Navigator.pop(context);
      }
    }
  }
}
