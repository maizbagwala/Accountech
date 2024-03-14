import 'dart:io';

import 'package:accountech/common/common_class.dart';
import 'package:accountech/controller/businessController/business_controller.dart';
import 'package:accountech/widgets/appBarWidgets/common_app_bar_widget.dart';
import 'package:accountech/widgets/textFieldWidgets/prefix_with_text_field_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:expandable/expandable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lottie/lottie.dart';
import '../../../common/color_class.dart';
import '../../../common/string_file.dart';
import '../../../widgets/commonWidget/delete_dialog.dart';
import '../../../widgets/textFieldWidgets/text_field_widget.dart';
import '../../../widgets/textWidgets/text_widget.dart';

class ManageBusinessSettingsScreen extends StatefulWidget {
  static String manageBusinessSettingsScreenRoute =
      "/ManageBusinessSettingsScreen";

  const ManageBusinessSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ManageBusinessSettingsScreen> createState() =>
      _ManageBusinessSettingsScreenState();
}

final ColorClass _colorClass = ColorClass();
final StringFile _stringFile = StringFile();
final CommonClass _commonClass = CommonClass();

class _ManageBusinessSettingsScreenState
    extends State<ManageBusinessSettingsScreen> {
  bool _haveGSTNumber = false;
  final BusinessController _businessController = BusinessController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _businessPhoneNumberController =
      TextEditingController();
  final TextEditingController _businessAddressController =
      TextEditingController();
  final TextEditingController _gstNumberController = TextEditingController();
  final TextEditingController _upiController = TextEditingController();
  final TextEditingController _paymentTermsController = TextEditingController();
  String _industryType = "";
  String _placeOfSupply = "";
  String _signatureImage = "";
  String _businessImage = "";
  bool _fetched = false;
  CroppedFile? _businessCroppedFile;

  @override
  void initState() {
    super.initState();
  }

  final List<String> _itemList = ["a", "a", "a"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(CommonClass.headerHeight),
            child: Container(
              color: _colorClass.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonAppBarWidget(
                    title: TextWidget(
                      text: "Manage Business Settings",
                      textStyle: _commonClass.getTextStyle(
                          20, _colorClass.blackColor, CommonClass.semiBold),
                    ),
                  ),
                ],
              ),
            )),
        resizeToAvoidBottomInset: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ExpandableTheme(
          data: ExpandableThemeData(
            iconColor: _colorClass.mainBrandMaterialColor,
            collapseIcon: FontAwesomeIcons.circleMinus,
            expandIcon: FontAwesomeIcons.circlePlus,
            useInkWell: true,
          ),
          child: FutureBuilder<dynamic>(
            future: _businessController.getBusinessProfile(),
            builder: (context, snapshot) {
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
                dynamic value = snapshot.data;

                if (value.status != null) {
                  if (value.status == 200 && value.data != null) {
                    if (!_fetched) {
                      _businessImage = value.data.businessLogo ?? "";
                      _businessNameController.text=value.data.businessName??"";
                      _businessPhoneNumberController.text=value.data.businessPhone.toString()??"";
                      _fetched = true;
                    }
                  }
                }
                return Container(
                  color:
                      _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: _commonClass.getScreenWidth(context),
                          child: Card(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          height: 120,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              clipBehavior: Clip.hardEdge,
                                              child: _businessCroppedFile ==
                                                      null
                                                  ? _businessImage.isEmpty
                                                      ? Image.asset(
                                                          _commonClass
                                                              .noImageAvailable,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.network(
                                                          _commonClass
                                                                  .assetURL +
                                                              _businessImage,
                                                          fit: BoxFit.cover,
                                                          loadingBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  Widget child,
                                                                  ImageChunkEvent?
                                                                      loadingProgress) {
                                                            if (loadingProgress ==
                                                                null) {
                                                              return child;
                                                            }

                                                            return Center(
                                                              child: SizedBox(
                                                                height: 100,
                                                                width: 100,
                                                                child: Lottie.asset(
                                                                    _commonClass
                                                                        .myLoader,
                                                                    fit: BoxFit
                                                                        .cover),
                                                              ),
                                                            );
                                                          },
                                                        )
                                                  : Image.file(
                                                      File(_businessCroppedFile!
                                                          .path),
                                                      fit: BoxFit.cover,
                                                    )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Material(
                                                  color: _colorClass
                                                      .mainBrandColor,
                                                  clipBehavior: Clip.hardEdge,
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  child: InkWell(
                                                    splashColor: _colorClass
                                                        .mainBrandColor,
                                                    onTap: () async {
                                                      FilePickerResult? result =
                                                          await FilePicker
                                                              .platform
                                                              .pickFiles(
                                                        type: FileType.custom,
                                                        allowedExtensions:
                                                            _commonClass
                                                                .allowedExtensions,
                                                      );

                                                      if (result != null) {
                                                        _businessCroppedFile =
                                                            await _commonClass
                                                                .getCroppedImage(
                                                                    result);
                                                        setState(() {});
                                                      } else {
                                                        _businessCroppedFile =
                                                            null;
                                                        // User canceled the picker
                                                      }
                                                    },
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10,
                                                                horizontal: 20),
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .upload,
                                                          color: _colorClass
                                                              .whiteColor,
                                                          size: 20,
                                                        )),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Material(
                                                  color: _colorClass.bgColor,
                                                  clipBehavior: Clip.hardEdge,
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  child: InkWell(
                                                    splashColor:
                                                        _colorClass.bgColor,
                                                    onTap: () {
                                                      setState(() {
                                                        _businessCroppedFile =
                                                            null;
                                                      });
                                                    },
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10,
                                                                horizontal: 10),
                                                        child: const Icon(
                                                          FontAwesomeIcons
                                                              .arrowRotateRight,
                                                          color:
                                                              Color(0xff69809a),
                                                          size: 20,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextWidget(
                                                text:
                                                    "Allowed JPG, GIF or PNG. Max size of 800K",
                                                overflow: TextOverflow.visible,
                                                textStyle:
                                                    _commonClass.getTextStyle(
                                                        10,
                                                        _colorClass.blackColor,
                                                        CommonClass.regular)),
                                          ],
                                        )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFieldWidget(
                                        textEditingController:
                                            _businessNameController,
                                        myTextInputAction: TextInputAction.next,
                                        maxLength: null,
                                        type: TextInputType.text,
                                        formatter: null,
                                        text: "Business Name",
                                        onTypeCallBack: (e) {}),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    PrefixWithTextFieldWidget(
                                        myTextInputAction: TextInputAction.next,
                                        textEditingController:
                                            _businessPhoneNumberController,
                                        maxLength: 10,
                                        type: TextInputType.number,
                                        formatter: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                        text: "Company Phone Number",
                                        onTypeCallBack: (e) {}),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    DropdownSearch<String>.multiSelection(
                                        popupProps: PopupPropsMultiSelection
                                            .modalBottomSheet(
                                          showSearchBox: true,
                                        ),
                                        items: const [
                                          "Retailer",
                                          "Wholesaler",
                                          "Distributor",
                                          "Manufacturer",
                                          "Services",
                                        ],
                                        onChanged: print,
                                      dropdownDecoratorProps:DropDownDecoratorProps(dropdownSearchDecoration:
                                            InputDecoration(
                                          labelStyle: TextStyle(
                                              color: _colorClass
                                                  .secondaryBrandColor),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  12, 7, 0, 0),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: _colorClass
                                                      .secondaryBrandColor,
                                                  width: 1)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: _colorClass
                                                      .secondaryBrandColor,
                                                  width: 1)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: _colorClass
                                                      .secondaryBrandColor,
                                                  width: 1)),
                                          labelText: "Business Type",
                                        )),
                                        selectedItems: const []),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    DropdownSearch<String>(
                                        popupProps:
                                            const PopupProps.modalBottomSheet(
                                          showSearchBox: true,
                                        ),
                                        items: const [
                                          "Agriculture",
                                          "Arts And Design",
                                          "Automotive",
                                          "Construction",
                                          "Consulting",
                                          "Dairy (Milk)",
                                          "Education",
                                        ],
                                        onChanged: print,
                                      dropdownDecoratorProps:DropDownDecoratorProps(dropdownSearchDecoration:
                                            InputDecoration(
                                          labelStyle: TextStyle(
                                              color: _colorClass
                                                  .secondaryBrandColor),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  12, 7, 0, 0),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: _colorClass
                                                      .secondaryBrandColor,
                                                  width: 1)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: _colorClass
                                                      .secondaryBrandColor,
                                                  width: 1)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: _colorClass
                                                      .secondaryBrandColor,
                                                  width: 1)),
                                          labelText: "Industry Type",
                                        )),
                                        selectedItem: "Agriculture"),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFieldWidget(
                                        myTextInputAction: TextInputAction.next,
                                        textEditingController:
                                            _businessAddressController,
                                        maxLength: null,
                                        type: TextInputType.text,
                                        formatter: null,
                                        text: "Business Address",
                                        onTypeCallBack: (e) {}),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        TextWidget(
                                          text: "Are You GST Registered?",
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.blackColor,
                                              CommonClass.medium),
                                        ),
                                        FlutterSwitch(
                                          activeColor:
                                              _colorClass.secondaryBrandColor,
                                          height: 20,
                                          toggleSize: 10,
                                          width: 40,
                                          value: _haveGSTNumber,
                                          onToggle: (val) {
                                            setState(() {
                                              _haveGSTNumber = val;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    _haveGSTNumber
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              TextFieldWidget(
                                                  myTextInputAction:
                                                      TextInputAction.next,
                                                  textEditingController:
                                                      _gstNumberController,
                                                  maxLength: null,
                                                  type: TextInputType.text,
                                                  formatter: null,
                                                  text: "GST Number",
                                                  onTypeCallBack: (e) {}),
                                            ],
                                          )
                                        : Container(),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    DropdownSearch<String>(
                                        popupProps:
                                            const PopupProps.modalBottomSheet(
                                          showSearchBox: true,
                                        ),
                                        items: const [
                                          "DATA 1",
                                          "DATA 2",
                                          "DATA 3",
                                        ],
                                        onChanged: print,
                                      dropdownDecoratorProps:DropDownDecoratorProps(dropdownSearchDecoration:
                                            InputDecoration(
                                          labelStyle: TextStyle(
                                              color: _colorClass
                                                  .secondaryBrandColor),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  12, 7, 0, 0),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: _colorClass
                                                      .secondaryBrandColor,
                                                  width: 1)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: _colorClass
                                                      .secondaryBrandColor,
                                                  width: 1)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: _colorClass
                                                      .secondaryBrandColor,
                                                  width: 1)),
                                          labelText: "Place Of Supply",
                                        )),
                                        selectedItem: "DATA 1"),
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          width: _commonClass.getScreenWidth(context),
                          child: Card(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(
                                        children: [
                                          TextWidget(
                                              text: "Bank Details",
                                              textStyle:
                                                  _commonClass.getTextStyle(
                                                      15,
                                                      _colorClass.blackColor,
                                                      CommonClass.bold)),
                                          const Spacer(),
                                          Material(
                                            color: _colorClass.mainBrandColor,
                                            clipBehavior: Clip.hardEdge,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            child: InkWell(
                                              splashColor:
                                                  _colorClass.mainBrandColor,
                                              onTap: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: (c) {
                                                      return StatefulBuilder(
                                                          builder: (context,
                                                              bottomSheetSetState) {
                                                        return const AddCardBottomSheet();
                                                      });
                                                    });
                                              },
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                                  child: TextWidget(
                                                      text: "+ Add Card",
                                                      textStyle: _commonClass
                                                          .getTextStyle(
                                                              12,
                                                              _colorClass
                                                                  .whiteColor,
                                                              CommonClass
                                                                  .semiBold))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _itemList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Slidable(
                                              key: GlobalKey(),
                                              endActionPane: ActionPane(
                                                motion: const ScrollMotion(),
                                                dismissible: DismissiblePane(
                                                    onDismissed: () {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (c) {
                                                        return StatefulBuilder(
                                                            builder: (context,
                                                                bottomSheetSetState) {
                                                          return  DeleteDialog(onDelete: (){},);
                                                        });
                                                      });
                                                }),
                                                children: [
                                                  SlidableAction(
                                                    onPressed: (e) {},
                                                    backgroundColor: _colorClass
                                                        .secondaryBrandColor,
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: Icons.edit,
                                                    label: _stringFile.edit,
                                                  ),
                                                  SlidableAction(
                                                    onPressed: (e) {
                                                      showModalBottomSheet(
                                                          context: context,
                                                          builder: (c) {
                                                            return StatefulBuilder(
                                                                builder: (context,
                                                                    bottomSheetSetState) {
                                                              return DeleteDialog(onDelete: (){},);
                                                            });
                                                          });
                                                    },
                                                    backgroundColor:
                                                        _colorClass.redColor,
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: Icons.delete,
                                                    label: _stringFile.delete,
                                                  ),
                                                ],
                                              ),
                                              child: Container(
                                                  width: _commonClass
                                                      .getScreenWidth(context),
                                                  decoration: BoxDecoration(
                                                      color: _colorClass
                                                          .transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                      border: Border.all(
                                                          color: _colorClass
                                                              .greyColor
                                                              .withAlpha(100))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            RotatedBox(
                                                              quarterTurns: 2,
                                                              child: SizedBox(
                                                                width: 30,
                                                                child: Opacity(
                                                                  opacity: 0.2,
                                                                  child: Lottie.asset(
                                                                      _commonClass
                                                                          .swipeLeft),
                                                                ),
                                                              ),
                                                            ),
                                                            //   Text("Swipe To Edit Or Delete"),
                                                            //   SizedBox(width: 10,),
                                                          ],
                                                        ),
                                                        Image.asset(_commonClass
                                                            .demoMasterCard),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextWidget(
                                                            text:
                                                                "Kaith Morrison",
                                                            textStyle: _commonClass
                                                                .getTextStyle(
                                                                    12,
                                                                    _colorClass
                                                                        .blackColor,
                                                                    CommonClass
                                                                        .semiBold)),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextWidget(
                                                            text:
                                                                "∗∗∗∗ ∗∗∗∗ ∗∗∗∗ 9856",
                                                            textStyle: _commonClass
                                                                .getTextStyle(
                                                                    12,
                                                                    _colorClass
                                                                        .blackColor,
                                                                    CommonClass
                                                                        .regular)),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextWidget(
                                                            text:
                                                                "Card expires at 12/26",
                                                            textStyle: _commonClass
                                                                .getTextStyle(
                                                                    12,
                                                                    _colorClass
                                                                        .blackColor,
                                                                    CommonClass
                                                                        .regular)),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          );
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFieldWidget(
                                        myTextInputAction: TextInputAction.next,
                                        textEditingController: _upiController,
                                        maxLines: true,
                                        maxLength: null,
                                        type: TextInputType.text,
                                        formatter: null,
                                        text: "UPI",
                                        onTypeCallBack: (e) {}),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFieldWidget(
                                        myTextInputAction: TextInputAction.done,
                                        textEditingController:
                                            _paymentTermsController,
                                        maxLength: null,
                                        type: TextInputType.text,
                                        formatter: null,
                                        text: "PAYMENT TERMS",
                                        onTypeCallBack: (e) {}),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextWidget(
                                        text: "Signature",
                                        textStyle: _commonClass.getTextStyle(
                                            12,
                                            _colorClass.blackColor,
                                            CommonClass.semiBold)),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          DottedBorder(
                                            color: _colorClass.mainBrandColor
                                                .withAlpha(200),
                                            strokeWidth: 1,
                                            dashPattern: const <double>[10, 2],
                                            child: Image.asset(
                                                _commonClass.demoSignature,
                                                height: 50,
                                                width: 100),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextWidget(
                                              text: "REMOVE",
                                              textStyle:
                                                  _commonClass.getTextStyle(
                                                      12,
                                                      _colorClass.redColor,
                                                      CommonClass.semiBold)),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          width: _commonClass.getScreenWidth(context),
                          child: Card(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: TextWidget(
                                          text: "All Company's",
                                          textStyle: _commonClass.getTextStyle(
                                              15,
                                              _colorClass.blackColor,
                                              CommonClass.bold)),
                                    ),
                                    ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _itemList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Slidable(
                                              key: GlobalKey(),
                                              endActionPane: ActionPane(
                                                motion: const ScrollMotion(),
                                                dismissible: DismissiblePane(
                                                    onDismissed: () {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (c) {
                                                        return StatefulBuilder(
                                                            builder: (context,
                                                                bottomSheetSetState) {
                                                          return DeleteDialog(onDelete: (){},);
                                                        });
                                                      });
                                                }),
                                                children: [
                                                  SlidableAction(
                                                    onPressed: (e) {},
                                                    backgroundColor: _colorClass
                                                        .secondaryBrandColor,
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: Icons.edit,
                                                    label: _stringFile.edit,
                                                  ),
                                                  SlidableAction(
                                                    onPressed: (e) {
                                                      showModalBottomSheet(
                                                          context: context,
                                                          builder: (c) {
                                                            return StatefulBuilder(
                                                                builder: (context,
                                                                    bottomSheetSetState) {
                                                              return DeleteDialog(onDelete: (){},);
                                                            });
                                                          });
                                                    },
                                                    backgroundColor:
                                                        _colorClass.redColor,
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: Icons.delete,
                                                    label: _stringFile.delete,
                                                  ),
                                                ],
                                              ),
                                              child: Container(
                                                  width: _commonClass
                                                      .getScreenWidth(context),
                                                  decoration: BoxDecoration(
                                                      color: _colorClass
                                                          .transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                      border: Border.all(
                                                          color: _colorClass
                                                              .greyColor
                                                              .withAlpha(100))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            RotatedBox(
                                                              quarterTurns: 2,
                                                              child: SizedBox(
                                                                width: 30,
                                                                child: Opacity(
                                                                  opacity: 0.2,
                                                                  child: Lottie.asset(
                                                                      _commonClass
                                                                          .swipeLeft),
                                                                ),
                                                              ),
                                                            ),
                                                            //   Text("Swipe To Edit Or Delete"),
                                                            //   SizedBox(width: 10,),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 120,
                                                              height: 120,
                                                              child: Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  ),
                                                                  clipBehavior: Clip
                                                                      .hardEdge,
                                                                  child: Image.asset(
                                                                      _commonClass
                                                                          .demoUser)),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                                child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                TextWidget(
                                                                    text:
                                                                        "Morrison PVT. LTD.",
                                                                    textStyle: _commonClass.getTextStyle(
                                                                        12,
                                                                        _colorClass
                                                                            .blackColor,
                                                                        CommonClass
                                                                            .bold)),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                TextWidget(
                                                                    text:
                                                                        "Agriculture",
                                                                    textStyle: _commonClass.getTextStyle(
                                                                        12,
                                                                        _colorClass
                                                                            .blackColor,
                                                                        CommonClass
                                                                            .semiBold)),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                TextWidget(
                                                                    text:
                                                                        "(+91) 983 354 7756",
                                                                    textStyle: _commonClass.getTextStyle(
                                                                        12,
                                                                        _colorClass
                                                                            .blackColor,
                                                                        CommonClass
                                                                            .regular)),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                              ],
                                                            ))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          );
                                        }),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class AddCardBottomSheet extends StatefulWidget {
  const AddCardBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddCardBottomSheet> createState() => _AddCardBottomSheetState();
}

