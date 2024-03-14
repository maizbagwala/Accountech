import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/controller/partyController/party_controller.dart';
import 'package:accountech/model/partyModels/party_list_model.dart';
import 'package:accountech/view/screens/partiesFolder/create_party.dart';
import 'package:accountech/view/screens/partiesFolder/detail_party_screen.dart';
import 'package:accountech/view/screens/partiesFolder/widgets/parties_below_app_bar_widget.dart';
import 'package:accountech/view/screens/partiesFolder/widgets/parties_common_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../widgets/appBarWidgets/common_app_bar_parties_widget.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class PartiesScreen extends StatefulWidget {
  final String textName;

  const PartiesScreen(this.textName, {Key? key}) : super(key: key);

  @override
  State<PartiesScreen> createState() => _PartiesScreenState();
}

final ColorClass _colorClass = ColorClass();
final CommonClass _commonClass = CommonClass();
final StringFile _stringFile = StringFile();
final PartyController partyController = Get.find<PartyController>();
class _PartiesScreenState extends State<PartiesScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(CommonClass.headerHeight + 51),
          child: AppBar(),
        ),
        floatingActionButton: const FlowTingBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Container(
          color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
          height: _commonClass.getScreenHeight(context),
          child: FutureBuilder(
            future: partyController.getParty(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              // print(snapshot.data.data);
              if (snapshot.hasError) {
                return TextWidget(
                    text: "There is an error please try again...",
                    textStyle: _commonClass.getTextStyle(
                        15, _colorClass.blackColor, CommonClass.semiBold));
              } else if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child:
                        Lottie.asset(_commonClass.myLoader, fit: BoxFit.cover),
                  ),
                );
              } else {
                // PartyListModel value = snapshot.data;
                // print("else part");
                return GetX<PartyController>(
                  builder: (controller) {
                    print(controller.partyList);
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: controller.partyList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 16 / 9, crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return PartiesCommonRowWidget(
                            onTap: (String id, String name) {
                              Navigator.pushNamed(
                                  context, DetailPartyScreen.detailPartyRoute,
                                  arguments: {
                                    "id": controller.partyList[index].id,
                                    "data": controller.partyList[index]
                                  }).then((value) {partyController.getParty();});
                            },
                            data: controller.partyList[index],
                          );
                        });
                  }
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonAppBarPartiesWidget(),
        Container(
            margin: const EdgeInsets.only(top: 5),
            child: const PartiesBelowAppBarWidget()),
      ],
    );
  }
}

class FlowTingBar extends StatelessWidget {
  const FlowTingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, CreateParty.createPartyRoute).then((value) {
          partyController.getParty();
        });
      },
      child: const Icon(FontAwesomeIcons.circlePlus),
      backgroundColor: _colorClass.mainBrandColor,
      tooltip: _stringFile.createNewParty,
    );
  }
}
