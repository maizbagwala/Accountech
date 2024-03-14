import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/my_shared_preferences.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/view/screens/dashboardFolder/widgets/business_list_bottom_sheet.dart';
import 'package:accountech/view/screens/debitNoteFolder/debit_note_screen.dart';
import 'package:accountech/view/screens/deliveryChallanFolder/delivery_challan_screen.dart';
import 'package:accountech/view/screens/expenseFolder/expense_screen.dart';
import 'package:accountech/view/screens/goodInTransitFolder/add_good_in_transit_screen.dart';
import 'package:accountech/view/screens/invoiceFolder/invoice_screen.dart';
import 'package:accountech/view/screens/proformaInvoiceFolder/proforma_invoice_screen.dart';
import 'package:accountech/view/screens/purchaseFolder/purchase_screen.dart';
import 'package:accountech/view/screens/purchaseOrderFolder/purchase_order_screen.dart';
import 'package:accountech/view/screens/purchaseReturnFolder/purchase_return_screen.dart';
import 'package:accountech/view/screens/quotationFolder/quotation_screen.dart';
import 'package:accountech/view/screens/salesOrderFolder/sales_order_screen.dart';
import 'package:accountech/view/screens/salesReturnFolder/sales_return_screen.dart';
import 'package:accountech/view/screens/wareHouseFolder/warehouse_screen.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../common/common_class.dart';
import '../../../widgets/textWidgets/text_widget.dart';
import '../cashAndBankFolder/cash_and_bank_screen.dart';
import '../creditNoteFolder/credit_note_screen.dart';
import '../goodInTransitFolder/good_in_transit_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String textName;

  const DashboardScreen(this.textName, {Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

final ColorClass _colorClass = ColorClass();
final StringFile _stringFile = StringFile();
final CommonClass _commonClass = CommonClass();

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: const FlowTingBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextWidget(
                    text: "Hello,",
                    textStyle: _commonClass.getTextStyle(
                        30, _colorClass.blackColor, CommonClass.light)),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                    text:
                        StringUtils.capitalize(MySharedPreferences.userName.$),
                    textStyle: _commonClass.getTextStyle(
                        30, _colorClass.blackColor, CommonClass.semiBold)),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                    text:
                        DateFormat('EEEE dd MMMM yyyy').format(DateTime.now()),
                    textStyle: _commonClass.getTextStyle(
                        15,
                        _colorClass.greyColor.withAlpha(100),
                        CommonClass.regular)),
                const SizedBox(
                  height: 10,
                ),
                Material(
                  color: _colorClass.mainBrandColor
                      .withAlpha(CommonClass.bgAlpha + 20),
                  child: InkWell(
                    splashColor: _colorClass.mainBrandColor
                        .withAlpha(CommonClass.bgAlpha + 30),
                    onTap: () {

                      showMaterialModalBottomSheet(
                        context: context,
                        expand: true,
                        builder: (context) =>
                            StatefulBuilder(builder: (context, bottomSheetSetState) {
                              return    BusinessListBottomSheet(refreshScreen: (){

                                setState(() {

                                });
                              },);
                            }),
                      );

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextWidget(
                              text:
                                  MySharedPreferences.businessSelectedName.$ ??
                                      'ERROR',
                              textStyle: _commonClass.getTextStyle(
                                  12,
                                  _colorClass.mainBrandColor,
                                  CommonClass.semiBold)),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            FontAwesomeIcons.caretDown,
                            color: _colorClass.mainBrandColor,
                            size: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: _colorClass.greyColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: _colorClass.greyColor)),
                  child: GestureDetector(
                    onTap: () {},
                    child: ListTile(
                      title: TextWidget(
                          text: _stringFile.lookUpAnyGSTINInfo,
                          textStyle: _commonClass.getTextStyle(
                              12, _colorClass.greyColor, CommonClass.medium)),
                      trailing: Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: _colorClass.blackColor.withAlpha(200),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FlowTingBar extends StatelessWidget {
  const FlowTingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (c) {
              return StatefulBuilder(builder: (context, bottomSheetSetState) {
                return const AddUnitBottomSheet();
              });
            });
      },
      child: const Icon(FontAwesomeIcons.ellipsis),
      backgroundColor: _colorClass.mainBrandColor,
      tooltip: _stringFile.more,
    );
  }
}

class AddUnitBottomSheet extends StatefulWidget {
  const AddUnitBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddUnitBottomSheet> createState() => _AddUnitBottomSheetState();
}

