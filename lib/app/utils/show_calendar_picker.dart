import 'package:flutter/material.dart';

Future<DateTime> showCalendarPicker(
    BuildContext context, DateTime dateSelected, DateTime? firstDate) async {
  final date = await showDatePicker(
    context: context,
    initialDate: dateSelected,
    firstDate: firstDate ?? DateTime(2014),
    lastDate: DateTime.now(),
  );

  return date ?? dateSelected;
}
