import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/view/screens/purchaseFolder/widgets/purchase_additional_charges_widget.dart';
import 'package:accountech/view/screens/purchaseOrderFolder/widgets/purchase_order_discount_widget.dart';
import 'package:accountech/view/screens/purchaseOrderFolder/widgets/purchase_order_items_widget.dart';
import 'package:accountech/view/screens/purchaseOrderFolder/widgets/purchase_order_notes_widget.dart';
import 'package:accountech/view/screens/purchaseOrderFolder/widgets/purchase_order_party_add.dart';
import 'package:accountech/view/screens/purchaseOrderFolder/widgets/purchase_order_round_off_widget.dart';
import 'package:flutter/material.dart';

import '../../creditNoteFolder/widgets/credit_note_document_widget.dart';



class PurchaseBodyWidget extends StatefulWidget {
  const PurchaseBodyWidget({Key? key}) : super(key: key);

  @override
  State<PurchaseBodyWidget> createState() => _PurchaseBodyWidgetState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();

class _PurchaseBodyWidgetState extends State<PurchaseBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _commonClass.getScreenHeight(context),
      width: _commonClass.getScreenWidth(context),
      color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            PurchasePartyAdd(),
            PurchaseItemsWidget(),
            PurchaseAdditionalChargesWidget(),
            PurchaseDiscountWidget(),
            PurchaseRoundOffWidget(),
            PurchaseNotesWidget(),
            CreditNoteDocumentWidget(),

          ],
        ),
      ),
    );
  }
}
