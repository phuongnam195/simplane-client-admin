import 'package:flutter/material.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/util/date_time_utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

mixin DatePickerFunction {
  DateTime fromDate = DateTimeUtils.today().subtract(const Duration(days: 30));
  DateTime toDate = DateTimeUtils.today().add(const Duration(days: 30));

  onDateChanged();

  showDateFilterDialog(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              S.current.pick_duration,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SizedBox(
              height: screenWidth * 0.3,
              width: screenHeight * 0.7,
              child: SfDateRangePicker(
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange: PickerDateRange(fromDate, toDate),
                showActionButtons: true,
                onSubmit: (Object? value) {
                  if (value is PickerDateRange) {
                    fromDate = value.startDate!;
                    toDate = value.endDate ?? fromDate;
                    onDateChanged();
                  }
                  Navigator.pop(context);
                },
                onCancel: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
        });
  }
}
