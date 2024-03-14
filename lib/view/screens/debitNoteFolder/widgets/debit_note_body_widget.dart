import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:flutter/material.dart';

import '../../creditNoteFolder/widgets/credit_note_document_widget.dart';
import 'debit_note_additional_charges_widget.dart';
import 'debit_note_discount_widget.dart';
import 'debit_note_items_widget.dart';
import 'debit_note_notes_widget.dart';
import 'debit_note_party_add.dart';
import 'debit_note_round_off_widget.dart';

class DebitNoteBodyWidget extends StatefulWidget {
  const DebitNoteBodyWidget({Key? key}) : super(key: key);

  @override
  State<DebitNoteBodyWidget> createState() => _DebitNoteBodyWidgetState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();

class _DebitNoteBodyWidgetState extends State<DebitNoteBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _commonClass.getScreenHeight(context),
      width: _commonClass.getScreenWidth(context),
      color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            DebitNotePartyAdd(),
            DebitNoteItemsWidget(),
            DebitNoteAdditionalChargesWidget(),
            DebitNoteDiscountWidget(),
            DebitNoteRoundOffWidget(),
            DebitNoteNotesWidget(),
            CreditNoteDocumentWidget(),

          ],
        ),
      ),
    );
  }
}
