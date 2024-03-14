import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/color_class.dart';
import '../../common/common_class.dart';
import '../textWidgets/text_widget.dart';

class DeleteDialog extends StatefulWidget {

  final Function onDelete;
  const DeleteDialog(  {Key? key, required this.onDelete})
      : super(key: key);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

final CommonClass _commonClass = CommonClass();
final ColorClass _colorClass = ColorClass();
class _DeleteDialogState extends State<DeleteDialog> {
  final _controller = CountDownController();

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
                          text: "Delete ?",
                          textStyle: _commonClass.getTextStyle(
                              15, _colorClass.blackColor, CommonClass.bold)),
                    ),
                    InkWell(
                        onTap: () {
                          widget.onDelete();
                          // Navigator.pop(context);
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
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                    text: "Automatically delete in",
                    textStyle: _commonClass.getTextStyle(
                        15, _colorClass.blackColor, CommonClass.bold)),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: CountDownProgressIndicator(
                    labelTextStyle: const TextStyle(fontSize: 15),
                    controller: _controller,
                    valueColor: _colorClass.secondaryBrandColor,
                    backgroundColor: _colorClass.bgColor,
                    initialPosition: 0,
                    duration: 5,
                    timeFormatter: (seconds) {
                      return Duration(seconds: seconds)
                          .toString()
                          .split('.')[0]
                          .split(":")[2]
                          .padLeft(0, '.');
                    },
                    timeTextStyle: const TextStyle(fontSize: 35),
                    text: 'Seconds',
                    onComplete: () {
                      widget.onDelete();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: _colorClass.redColor,
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(2),
              child: InkWell(
                splashColor: _colorClass.redColor,
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    alignment: Alignment.center,
                    padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                    child: TextWidget(
                        text: "Cancel",
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
