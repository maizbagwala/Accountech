import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/controller/expenseController/expense_controller.dart';
import 'package:accountech/view/screens/cashAndBankFolder/widgets/cash_bank_item_widget.dart';
import 'package:accountech/view/screens/expenseFolder/widgets/edit_expense_bottom_sheet.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../widgets/textWidgets/text_widget.dart';
import 'package:accountech/model/expenseModel/expenses_individual_list_model.dart';

class DetailItemExpenseScreen extends StatefulWidget {
  static String detailItemExpenseRoute = "/DetailItemExpenseScreen";

  const DetailItemExpenseScreen({Key? key}) : super(key: key);

  @override
  State<DetailItemExpenseScreen> createState() =>
      _DetailItemExpenseScreenState();
}

final ColorClass _colorClass = ColorClass();
final CommonClass _commonClass = CommonClass();
final StringFile _stringFile = StringFile();
ExpenseController _expenseController = ExpenseController();
List<String> expenseCategories=[];
List<int> expenseCategoriesIDs=[];
class _DetailItemExpenseScreenState extends State<DetailItemExpenseScreen> {
  late Map<String, dynamic> _routeData;
  String _expenseID = "";
  Data? _expensesIndividual;

  @override
  void initState() {
    super.initState();
  }

  void getExpenseItemData() async {
    await _expenseController
        .getExpenseIndividualItemData(_expenseID)
        .then((value) {
          print("maiz maiz $value");
      if (value.toString().isNotEmpty) {
        print("from detail page 1 $value");
        if (value.status != null) {
          if (value.status == 200 && value.data != null) {
            print("from detail page $value");
            _expensesIndividual = value.data as Data;
            setState(() {});
          }
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    _routeData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _expenseID = _routeData['expense_id'].toString();

    expenseCategories.addAll(_routeData['expense_category_list']);
    expenseCategoriesIDs.addAll(_routeData['expense_category_id_list']);
    getExpenseItemData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(CommonClass.headerHeight + 110),
        child: _expensesIndividual == null
            ? Container()
            : AppBarWidget(_expensesIndividual!,_expenseID),
      ),
      body: Container(
        color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
        height: _commonClass.getScreenHeight(context),
        child: _expensesIndividual == null
            ? Container()
            : CashBankItemWidget(expensesIndividual: _expensesIndividual!),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  final Data expensesIndividual;
final String expenseID;
  const AppBarWidget(this.expensesIndividual, this. expenseID, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonAppBarWidget(
          title: TextWidget(
              text: "Expense Details",
              textStyle: _commonClass.getTextStyle(
                  20, _colorClass.blackColor, CommonClass.semiBold)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Card(
                color: _colorClass.greenColor,
                child: InkWell(
                  onTap: () {
                    showMaterialModalBottomSheet(
                      context: context,
                      expand: true,
                      builder: (context) =>
                          StatefulBuilder(builder: (context, bottomSheetSetState) {
                            return EditExpenseBottomSheet(
                                expenseCategories: expenseCategories,
                                expenseCategoriesIDs: expenseCategoriesIDs,
                              expensesIndividual: expensesIndividual,

                                bottomSheetSetState: bottomSheetSetState,

                            );
                          }),
                    ).then((value) {


                    });


                  },
                  splashColor: _colorClass.greyColor.withAlpha(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 15,
                      child: TextWidget(
                          text: _stringFile.edit,
                          textStyle: _commonClass.getTextStyle(
                              13, _colorClass.whiteColor, CommonClass.medium)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: _colorClass.redColor,
                child: InkWell(
                  onTap: () {

                    _commonClass.showCustomDialog(
                        context,
                        "This operation can't be undone",
                        "Do you really want to delete expense number ${expensesIndividual.expenseNo}?",
                        () {
                          _commonClass.showLoader(context, true);

                          _expenseController.deleteExpense(expenseID).then((value) {

                            if(value.toString().isNotEmpty)
                              {
                                _commonClass.showMessage(context, "Expense deleted");

                                Navigator.pop(context);
                                Navigator.pop(context);
                              }

                            _commonClass.showLoader(context, false);

                          });
                        });
                  },
                  splashColor: _colorClass.greyColor.withAlpha(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 15,
                      child: TextWidget(
                          text: _stringFile.delete,
                          textStyle: _commonClass.getTextStyle(
                              13, _colorClass.whiteColor, CommonClass.medium)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        AppBarBelowDataWidget(expensesIndividual)
      ],
    );
  }
}

class AppBarBelowDataWidget extends StatefulWidget {
  final Data expensesIndividual;

  const AppBarBelowDataWidget(this.expensesIndividual, {Key? key})
      : super(key: key);

  @override
  State<AppBarBelowDataWidget> createState() => _AppBarBelowDataWidgetState();
}

class _AppBarBelowDataWidgetState extends State<AppBarBelowDataWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: _commonClass.getScreenWidth(context),
        child: Column(
          children: [
            SizedBox(
              width: _commonClass.getScreenWidth(context),
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                    text: "Expense Category",
                                    textStyle: _commonClass.getTextStyle(
                                        11,
                                        _colorClass.blackColor,
                                        CommonClass.medium)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                    text: widget.expensesIndividual.categoryName
                                        .toString()
                                        .toUpperCase(),
                                    textStyle: _commonClass.getTextStyle(
                                        10,
                                        _colorClass.blackColor,
                                        CommonClass.light)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                    text: "Payment Mode",
                                    textStyle: _commonClass.getTextStyle(
                                        11,
                                        _colorClass.blackColor,
                                        CommonClass.medium)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                    text: widget.expensesIndividual.paymentMode!,
                                    textStyle: _commonClass.getTextStyle(
                                        10,
                                        _colorClass.blackColor,
                                        CommonClass.light)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                    text: "Date",
                                    textStyle: _commonClass.getTextStyle(
                                        11,
                                        _colorClass.blackColor,
                                        CommonClass.medium)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                    text: widget.expensesIndividual.date!,
                                    textStyle: _commonClass.getTextStyle(
                                        10,
                                        _colorClass.blackColor,
                                        CommonClass.light)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                              text: "Note",
                              textStyle: _commonClass.getTextStyle(11,
                                  _colorClass.blackColor, CommonClass.medium)),
                          const SizedBox(
                            height: 10,
                          ),
                          TextWidget(
                              text: widget.expensesIndividual.eNotes??"",
                              textStyle: _commonClass.getTextStyle(10,
                                  _colorClass.blackColor, CommonClass.light)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
