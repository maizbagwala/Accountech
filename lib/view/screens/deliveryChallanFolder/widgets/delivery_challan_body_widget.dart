import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/view/screens/deliveryChallanFolder/widgets/delivery_challan_party_add.dart';
import 'package:flutter/material.dart';

import 'delivery_cahallan_discount_widget.dart';
import 'delivery_challan_additional_charges_widget.dart';
import 'delivery_challan_items_widget.dart';
import 'delivery_challan_round_off_widget.dart';

class DeliveryChallanBodyWidget extends StatefulWidget {
  const DeliveryChallanBodyWidget({Key? key}) : super(key: key);

  @override
  State<DeliveryChallanBodyWidget> createState() => _DeliveryChallanBodyWidgetState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();

class _DeliveryChallanBodyWidgetState extends State<DeliveryChallanBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _commonClass.getScreenHeight(context),
      width: _commonClass.getScreenWidth(context),
      color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            DeliveryChallanPartyAdd(),
            DeliveryChallanItemsWidget(),
            DeliveryChallanAdditionalChargesWidget(),
            DeliveryChallanDiscountWidget(),
            DeliveryChallanRoundOffWidget(),
          ],
        ),
      ),
    );
  }
}
