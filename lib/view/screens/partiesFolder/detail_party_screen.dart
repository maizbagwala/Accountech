import 'dart:convert';

import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/controller/partyController/party_controller.dart';
import 'package:accountech/model/partyModels/delete_party_response.dart';
import 'package:accountech/model/partyModels/party_details_model.dart';
import 'package:accountech/model/partyModels/party_list_model.dart';
import 'package:accountech/view/screens/partiesFolder/edit_party.dart';
import 'package:accountech/view/screens/partiesFolder/widgets/parties_invoices_common_row_widget.dart';
import 'package:accountech/view/screens/partiesFolder/widgets/party_personal_details_widget.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:accountech/widgets/commonWidget/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../widgets/textWidgets/text_widget.dart';

class DetailPartyScreen extends StatefulWidget {
  static String detailPartyRoute = "/DetailPartyScreen";

  final String textName;

  const DetailPartyScreen(this.textName, {Key? key}) : super(key: key);

  @override
  State<DetailPartyScreen> createState() => _DetailPartyScreenState();
}

class _DetailPartyScreenState extends State<DetailPartyScreen>
    with TickerProviderStateMixin {
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();
  final StringFile _stringFile = StringFile();
  bool first = true;
  late TabController _tabController;

  // Future<dynamic> _getTransactions;
  late Future<dynamic> _getDetails;
  var controller = Get.find<PartyController>();

  @override
  void initState() {
    super.initState();
    // _getTransactions=;
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    var data = args['data'] as Datum;
    if (first) {
      _getDetails = PartyController().getPartyDetails(args['id'].toString());
      first = false;
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(CommonClass.headerHeight + 129),
        child: Column(
          children: [
            CommonAppBarWidget(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Card(
                    color: _colorClass.greenColor,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, EditParty.editPartyRoute,arguments: {"id":args['id'].toString()});
                      },
                      splashColor: _colorClass.greyColor.withAlpha(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 15,
                          child: TextWidget(
                              text: _stringFile.edit,
                              textStyle: _commonClass.getTextStyle(13,
                                  _colorClass.whiteColor, CommonClass.medium)),
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
                        showModalBottomSheet(
                            context: context,
                            builder: (c) {
                              return StatefulBuilder(
                                  builder: (context, bottomSheetSetState) {
                                return DeleteDialog(
                                  onDelete: () {
                                    deleteParty(args['id'].toString());
                                  },
                                );
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
                              textStyle: _commonClass.getTextStyle(13,
                                  _colorClass.whiteColor, CommonClass.medium)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
                width: _commonClass.getScreenWidth(context),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        overflow: null,
                                        text: data.name!,
                                        textStyle: _commonClass.getTextStyle(
                                            14,
                                            _colorClass.blackColor,
                                            CommonClass.medium),
                                      ),
                                      TextWidget(
                                        overflow: null,
                                        text: data.partyType,
                                        textStyle: _commonClass.getTextStyle(
                                            12,
                                            _colorClass.blackColor,
                                            CommonClass.light),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () {},
                                      splashColor: _colorClass.bgColor,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, bottom: 8),
                                        child: TextWidget(
                                          overflow: null,
                                          text: _stringFile.downloadStatement,
                                          textStyle: _commonClass.getTextStyle(
                                              12,
                                              _colorClass.secondaryBrandColor,
                                              CommonClass.light),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        overflow: null,
                                        text: "₹ ${data.openingBalance} ",
                                        textStyle: _commonClass.getTextStyle(
                                            14,
                                            _colorClass.blackColor,
                                            CommonClass.medium),
                                      ),
                                      TextWidget(
                                        overflow: null,
                                        text: _stringFile.credit,
                                        textStyle: _commonClass.getTextStyle(
                                            10,
                                            _colorClass.greenColor,
                                            CommonClass.light),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    TabBar(
                      indicatorColor: _colorClass.mainBrandColor,
                      labelColor: _colorClass.blackColor,
                      controller: _tabController,
                      tabs: <Widget>[
                        Tab(
                          text: _stringFile.transaction,
                        ),
                        Tab(
                          text: _stringFile.details,
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(FontAwesomeIcons.circlePlus),
      //   backgroundColor: _colorClass.mainBrandColor,
      //   tooltip: _stringFile.billNInvoice,
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: controller.isLoading.value
          ? Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset(_commonClass.myLoader, fit: BoxFit.cover),
              ),
            )
          : Container(
              color: _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
              height: _commonClass.getScreenHeight(context),
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  // FutureBuilder(
                  //   future: _getTransactions,
                  //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  //     return GridView.builder(
                  //         shrinkWrap: true,
                  //         itemCount: 20,
                  //         gridDelegate:
                  //             const SliverGridDelegateWithFixedCrossAxisCount(
                  //                 childAspectRatio: 16 / 9, crossAxisCount: 2),
                  //         itemBuilder: (context, index) {
                  //           return PartiesInvoicesCommonRowWidget(
                  //             onTap: (String value) {},
                  //           );
                  //         });
                  //   },
                  // ),
                  GridView.builder(
                      shrinkWrap: true,
                      itemCount: 20,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 16 / 9, crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return PartiesInvoicesCommonRowWidget(
                          onTap: (String value) {},
                        );
                      }),
                  FutureBuilder(
                      future: _getDetails,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasError) {
                          return TextWidget(
                              text: "There is an error please try again...",
                              textStyle: _commonClass.getTextStyle(
                                  15,
                                  _colorClass.blackColor,
                                  CommonClass.semiBold));
                        } else if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Lottie.asset(_commonClass.myLoader,
                                  fit: BoxFit.cover),
                            ),
                          );
                        } else {
                          PartyDetailsModel value = snapshot.data;
                          return SingleChildScrollView(
                              child: PartyPersonalDetailsWidget(value));
                        }
                      })
                ],
              ),
            ),
    );
  }

  Future<void> deleteParty(String id) async {

    PartyController().deleteParty(id).then((value) {
      if (value != "") {
        var res = value as DeletePartyResponse;
        if (res.success == true) {

          print("deleted");
          Navigator.pop(context);
        }
      }
    });
  }
}
