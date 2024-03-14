
import 'package:flutter/material.dart';
import '../../../../common/common_class.dart';
class ProformaInvoiceSalesManager extends StatefulWidget {
  const ProformaInvoiceSalesManager({Key? key}) : super(key: key);

  @override
  State<ProformaInvoiceSalesManager> createState() => _ProformaInvoiceSalesManagerState();
}
final CommonClass _commonClass=CommonClass();
class _ProformaInvoiceSalesManagerState extends State<ProformaInvoiceSalesManager> {
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