class _AddUnitBottomSheetState extends State<AddUnitBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        splashColor: _colorClass.bgColor,
                        child: const Icon(FontAwesomeIcons.xmark))
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: _colorClass.bgColor,
                thickness: 1,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                    text: _stringFile.salesTransactions,
                    textStyle: _commonClass.getTextStyle(
                        17, _colorClass.blackColor, CommonClass.semiBold)),
                const SizedBox(
                  height: 20,
                ),
                CommonCard(
                    onTapCallback: () {
                      Navigator.pushNamed(
                          context, QuotationScreen.quotationScreenRoute);
                    },
                    title: _stringFile.quotation,
                    widget: Icon(FontAwesomeIcons.filePen,
                        color: _colorClass.secondaryBrandColor)),
                CommonCard(
                    onTapCallback: () {
                      Navigator.pushNamed(context,
                          DeliveryChallanScreen.deliveryChallanScreenRoute);
                    },
                    title: _stringFile.deliveryChallan,
                    widget: Icon(FontAwesomeIcons.truck,
                        color: _colorClass.secondaryBrandColor)),
                CommonCard(
                    onTapCallback: () {
                      Navigator.pushNamed(
                          context, InvoiceScreen.invoiceScreenRoute);
                    },
                    title: _stringFile.invoice,
                    widget: Icon(FontAwesomeIcons.fileLines,
                        color: _colorClass.secondaryBrandColor)),
                CommonCard(
                    onTapCallback: () {
                      Navigator.pushNamed(
                          context, SalesOrderScreen.salesOrderScreenRoute);
                    },
                    title: "Sales Order",
                    widget: Icon(FontAwesomeIcons.fileLines,
                        color: _colorClass.secondaryBrandColor)),
                CommonCard(
                    onTapCallback: () {
                      Navigator.pushNamed(context,
                          ProformaInvoiceScreen.proformaInvoiceScreenRoute);
                    },
                    title: "Proforma Invoice",
                    widget: Icon(FontAwesomeIcons.fileLines,
                        color: _colorClass.secondaryBrandColor)),
                CommonCard(
                    onTapCallback: () {
                      Navigator.pushNamed(
                          context, CreditNoteScreen.creditNoteScreenRoute);
                    },
                    title: "Credit Note",
                    widget: Icon(FontAwesomeIcons.fileLines,
                        color: _colorClass.secondaryBrandColor)),
                CommonCard(
                    onTapCallback: () {
                      Navigator.pushNamed(
                          context, SalesReturnScreen.salesReturnScreenRoute);
                    },
                    title: "Sales Return",
                    widget: Icon(FontAwesomeIcons.truck,
                        color: _colorClass.secondaryBrandColor)),
                CommonCardHeader(header: _stringFile.purchaseTransaction),
                CommonCard(
                    onTapCallback: () {
                      Navigator.pushNamed(context,
                          PurchaseOrderScreen.purchaseOrderScreenRoute);
                    },
                    title: _stringFile.purchaseOrder,
                    widget: Icon(FontAwesomeIcons.cartShopping,
                        color: _colorClass.secondaryBrandColor)),
                CommonCard(
                    onTapCallback: () {
                      Navigator.pushNamed(
                          context, PurchaseScreen.purchaseScreenRoute);
                    },
                    title: _stringFile.purchase,
                    widget: Icon(FontAwesomeIcons.cartShopping,
                        color: _colorClass.secondaryBrandColor)),
                CommonCard(
                    onTapCallback: () {
                      Navigator.pushNamed(context,
                          PurchaseReturnScreen.purchaseReturnScreenRoute);
                    },
                    title: _stringFile.purchaseReturn,
                    widget: Icon(FontAwesomeIcons.arrowRotateLeft,
                        color: _colorClass.secondaryBrandColor)),
                CommonCard(
                    onTapCallback: () {
                      Navigator.pushNamed(
                          context, DebitNoteScreen.debitNoteScreen);
                    },
                    title: _stringFile.debitNote,
                    widget: Icon(FontAwesomeIcons.arrowRotateLeft,
                        color: _colorClass.secondaryBrandColor)),
                CommonCard(
                    onTapCallback: () {
                      Navigator.pushNamed(context,
                          GoodInTransitScreen.goodInTransitRoute);
                    },
                    title: _stringFile.goodsInTransit,
                    widget: Icon(FontAwesomeIcons.arrowRotateLeft,
                        color: _colorClass.secondaryBrandColor)),
                CommonCardHeader(
                  header: _stringFile.cashAndBank,
                ),
                CommonCard(
                    onTapCallback: () {
                      Navigator.pushNamed(
                          context, CashAndBankScreen.cashAndBankRoute);
                    },
                    title: _stringFile.cashAndBank,
                    widget: Icon(FontAwesomeIcons.buildingColumns,
                        color: _colorClass.secondaryBrandColor)),
                CommonCardHeader(header: _stringFile.otherExpenses),
                CommonCard(
                    onTapCallback: () {
                      Navigator.pushNamed(
                          context, ExpenseScreen.expenseScreenRoute);
                    },
                    title: _stringFile.expense,
                    widget: Icon(FontAwesomeIcons.solidMoneyBill1,
                        color: _colorClass.secondaryBrandColor)),
                const CommonCardHeader(header: "Warehouse"),
                CommonCard(
                    onTapCallback: () {
                      Navigator.pushNamed(
                          context, WarehouseScreen.wareHouseRoute);
                    },
                    title: "Warehouse",
                    widget: Icon(FontAwesomeIcons.warehouse,
                        color: _colorClass.secondaryBrandColor))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommonCard extends StatefulWidget {
  final Function onTapCallback;
  final String title;
  final Widget widget;

  const CommonCard(
      {Key? key,
      required this.onTapCallback,
      required this.title,
      required this.widget})
      : super(key: key);

  @override
  State<CommonCard> createState() => _CommonCardState();
}

class _CommonCardState extends State<CommonCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          widget.onTapCallback();
        },
        splashColor: _colorClass.bgColor,
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _colorClass.secondaryBrandColor
                  .withAlpha(CommonClass.bgAlpha),
            ),
            child: widget.widget,
          ),
          horizontalTitleGap: 0,
          title: TextWidget(
              text: widget.title,
              textStyle: _commonClass.getTextStyle(
                11,
                _colorClass.blackColor,
                CommonClass.regular,
              )),
        ),
      ),
    );
  }
}

class CommonCardHeader extends StatelessWidget {
  final String header;

  const CommonCardHeader({Key? key, required this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Divider(
          thickness: 1,
          color: _colorClass.bgColor,
        ),
        const SizedBox(
          height: 20,
        ),
        TextWidget(
            text: header,
            textStyle: _commonClass.getTextStyle(
                17, _colorClass.blackColor, CommonClass.semiBold)),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
