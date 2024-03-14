import 'package:accountech/common/string_file.dart';
import 'package:accountech/model/partyModels/party_details_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../common/color_class.dart';
import '../../../../common/common_class.dart';
import '../../../../widgets/textWidgets/text_widget.dart';

class PartyPersonalDetailsWidget extends StatefulWidget {
  final PartyDetailsModel value;
  const PartyPersonalDetailsWidget(this.value, {Key? key}) : super(key: key);

  @override
  State<PartyPersonalDetailsWidget> createState() =>
      _PartyPersonalDetailsWidgetState();
}

class _PartyPersonalDetailsWidgetState
    extends State<PartyPersonalDetailsWidget> {
  final ColorClass _colorClass = ColorClass();

  final CommonClass _commonClass = CommonClass();
  final StringFile _stringFile = StringFile();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: _commonClass.getScreenWidth(context),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                      text: _stringFile.partyContactNumber,
                      textStyle: _commonClass.getTextStyle(
                          13, _colorClass.blackColor, CommonClass.semiBold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.phone,
                        color: _colorClass.mainBrandColor,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextWidget(
                          text: "${widget.value.data?.phoneNo}",
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.blackColor, CommonClass.medium)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
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
                  TextWidget(
                      text: _stringFile.whatsappNumber,
                      textStyle: _commonClass.getTextStyle(
                          13, _colorClass.blackColor, CommonClass.semiBold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.phone,
                        color: _colorClass.mainBrandColor,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextWidget(
                          text: "1234567890",
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.blackColor, CommonClass.medium)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
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
                  TextWidget(
                      text: _stringFile.addressDetails,
                      textStyle: _commonClass.getTextStyle(
                          13, _colorClass.blackColor, CommonClass.semiBold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: _stringFile.billingAddress,
                                textStyle: _commonClass.getTextStyle(
                                    11,
                                    _colorClass.blackColor,
                                    CommonClass.medium)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                text: "${widget.value.data?.billingAddress}",
                                textStyle: _commonClass.getTextStyle(10,
                                    _colorClass.blackColor, CommonClass.light)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: _stringFile.shippingAddress,
                                textStyle: _commonClass.getTextStyle(
                                    11,
                                    _colorClass.blackColor,
                                    CommonClass.medium)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                text: "${widget.value.data?.shippingAddress}",
                                textStyle: _commonClass.getTextStyle(10,
                                    _colorClass.blackColor, CommonClass.light)),
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
        const SizedBox(
          height: 5,
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
                  TextWidget(
                      text: _stringFile.gstAndPan,
                      textStyle: _commonClass.getTextStyle(
                          13, _colorClass.blackColor, CommonClass.semiBold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: _stringFile.gstRegistrationType,
                                textStyle: _commonClass.getTextStyle(
                                    11,
                                    _colorClass.blackColor,
                                    CommonClass.medium)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                text: "Unregistered",
                                textStyle: _commonClass.getTextStyle(10,
                                    _colorClass.blackColor, CommonClass.light)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                text: _stringFile.panNumber,
                                textStyle: _commonClass.getTextStyle(
                                    11,
                                    _colorClass.blackColor,
                                    CommonClass.medium)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                text: "--",
                                textStyle: _commonClass.getTextStyle(10,
                                    _colorClass.blackColor, CommonClass.light)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                text: _stringFile.udyamAdharNumber,
                                textStyle: _commonClass.getTextStyle(
                                    11,
                                    _colorClass.blackColor,
                                    CommonClass.medium)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                text: "--",
                                textStyle: _commonClass.getTextStyle(10,
                                    _colorClass.blackColor, CommonClass.light)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: _stringFile.gstin,
                                textStyle: _commonClass.getTextStyle(
                                    11,
                                    _colorClass.blackColor,
                                    CommonClass.medium)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                text: "--",
                                textStyle: _commonClass.getTextStyle(10,
                                    _colorClass.blackColor, CommonClass.light)),
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
        const SizedBox(
          height: 5,
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
                  TextWidget(
                      text: _stringFile.balanceDetails,
                      textStyle: _commonClass.getTextStyle(
                          13, _colorClass.blackColor, CommonClass.semiBold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: _stringFile.creditPeriod,
                                textStyle: _commonClass.getTextStyle(
                                    11,
                                    _colorClass.blackColor,
                                    CommonClass.medium)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                text: "${widget.value.data?.creditPeriod}",
                                textStyle: _commonClass.getTextStyle(10,
                                    _colorClass.blackColor, CommonClass.light)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: _stringFile.creditLimit,
                                textStyle: _commonClass.getTextStyle(
                                    11,
                                    _colorClass.blackColor,
                                    CommonClass.medium)),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                text: "${widget.value.data?.creditLimit}",
                                textStyle: _commonClass.getTextStyle(10,
                                    _colorClass.blackColor, CommonClass.light)),
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
      ],
    );
  }
}
