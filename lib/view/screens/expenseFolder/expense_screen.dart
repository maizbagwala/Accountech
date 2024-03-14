import 'dart:convert';

import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/model/expenseModel/expense_category_model.dart';
import 'package:accountech/model/expenseModel/expense_list_data_model.dart'
    as expensesListDataModel;
import 'package:accountech/view/screens/expenseFolder/detail_item_expense_screen.dart';
import 'package:accountech/view/screens/expenseFolder/widgets/add_expense_bottom_sheet.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../widgets/textWidgets/text_widget.dart';
import 'package:accountech/controller/expenseController/expense_controller.dart';

import '../itemsFolder/create_item_screen.dart';

class ExpenseScreen extends StatefulWidget {
  static String expenseScreenRoute = "/ExpenseScreen";

  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

final ColorClass _colorClass = ColorClass();
final CommonClass _commonClass = CommonClass();
final StringFile _stringFile = StringFile();

class _ExpenseScreenState extends State<ExpenseScreen> {
  final ExpenseController _expenseController = ExpenseController();
  List<String> _expenseCategories = [];
  List<int> _expenseCategoriesIDs = [];
  bool _dataFetched = false;

  String _selectedCategoryID = "";
  List<expensesListDataModel.Datum> expensesList = [];

  @override
  void initState() {
    super.initState();

    getExpenseCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(CommonClass.headerHeight + 120),
        child: Column(
          children: [
            CommonAppBarWidget(
              title: TextWidget(
                text: _stringFile.expense,
                textStyle: _commonClass.getTextStyle(
                    20, _colorClass.blackColor, CommonClass.semiBold),
              ),
              actions: null,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownSearch<String>(
                        popupProps: const PopupProps.modalBottomSheet(
                          showSearchBox: true,
                        ),
                        items: _expenseCategories,
                        onChanged: (value) {
                          if (value != null) {
                            for (int i = 0; i < _expenseCategories.length; i++) {
                              if (value == _expenseCategories[i]) {
                                _selectedCategoryID =
                                    _expenseCategoriesIDs[i].toString();

                                fetchRelevantItems(_selectedCategoryID);
                                setState(() {});
                              }
                            }
                          }
                        },
                        dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                          labelStyle:
                              TextStyle(color: _colorClass.secondaryBrandColor),
                          contentPadding: const EdgeInsets.fromLTRB(12, 7, 0, 0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _colorClass.secondaryBrandColor, width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _colorClass.secondaryBrandColor, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _colorClass.secondaryBrandColor, width: 1)),
                          labelText: "Select Expense Category",
                        )),
                        selectedItem: !_dataFetched
                            ? 'Fetching data'
                            : _expenseCategories.isEmpty
                                ? 'No data available'
                                : _expenseCategories[0].toUpperCase()),
                  ),
                  Card(
                    color: _colorClass.mainBrandColor,
                    child: InkWell(
                      splashColor: _colorClass.bgColor,
                      onTap: () async {
                        showModalBottomSheet(
                            context: context,
                            builder: (c) {
                              return StatefulBuilder(
                                  builder: (context, bottomSheetSetState) {
                                    return  AddBottomSheetExpense(
                                      title: "Expenses Category", onFinish: ()=>getExpenseCategories(),
                                    );
                                  });
                            });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            expensesList.isEmpty
                ? Container()
                : Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWidget(
                            overflow: TextOverflow.visible,
                            text: "Date",
                            textStyle: _commonClass.getTextStyle(
                                12, _colorClass.greyColor, CommonClass.bold)),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWidget(
                            overflow: TextOverflow.visible,
                            text: "Expense Number",
                            textStyle: _commonClass.getTextStyle(
                                12, _colorClass.greyColor, CommonClass.bold)),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWidget(
                            overflow: TextOverflow.visible,
                            text: "Category",
                            textStyle: _commonClass.getTextStyle(
                                12, _colorClass.greyColor, CommonClass.bold)),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWidget(
                            overflow: TextOverflow.visible,
                            text: "Amount",
                            textStyle: _commonClass.getTextStyle(
                                12, _colorClass.greyColor, CommonClass.bold)),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
          ],
        ),
      ),
      body: expensesList.isEmpty
          ? Center(
              child: TextWidget(
                  overflow: TextOverflow.visible,
                  text: "No data found",
                  textStyle: _commonClass.getTextStyle(
                      15, _colorClass.blackColor, CommonClass.light)),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: expensesList.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  margin:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                  child: Material(
                      color: _colorClass.whiteColor,
                      child: InkWell(
                        onTap: () {
                          debugPrint(
                              "Expense id is ${expensesList[index].id.toString()}");
                          Navigator.pushNamed(context,
                              DetailItemExpenseScreen.detailItemExpenseRoute,
                              arguments: {
                                'expense_id': expensesList[index].id.toString(),
                                'expense_category_list': _expenseCategories,
                                'expense_category_id_list':
                                    _expenseCategoriesIDs
                              }).then((value) {
                            fetchRelevantItems(_selectedCategoryID);
                            setState(() {});
                          });
                        },
                        splashColor: _colorClass.bgColor,
                        child: Slidable(
                          // key: GlobalKey(),
                          // endActionPane: ActionPane(
                          //   motion: const ScrollMotion(),
                          //   dismissible: DismissiblePane(onDismissed: () {
                          //     setState(() {
                          //       expensesList.removeAt(index);
                          //     });
                          //   }),
                          //   children: [
                          //     SlidableAction(
                          //       onPressed: (e) {},
                          //       backgroundColor: _colorClass.secondaryBrandColor,
                          //       foregroundColor: Colors.white,
                          //       icon: Icons.edit,
                          //     ),
                          //     SlidableAction(
                          //       onPressed: (e) {},
                          //       backgroundColor: _colorClass.redColor,
                          //       foregroundColor: Colors.white,
                          //       icon: Icons.delete,
                          //     ),
                          //   ],
                          // ),
                          enabled: false,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: TextWidget(
                                        overflow: TextOverflow.visible,
                                        text: expensesList[index].date,
                                        textStyle: _commonClass.getTextStyle(
                                            12,
                                            _colorClass.blackColor,
                                            CommonClass.light))),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: TextWidget(
                                        overflow: TextOverflow.visible,
                                        text: expensesList[index].expenseNo,
                                        textStyle: _commonClass.getTextStyle(
                                            12,
                                            _colorClass.greyColor,
                                            CommonClass.medium))),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: TextWidget(
                                        overflow: TextOverflow.visible,
                                        text: expensesList[index].categoryName,
                                        textStyle: _commonClass.getTextStyle(
                                            12,
                                            _colorClass.greyColor,
                                            CommonClass.medium))),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: TextWidget(
                                        overflow: TextOverflow.visible,
                                        text: expensesList[index]
                                            .amount
                                            .toString(),
                                        textStyle: _commonClass.getTextStyle(
                                            12,
                                            _colorClass.greyColor,
                                            CommonClass.medium))),
                              ],
                            ),
                          ),
                        ),
                      )),
                );
              }),
      bottomNavigationBar: Material(
        color: _colorClass.mainBrandColor,
        child: InkWell(
          onTap: () {
            showMaterialModalBottomSheet(
              context: context,
              expand: true,
              builder: (context) =>
                  StatefulBuilder(builder: (context, bottomSheetSetState) {
                return AddExpenseBottomSheet(
                    expenseCategories: _expenseCategories,
                    expenseCategoriesIDs: _expenseCategoriesIDs,
                    bottomSheetSetState: bottomSheetSetState);
              }),
            ).then((value) {
              setState(() {
                fetchRelevantItems(_selectedCategoryID);
              });
            });
          },
          splashColor: _colorClass.bgColor,
          child: Container(
              height: 50,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextWidget(
                  text: "Add Expense",
                  textStyle: _commonClass.getTextStyle(
                      15, _colorClass.whiteColor, CommonClass.bold))),
        ),
      ),
    );
  }


  void getExpenseCategories() async {
    await _expenseController.getExpenseCategory().then((value) {
      if (value.toString().isNotEmpty) {
        GetExpenseCategoryModel data = value;
        setState(() {
          _dataFetched = true;
          for (var element in data.data!) {
            _expenseCategories.add(element.name.toString().toUpperCase());
            _expenseCategoriesIDs.add(element.id!.toInt());
          }
        });

        if (_expenseCategories.isNotEmpty) {
          _selectedCategoryID = _expenseCategoriesIDs[0].toString();
          fetchRelevantItems(_selectedCategoryID);
        }
      }
    });
  }

  void fetchRelevantItems(String selectedCategoryID) {
    debugPrint("id is $selectedCategoryID");
    _expenseController
        .getExpenseListData(selectedCategoryID.toString())
        .then((value) {
      if (value.toString().isNotEmpty) {
        if (value.status != null) {
          if (value.status == 200 && value.data != null) {
            expensesList = value.data as List<expensesListDataModel.Datum>;
            setState(() {});
          }
        }
      }
    });
  }
}
class AddBottomSheetExpense extends StatefulWidget {
  final String title;
  final String id;
  final Function onFinish;

