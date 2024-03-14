
import 'package:flutter/material.dart';

import '../../../../common/common_class.dart';

class SalesReturnSalesManager extends StatefulWidget {
  const SalesReturnSalesManager({Key? key}) : super(key: key);

  @override
  State<SalesReturnSalesManager> createState() => _SalesReturnSalesManagerState();
}
final CommonClass _commonClass=CommonClass();
class _SalesReturnSalesManagerState extends State<SalesReturnSalesManager> {
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
