import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/view/screens/purchaseReturnFolder/widgets/purchase_return_additional_charges_widget.dart';
import 'package:accountech/view/screens/purchaseReturnFolder/widgets/purchase_return_discount_widget.dart';
import 'package:accountech/view/screens/purchaseReturnFolder/widgets/purchase_return_items_widget.dart';
import 'package:accountech/view/screens/purchaseReturnFolder/widgets/purchase_return_notes_widget.dart';
import 'package:accountech/view/screens/purchaseReturnFolder/widgets/purchase_return_party_add.dart';
import 'package:accountech/view/screens/purchaseReturnFolder/widgets/purchase_return_round_off_widget.dart';
import 'package:flutter/material.dart';

import '../../creditNoteFolder/widgets/credit_note_document_widget.dart';


class PurchaseReturnBodyWidget extends StatefulWidget {
  const PurchaseReturnBodyWidget({Key? key}) : super(key: key);

  @override
  State<PurchaseReturnBodyWidget> createState() => _PurchaseReturnBodyWidgetState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();

class _PurchaseReturnBodyWidgetState extends State<PurchaseReturnBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _commonClass.getScreenHeight(context),
      width: _commonClass.getScreenWidth(context),
      color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            PurchaseReturnPartyAdd(),
            PurchaseReturnItemsWidget(),
            PurchaseReturnAdditionalChargesWidget(),
            PurchaseReturnDiscountWidget(),
            PurchaseReturnRoundOffWidget(),
            // PurchaseReturnAmountReceivedWidget(),
            PurchaseReturnNotesWidget(),

            CreditNoteDocumentWidget(),

          ],
        ),
      ),
    );
  }
}
