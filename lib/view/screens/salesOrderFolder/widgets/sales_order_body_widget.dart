import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/view/screens/salesOrderFolder/widgets/sales_order_additional_charges_widget.dart';
import 'package:accountech/view/screens/salesOrderFolder/widgets/sales_order_discount_widget.dart';
import 'package:accountech/view/screens/salesOrderFolder/widgets/sales_order_items_widget.dart';
import 'package:accountech/view/screens/salesOrderFolder/widgets/sales_order_notes_widget.dart';
import 'package:accountech/view/screens/salesOrderFolder/widgets/sales_order_party_add.dart';
import 'package:accountech/view/screens/salesOrderFolder/widgets/sales_order_round_off_widget.dart';
import 'package:accountech/view/screens/salesOrderFolder/widgets/sales_order_terms_widget.dart';
import 'package:flutter/material.dart';

class SalesOrderBodyWidget extends StatelessWidget {
  const SalesOrderBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _commonClass.getScreenHeight(context),
      width: _commonClass.getScreenWidth(context),
      color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
      child: SingleChildScrollView(
        child: Column(
          children:  const [
            SalesOrderPartyAdd(),
            SalesOrderItemsWidget(),
            SalesOrderAdditionalChargesWidget(),
            SalesOrderDiscountWidget(),
            SalesOrderRoundOffWidget(),
            SalesOrderNotesWidget(),
            SalesOrderTermsWidget(),
          ],
        ),
      ),
    );
  }
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();
