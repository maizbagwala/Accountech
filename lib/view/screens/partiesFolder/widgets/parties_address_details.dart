import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/controller/partyController/party_controller.dart';
import 'package:accountech/model/commonModels/pincode_response.dart';
import 'package:accountech/widgets/textWidgets/text_widget.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../common/common_class.dart';
import '../../../../widgets/textFieldWidgets/text_field_widget.dart';

class PartiesAddressDetails extends StatefulWidget {
  final TextEditingController billingPincodeController;
  final TextEditingController shippingPincodeController;
  final Function getCheckedValue;

  const PartiesAddressDetails(
      {Key? key,
      required this.billingPincodeController,
      required this.shippingPincodeController,
      required this.getCheckedValue})
      : super(key: key);

  @override
  State<PartiesAddressDetails> createState() => _PartiesAddressDetailsState();
}

ColorClass _colorClass = ColorClass();
StringFile _stringFile = StringFile();
CommonClass _commonClass = CommonClass();
PartyController partyController = Get.find<PartyController>();

class _PartiesAddressDetailsState extends State<PartiesAddressDetails> {
  @override
  Widget build(BuildContext context) {
    return ExpandableTheme(
      data: ExpandableThemeData(
        iconColor: _colorClass.mainBrandMaterialColor,
        collapseIcon: FontAwesomeIcons.circleMinus,
        expandIcon: FontAwesomeIcons.circlePlus,
        useInkWell: true,
      ),
      child: MyCard(
        billingPincodeController: widget.billingPincodeController,
        shippingPincodeController: widget.shippingPincodeController,
        getCheckedValue: widget.getCheckedValue,
      ),
    );
  }
}

class MyCard extends StatefulWidget {
  final Function getCheckedValue;
  final TextEditingController billingPincodeController;
  final TextEditingController shippingPincodeController;

  const MyCard(
      {Key? key,
      required this.billingPincodeController,
      required this.shippingPincodeController,
      required this.getCheckedValue})
      : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  ExpandableController controller = ExpandableController();
  bool? _sameAsAddressChecked = false;
  String mainPincode = "";
  String shippingPincode = "";

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: ScrollOnExpand(
      child: Card(
        child: Column(
          children: <Widget>[
            ExpandablePanel(
              controller: controller,
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                hasIcon: true,
              ),
              header: Container(
                color: _colorClass.transparent,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextWidget(
                        text: _stringFile.addressDetails,
                        textStyle: _commonClass.getTextStyle(
                            13, _colorClass.mainBrandColor, CommonClass.medium),
                      )),
                    ],
                  ),
                ),
              ),
              collapsed: Container(),
              expanded: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: _stringFile.billingAddress,
                      textStyle: _commonClass.getTextStyle(
                          14, _colorClass.blackColor, CommonClass.medium),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        textEditingController: widget.billingPincodeController,
                        maxLength: 6,
                        type: TextInputType.number,
                        formatter: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(6),
                        ],
                        text: _stringFile.pincode,
                        onTypeCallBack: (e) {
                          setState(() {
                            mainPincode = e;
                          });
                          if (mainPincode.length == 6) {
                            getCityStateFromPincode(mainPincode).then((value) {
                              partyController.pinCode1.value=value;
                            });
                          }
                        }),
                    mainPincode.length == 6
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: _colorClass.greyColor)),
                                      child: ListTile(
                                        title: GetX<PartyController>(
                                          builder: (controller) {
                                            return TextWidget(
                                                text: controller.pinCode1.value.state??"State",
                                                textStyle:
                                                    _commonClass.getTextStyle(
                                                        12,
                                                        _colorClass.greyColor,
                                                        CommonClass.medium));
                                          }
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: _colorClass.greyColor)),
                                      child: ListTile(
                                        title: GetX<PartyController>(
                                          builder: (controller) {
                                            return TextWidget(
                                                text: controller.pinCode1.value.city??"City",
                                                textStyle:
                                                    _commonClass.getTextStyle(
                                                        12,
                                                        _colorClass.greyColor,
                                                        CommonClass.medium));
                                          }
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFieldWidget(
                                  maxLength: null,
                                  type: TextInputType.text,
                                  formatter: null,
                                  text: _stringFile.addressAndCity,
                                  onTypeCallBack: (e) {}),
                            ],
                          )
                        : Container(),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      activeColor: _colorClass.mainBrandColor,
                      value: _sameAsAddressChecked,
                      onChanged: (value) {
                        setState(() {
                          _sameAsAddressChecked = value;
                          widget.getCheckedValue(value);
                        });
                      },
                      title: TextWidget(
                        text: _stringFile.shippingSameAsBilling,
                        textStyle: _commonClass.getTextStyle(
                            12, _colorClass.blackColor, CommonClass.light),
                      ),
                    ),
                    _sameAsAddressChecked ?? false
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: _stringFile.shippingAddress,
                                textStyle: _commonClass.getTextStyle(14,
                                    _colorClass.blackColor, CommonClass.medium),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFieldWidget(
                                  textEditingController:
                                      widget.shippingPincodeController,
                                  maxLength: 6,
                                  type: TextInputType.number,
                                  formatter: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  text: _stringFile.pincode,
                                  onTypeCallBack: (e) {
                                    setState(() {
                                      shippingPincode = e;
                                    });
                                    if (shippingPincode.length == 6) {
                                      getCityStateFromPincode(shippingPincode).then((value) {
                                        partyController.pinCode2.value=value;
                                      });
                                    }
                                  }),
                              shippingPincode.length == 6
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                    border: Border.all(
                                                        color: _colorClass.greyColor)),
                                                child: ListTile(
                                                  title: GetX<PartyController>(
                                                      builder: (controller) {
                                                        return TextWidget(
                                                            text: controller.pinCode2.value.state??"State",
                                                            textStyle:
                                                            _commonClass.getTextStyle(
                                                                12,
                                                                _colorClass.greyColor,
                                                                CommonClass.medium));
                                                      }
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                    border: Border.all(
                                                        color: _colorClass.greyColor)),
                                                child: ListTile(
                                                  title: GetX<PartyController>(
                                                      builder: (controller) {
                                                        return TextWidget(
                                                            text: controller.pinCode2.value.city??"City",
                                                            textStyle:
                                                            _commonClass.getTextStyle(
                                                                12,
                                                                _colorClass.greyColor,
                                                                CommonClass.medium));
                                                      }
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFieldWidget(
                                            maxLength: null,
                                            type: TextInputType.text,
                                            formatter: null,
                                            text: _stringFile.addressAndCity,
                                            onTypeCallBack: (e) {}),
                                      ],
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<Data> getCityStateFromPincode(String mainPincode) async {
    var value = await PartyController().getCityStateFromPincode(mainPincode);

    var data = value as List<Data>;
    if (data.isNotEmpty) {
      return data[0];
    }

    return Data();
  }
}