bool _saveCard = false;

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                          text: "Add New Card",
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
              Divider(
                height: 1,
                color: _colorClass.bgColor,
                thickness: 1,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldWidget(
                            maxLength: null,
                            type: TextInputType.number,
                            formatter: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            text: "CARD NUMBER",
                            onTypeCallBack: (e) {}),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                            maxLength: null,
                            type: TextInputType.text,
                            formatter: null,
                            text: "NAME",
                            onTypeCallBack: (e) {}),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFieldWidget(
                                  maxLength: null,
                                  type: TextInputType.text,
                                  formatter: null,
                                  text: "EXP.DATE",
                                  onTypeCallBack: (e) {}),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFieldWidget(
                                  maxLength: null,
                                  type: TextInputType.number,
                                  formatter: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  text: "CVV CODE",
                                  onTypeCallBack: (e) {}),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextWidget(
                              text: "Save card for future billing?",
                              textStyle: _commonClass.getTextStyle(15,
                                  _colorClass.blackColor, CommonClass.medium),
                            ),
                            FlutterSwitch(
                              activeColor: _colorClass.secondaryBrandColor,
                              height: 20,
                              toggleSize: 10,
                              width: 40,
                              value: _saveCard,
                              onToggle: (val) {
                                setState(() {
                                  _saveCard = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: _colorClass.mainBrandColor,
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(2),
              child: InkWell(
                splashColor: _colorClass.mainBrandColor,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                    child: TextWidget(
                        text: "SUBMIT",
                        textStyle: _commonClass.getTextStyle(
                            15, _colorClass.whiteColor, CommonClass.semiBold))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
