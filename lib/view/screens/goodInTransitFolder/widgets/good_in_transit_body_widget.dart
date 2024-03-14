import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:flutter/material.dart';

import '../../creditNoteFolder/widgets/credit_note_document_widget.dart';
import 'good_in_transit_additional_charges_widget.dart';
import 'good_in_transit_discount_widget.dart';
import 'good_in_transit_items_widget.dart';
import 'good_in_transit_notes_widget.dart';
import 'good_in_transit_party_add.dart';
import 'good_in_transit_round_off_widget.dart';

class GoodsInTransitBodyWidget extends StatefulWidget {
  final Function getSalesManager;
  final Function getArchitect;
  final Function getParty;
  final Function getNote;
  final Function getDiscountPrice;
  final Function getDiscountPercent;
  final Function getRoundOffPercent;
  final Function getRoundOffAmount;

  const GoodsInTransitBodyWidget(
      {Key? key,
      required this.getSalesManager,
      required this.getArchitect,
      required this.getParty,
      required this.getNote,
      required this.getDiscountPrice,
      required this.getDiscountPercent,
      required this.getRoundOffPercent,
      required this.getRoundOffAmount})
      : super(key: key);

  @override
  State<GoodsInTransitBodyWidget> createState() =>
      _GoodsInTransitBodyWidgetState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();

class _GoodsInTransitBodyWidgetState extends State<GoodsInTransitBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _commonClass.getScreenHeight(context),
      width: _commonClass.getScreenWidth(context),
      color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GoodsInTransitPartyAdd(
              getSalesManager: (v) {
                widget.getSalesManager(v);
              },
              getArchitect: (v) {
                widget.getArchitect(v);
              },
              getParty: (v) {
                widget.getParty(v);
              },
            ),
            GoodsInTransitItemsWidget(),
            GoodsInTransitAdditionalChargesWidget(),
            GoodsInTransitDiscountWidget(
              getDiscountPrice: (v) {
                widget.getDiscountPrice(v);
              },
              getDiscountPercent: (v) {
                widget.getDiscountPercent(v);
              },
            ),
            GoodsInTransitRoundOffWidget(
              getRoundOffPrice: (v) => widget.getRoundOffAmount(v),
              getRoundOffPercent: (v) => widget.getRoundOffPercent(v),
            ),
            GoodsInTransitNotesWidget(
              getNote: (v) {
                widget.getNote(v);
              },
            ),
            CreditNoteDocumentWidget(),
          ],
        ),
      ),
    );
  }
}
