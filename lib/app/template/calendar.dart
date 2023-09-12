import 'package:flutter/material.dart';

import '../utils/convert_values.dart';
import '../utils/show_calendar_picker.dart';

class Calendar extends StatefulWidget {
  final Function(DateTime value) onSelected;
  final DateTime dateInitial;
  const Calendar({
    required this.dateInitial,
    required this.onSelected,
    super.key,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime dateSelected;
  @override
  initState() {
    super.initState();
    dateSelected = widget.dateInitial;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          dateSelected = await showCalendarPicker(context, dateSelected);
          widget.onSelected(dateSelected);
          setState(() {});
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                dateFormat2.format(dateSelected),
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Icon(
              Icons.calendar_month_outlined,
              size: 35,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
