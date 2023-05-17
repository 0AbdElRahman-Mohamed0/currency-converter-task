import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Constants {
  static PickerDateRange? showDateDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: SfDateRangePicker(
          maxDate: DateTime.now(),
          onSelectionChanged: (range) {
            final PickerDateRange test = range.value;

            print(test.startDate);
          },
          selectionMode: DateRangePickerSelectionMode.range,
        ),
      ),
    );
  }
}
