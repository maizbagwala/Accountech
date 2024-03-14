import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/view/screens/proformaInvoiceFolder/widgets/proforma_invoice_additional_charges_widget.dart';
import 'package:accountech/view/screens/proformaInvoiceFolder/widgets/proforma_invoice_discount_widget.dart';
import 'package:accountech/view/screens/proformaInvoiceFolder/widgets/proforma_invoice_items_widget.dart';
import 'package:accountech/view/screens/proformaInvoiceFolder/widgets/proforma_invoice_notes_widget.dart';
import 'package:accountech/view/screens/proformaInvoiceFolder/widgets/proforma_invoice_party_add.dart';
import 'package:accountech/view/screens/proformaInvoiceFolder/widgets/proforma_invoice_round_off_widget.dart';
import 'package:flutter/material.dart';

class ProformaInvoiceBodyWidget extends StatefulWidget {
  const ProformaInvoiceBodyWidget({Key? key}) : super(key: key);

  @override
  State<ProformaInvoiceBodyWidget> createState() => _ProformaInvoiceBodyWidgetState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();

class _ProformaInvoiceBodyWidgetState extends State<ProformaInvoiceBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _commonClass.getScreenHeight(context),
      width: _commonClass.getScreenWidth(context),
      color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            ProformaInvoicePartyAdd(),
            ProformaInvoiceItemsWidget(),
            ProformaInvoiceAdditionalChargesWidget(),
            ProformaInvoiceDiscountWidget(),
            ProformaInvoiceRoundOffWidget(),
            ProformaInvoiceNotesWidget(),
          ],
        ),
      ),
    );
  }
}
