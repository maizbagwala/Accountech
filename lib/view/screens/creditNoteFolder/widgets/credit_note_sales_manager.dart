
import 'package:flutter/material.dart';
import '../../../../common/common_class.dart';

class CreditNoteSalesManager extends StatefulWidget {
  const CreditNoteSalesManager({Key? key}) : super(key: key);

  @override
  State<CreditNoteSalesManager> createState() => _CreditNoteSalesManagerState();
}
final CommonClass _commonClass=CommonClass();
class _CreditNoteSalesManagerState extends State<CreditNoteSalesManager> {
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
