import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/show_calendar_picker.dart';
import 'package:flutter/material.dart';

class FieldForPeriod extends StatefulWidget {
  const FieldForPeriod({super.key});

  @override
  State<FieldForPeriod> createState() => _FieldForPeriodState();
}

class _FieldForPeriodState extends State<FieldForPeriod> {
  DateTime dateSelectedInitial = DateTime.now();
  DateTime dateSelectedFinal = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  dateSelectedInitial = await showCalendarPicker(
                    context,
                    dateSelectedInitial,
                  );
                  setState(() {});
                },
                icon: Icon(
                  Icons.calendar_month_outlined,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                dateFormat1.format(dateSelectedInitial),
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                dateFormat1.format(dateSelectedFinal),
                style: const TextStyle(fontSize: 18),
              ),
              IconButton(
                onPressed: () async {
                  dateSelectedFinal = await showCalendarPicker(
                    context,
                    dateSelectedFinal,
                  );
                  setState(() {});
                },
                icon: Icon(
                  Icons.calendar_month_outlined,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
