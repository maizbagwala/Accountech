import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/view/screens/deliveryChallanFolder/widgets/delivery_challan_party_add.dart';
import 'package:accountech/view/screens/invoiceFolder/widgets/invoice_amount_received_widget.dart';
import 'package:accountech/view/screens/invoiceFolder/widgets/invoice_notes_widget.dart';
import 'package:flutter/material.dart';

import 'invoice_discount_widget.dart';
import 'invoice_additional_charges_widget.dart';
import 'invoice_items_widget.dart';
import 'invoice_round_off_widget.dart';

class InvoiceBodyWidget extends StatefulWidget {
  const InvoiceBodyWidget({Key? key}) : super(key: key);

  @override
  State<InvoiceBodyWidget> createState() => _InvoiceBodyWidgetState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();

class _InvoiceBodyWidgetState extends State<InvoiceBodyWidget> {
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
            InvoiceItemsWidget(),
            InvoiceAdditionalChargesWidget(),
            InvoiceDiscountWidget(),
            InvoiceRoundOffWidget(),
            InvoiceAmountReceivedWidget(),
            InvoiceNotesWidget(),
          ],
        ),
      ),
    );
  }
}
