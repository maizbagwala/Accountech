import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/view/screens/creditNoteFolder/widgets/credit_note_document_widget.dart';
import 'package:flutter/material.dart';

import 'credit_note_additional_charges_widget.dart';
import 'credit_note_discount_widget.dart';
import 'credit_note_items_widget.dart';
import 'credit_note_notes_widget.dart';
import 'credit_note_party_add.dart';
import 'credit_note_round_off_widget.dart';

class CreditNoteBodyWidget extends StatefulWidget {
  const CreditNoteBodyWidget({Key? key}) : super(key: key);

  @override
  State<CreditNoteBodyWidget> createState() => _CreditNoteBodyWidgetState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();

class _CreditNoteBodyWidgetState extends State<CreditNoteBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _commonClass.getScreenHeight(context),
      width: _commonClass.getScreenWidth(context),
      color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            CreditNotePartyAdd(),
            CreditNoteItemsWidget(),
            CreditNoteAdditionalChargesWidget(),
            CreditNoteDiscountWidget(),
            CreditNoteRoundOffWidget(),
            CreditNoteNotesWidget(),
            CreditNoteDocumentWidget(),
          ],
        ),
      ),
    );
  }
}
