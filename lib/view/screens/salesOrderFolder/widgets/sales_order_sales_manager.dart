
import 'package:flutter/material.dart';
import '../../../../common/common_class.dart';

class SalesOrderSalesManager extends StatefulWidget {
  const SalesOrderSalesManager({Key? key}) : super(key: key);

  @override
  State<SalesOrderSalesManager> createState() => _SalesOrderSalesManagerState();
}
final CommonClass _commonClass=CommonClass();
class _SalesOrderSalesManagerState extends State<SalesOrderSalesManager> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: _commonClass.getScreenWidth(context),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [

              ],
            ),
          ),
        ),
      ),

    ],);
  }
}
