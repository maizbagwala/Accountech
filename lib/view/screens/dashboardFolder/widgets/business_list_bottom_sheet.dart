import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:accountech/common/my_shared_preferences.dart';
import 'package:accountech/common/string_file.dart';
import 'package:accountech/controller/companyController/company_controller.dart';
import 'package:accountech/model/companyModels/company_list.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../widgets/textWidgets/text_widget.dart';

class BusinessListBottomSheet extends StatefulWidget {
  final Function refreshScreen;

  const BusinessListBottomSheet({Key? key, required this.refreshScreen})
      : super(key: key);

  @override
  State<BusinessListBottomSheet> createState() =>
      _BusinessListBottomSheetState();
}

class _BusinessListBottomSheetState extends State<BusinessListBottomSheet>
    with TickerProviderStateMixin {
  final StringFile _stringFile = StringFile();
  final ColorClass _colorClass = ColorClass();
  final CommonClass _commonClass = CommonClass();
  late CompanyController _companyController;

  @override
  void initState() {
    super.initState();
    _companyController = CompanyController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(CommonClass.headerHeight + 62),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                          text: "Business List",
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
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: _commonClass.getScreenWidth(context),
                child: FutureBuilder<CompanyListModel>(
                  future: _companyController.getBusinessList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return TextWidget(
                          text: "There is an error please try again...",
                          textStyle: _commonClass.getTextStyle(15,
                              _colorClass.blackColor, CommonClass.semiBold));
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
                      dynamic value = snapshot.data;

                      if (value.status != null) {
                        if (value.status == 200 && value.data != null) {
                          return ListView.separated(
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemCount: value.data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    MySharedPreferences.businessSelectedID.$ =
                                        value.data[index].id;
                                    MySharedPreferences.businessSelectedName.$ =
                                        value.data[index].businessName;
                                    widget.refreshScreen();

                                    Navigator.pop(context);
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                _commonClass.assetURL +
                                                    value.data[index]
                                                        .businessLogo,
                                                fit: BoxFit.cover,
                                                height: 50,
                                                width: 50,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }

                                                  return Center(
                                                    child: SizedBox(
                                                      height: 50,
                                                      width: 50,
                                                      child: Lottie.asset(
                                                          _commonClass.myLoader,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextWidget(
                                                  overflow:
                                                      TextOverflow.visible,
                                                  text: StringUtils.capitalize(
                                                      value.data[index]
                                                          .businessName),
                                                  textStyle:
                                                      _commonClass.getTextStyle(
                                                          15,
                                                          _colorClass
                                                              .blackColor,
                                                          CommonClass.medium)),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              TextWidget(
                                                  overflow:
                                                      TextOverflow.visible,
                                                  text: StringUtils.capitalize(
                                                      value.data[index]
                                                          .industryType),
                                                  textStyle:
                                                      _commonClass.getTextStyle(
                                                          13,
                                                          _colorClass
                                                              .blackColor,
                                                          CommonClass.light)),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              TextWidget(
                                                  overflow:
                                                      TextOverflow.visible,
                                                  text: value
                                                      .data[index].businessPhone
                                                      .toString(),
                                                  textStyle:
                                                      _commonClass.getTextStyle(
                                                          13,
                                                          _colorClass
                                                              .blackColor,
                                                          CommonClass.light)),
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                      }
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
