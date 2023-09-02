import 'package:flutter/material.dart';

import '../utils/convert_values.dart';

class Calendar extends StatefulWidget {
  final Function(DateTime value) onSelected;
  final DateTime? dateInitial;
  const Calendar({
    this.dateInitial,
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
    dateSelected = widget.dateInitial ?? DateTime.now();
  }

  showCalendarPicker() {
    showDatePicker(
      context: context,
      initialDate: widget.dateInitial!,
      firstDate: DateTime(2014),
      lastDate: DateTime.now(),
    ).then(
      (date) => setState(() {
        if (date != null) {
          dateSelected = date;
          widget.onSelected(dateSelected);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => showCalendarPicker(),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              dateFormat2.format(dateSelected),
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        IconButton(
          onPressed: () => showCalendarPicker(),
          icon: Icon(
            Icons.calendar_month_outlined,
            size: 35,
            color: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
