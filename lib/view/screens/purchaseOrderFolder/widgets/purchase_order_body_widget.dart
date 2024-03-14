import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/view/screens/purchaseOrderFolder/widgets/purchase_order_additional_charges_widget.dart';
import 'package:flutter/material.dart';

import '../../creditNoteFolder/widgets/credit_note_document_widget.dart';
import '../../purchaseFolder/widgets/purchase_discount_widget.dart';
import '../../purchaseFolder/widgets/purchase_items_widget.dart';
import '../../purchaseFolder/widgets/purchase_notes_widget.dart';
import '../../purchaseFolder/widgets/purchase_party_add.dart';
import '../../purchaseFolder/widgets/purchase_round_off_widget.dart';


class PurchaseOrderBodyWidget extends StatefulWidget {
  const PurchaseOrderBodyWidget({Key? key}) : super(key: key);

  @override
  State<PurchaseOrderBodyWidget> createState() => _PurchaseOrderBodyWidgetState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();

class _PurchaseOrderBodyWidgetState extends State<PurchaseOrderBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _commonClass.getScreenHeight(context),
      width: _commonClass.getScreenWidth(context),
      color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            PurchaseOrderPartyAdd(),
            PurchaseOrderItemsWidget(),
            PurchaseOrderAdditionalChargesWidget(),
            PurchaseOrderDiscountWidget(),
            PurchaseOrderRoundOffWidget(),
            PurchaseOrderNotesWidget(),
            CreditNoteDocumentWidget(),

          ],
        ),
      ),
    );
  }
}
