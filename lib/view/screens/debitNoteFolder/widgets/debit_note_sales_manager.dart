
import 'package:flutter/material.dart';
import '../../../../common/common_class.dart';

class DebitNoteSalesManager extends StatefulWidget {
  const DebitNoteSalesManager({Key? key}) : super(key: key);

  @override
  State<DebitNoteSalesManager> createState() => _DebitNoteSalesManagerState();
}
final CommonClass _commonClass=CommonClass();
class _DebitNoteSalesManagerState extends State<DebitNoteSalesManager> {
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
