
import 'package:flutter/material.dart';

import '../../../../common/common_class.dart';

class GoodsInTransitSalesManager extends StatefulWidget {
  const GoodsInTransitSalesManager({Key? key}) : super(key: key);

  @override
  State<GoodsInTransitSalesManager> createState() => _GoodsInTransitSalesManagerState();
}
final CommonClass _commonClass=CommonClass();
class _GoodsInTransitSalesManagerState extends State<GoodsInTransitSalesManager> {
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
