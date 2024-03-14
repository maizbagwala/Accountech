import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/view/screens/salesReturnFolder/widgets/sales_return_additional_charges_widget.dart';
import 'package:accountech/view/screens/salesReturnFolder/widgets/sales_return_discount_widget.dart';
import 'package:accountech/view/screens/salesReturnFolder/widgets/sales_return_items_widget.dart';
import 'package:accountech/view/screens/salesReturnFolder/widgets/sales_return_notes_widget.dart';
import 'package:accountech/view/screens/salesReturnFolder/widgets/sales_return_party_add.dart';
import 'package:accountech/view/screens/salesReturnFolder/widgets/sales_return_round_off_widget.dart';
import 'package:flutter/material.dart';

class SalesReturnBodyWidget extends StatefulWidget {
  const SalesReturnBodyWidget({Key? key}) : super(key: key);

  @override
  State<SalesReturnBodyWidget> createState() => _SalesReturnBodyWidgetState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();

class _SalesReturnBodyWidgetState extends State<SalesReturnBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _commonClass.getScreenHeight(context),
      width: _commonClass.getScreenWidth(context),
      color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            SalesReturnPartyAdd(),
            SalesReturnItemsWidget(),
            SalesReturnAdditionalChargesWidget(),
            SalesReturnDiscountWidget(),
            SalesReturnRoundOffWidget(),
            SalesReturnNotesWidget(),
          ],
        ),
      ),
    );
  }
}