  const AddBottomSheetExpense({Key? key, required this.title, this.id = "0", required this.onFinish})
      : super(key: key);

  @override
  State<AddBottomSheetExpense> createState() => _AddBottomSheetExpenseState();
}

class _AddBottomSheetExpenseState extends State<AddBottomSheetExpense> {
  var value;

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
                        child: TextWidget(
                            text: "Add ${widget.title}",
                            textStyle: _commonClass.getTextStyle(
                                15, _colorClass.blackColor, CommonClass.bold)),
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
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFieldWidget(
                maxLength: null,
                type: TextInputType.text,
                formatter: null,
                text: widget.title,
                onTypeCallBack: (e) {
                  setState(() {
                    value = e;
                  });
                }),
          ),
          bottomNavigationBar: Material(
            color: _colorClass.mainBrandColor,
            child: InkWell(
              onTap: () {
                addExpenseProperties(widget.title);
                Navigator.pop(context);
              },
              splashColor: _colorClass.bgColor,
              child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextWidget(
                      text: _stringFile.add,
                      textStyle: _commonClass.getTextStyle(
                          15, _colorClass.whiteColor, CommonClass.bold))),
            ),
          ),
        ));
  }

  void addExpenseProperties(String title) {
    switch (title) {
      case "Expenses Category":
        {
          ExpenseController().addExpanseCategory(value).then((value) {

            if (value['status'] != 200) {
              print("something went wrong");
            }else{
              widget.onFinish();
            }
          });
        }
        break;
    }
  }
}