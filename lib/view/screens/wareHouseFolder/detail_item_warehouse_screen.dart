import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/view/screens/wareHouseFolder/widgets/warehouse_item_widget.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:flutter/material.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class DetailItemWarehouseScreen extends StatefulWidget {
  static String detailItemWarehouseRoute = "/DetailItemWarehouseScreen";

  const DetailItemWarehouseScreen({Key? key}) : super(key: key);

  @override
  State<DetailItemWarehouseScreen> createState() =>
      _DetailItemWarehouseScreenState();
}

final ColorClass _colorClass = ColorClass();
final CommonClass _commonClass = CommonClass();

class _DetailItemWarehouseScreenState extends State<DetailItemWarehouseScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(CommonClass.headerHeight + 110),
        child: AppBarWidget(),
      ),
      body: Container(
        color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
        height: _commonClass.getScreenHeight(context),
        child: const WarehouseItemWidget(),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonAppBarWidget(
          title: TextWidget(
              text: "Warehouse Details",
              textStyle: _commonClass.getTextStyle(
                  20, _colorClass.blackColor, CommonClass.semiBold)),
          actions: null,
        ),
        const AppBarBelowDataWidget()
      ],
    );
  }
}

class AppBarBelowDataWidget extends StatefulWidget {
  const AppBarBelowDataWidget({Key? key}) : super(key: key);

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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                          text: "Warehouse Number",
                          textStyle: _commonClass.getTextStyle(
                              11, _colorClass.blackColor, CommonClass.medium)),
                      const SizedBox(
                        height: 5,
                      ),
                      TextWidget(
                          text: "#98616875",
                          textStyle: _commonClass.getTextStyle(
                              15, _colorClass.blackColor, CommonClass.light)),
                      const SizedBox(
                        height: 10,
                      ),
                      TextWidget(
                          text: "Warehouse Name",
                          textStyle: _commonClass.getTextStyle(
                              11, _colorClass.blackColor, CommonClass.medium)),
                      const SizedBox(
                        height: 5,
                      ),
                      TextWidget(
                          text: "Akshay Warehouse",
                          textStyle: _commonClass.getTextStyle(
                              15, _colorClass.blackColor, CommonClass.light)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
