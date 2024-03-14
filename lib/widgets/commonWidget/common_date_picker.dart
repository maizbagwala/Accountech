import 'package:accountech/common/color_class.dart';
import 'package:accountech/common/common_class.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CommonDatePicker extends StatefulWidget {
  final Function onDateSelect;
  final String selectedDate;

  const CommonDatePicker(
      {Key? key, required this.onDateSelect, required this.selectedDate})
      : super(key: key);

  @override
  State<CommonDatePicker> createState() => _CommonDatePickerState();
}

class _CommonDatePickerState extends State<CommonDatePicker> {
  final ColorClass _colorClass = ColorClass();
  String _dateSelected = "";

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        _dateSelected = DateFormat("d-M-yyyy").format(args.value).toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SfDateRangePicker(
        onCancel: () {
          Navigator.pop(context);
        },
        onSubmit: (value) {
          widget.onDateSelect(_dateSelected);
          Navigator.pop(context);
        },
        maxDate: DateTime.now(),
        backgroundColor:
            _colorClass.mainBrandColor.withAlpha(CommonClass.bgAlpha),
        onSelectionChanged: _onSelectionChanged,
        selectionMode: DateRangePickerSelectionMode.single,
        selectionColor: _colorClass.mainBrandColor,
        showTodayButton: false,
        showActionButtons: true,
        initialSelectedRange: null,
        initialDisplayDate: widget.selectedDate.isEmpty
            ? null
            : DateFormat("d-M-yyyy").parse(widget.selectedDate),
        initialSelectedDate: widget.selectedDate.isEmpty
            ? null
            : DateFormat("d-M-yyyy").parse(widget.selectedDate),
      ),
    );
  }
}
