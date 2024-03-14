import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/view/screens/quotationFolder/widgets/quotation_additional_charges_widget.dart';
import 'package:accountech/view/screens/quotationFolder/widgets/quotation_discount_widget.dart';
import 'package:accountech/view/screens/quotationFolder/widgets/quotation_items_widget.dart';
import 'package:accountech/view/screens/quotationFolder/widgets/quotation_notes_widget.dart';
import 'package:accountech/view/screens/quotationFolder/widgets/quotation_party_add.dart';
import 'package:accountech/view/screens/quotationFolder/widgets/quotation_round_off_widget.dart';
import 'package:flutter/material.dart';

class QuotationBodyWidget extends StatefulWidget {
  const QuotationBodyWidget({Key? key}) : super(key: key);

  @override
  State<QuotationBodyWidget> createState() => _QuotationBodyWidgetState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();

class _QuotationBodyWidgetState extends State<QuotationBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _commonClass.getScreenHeight(context),
      width: _commonClass.getScreenWidth(context),
      color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            QuotationPartyAdd(),
            QuotationItemsWidget(),
            QuotationAdditionalChargesWidget(),
            QuotationDiscountWidget(),
            QuotationRoundOffWidget(),
            QuotationNotesWidget(),
          ],
        ),
      ),
    );
  }
}
