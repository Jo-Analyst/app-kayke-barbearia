import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/show_calendar_picker.dart';
import 'package:app_kayke_barbearia/app/utils/show_message.dart';
import 'package:flutter/material.dart';

class FieldForPeriod extends StatefulWidget {
  final Function(
    DateTime dateInitial,
    DateTime dateFinal,
  ) onGetDates;
  final DateTime dateInitial;
  final DateTime dateFinal;
  const FieldForPeriod({
    required this.dateInitial,
    required this.dateFinal,
    required this.onGetDates,
    super.key,
  });

  @override
  State<FieldForPeriod> createState() => _FieldForPeriodState();
}

class _FieldForPeriodState extends State<FieldForPeriod> {
  DateTime dateSelectedInitial = DateTime.now();
  DateTime dateSelectedFinal = DateTime.now();

  @override
  void initState() {
    super.initState();
    dateSelectedInitial = widget.dateInitial;
    dateSelectedFinal = widget.dateFinal;

    widget.onGetDates(
      dateSelectedInitial,
      dateSelectedFinal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 13,
        bottom: 13,
        left: 13,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () async {
              final date = await showCalendarPicker(
                context,
                dateSelectedInitial,
                null,
              );

              if (date.isAfter(dateSelectedFinal)) {
                showToast(
                  message: "A data inicial deve ser menor que a data final.",
                  isInformation: false,
                );
              }

              setState(() {
                dateSelectedInitial = date.isAfter(dateSelectedFinal)
                    ? dateSelectedInitial
                    : date;
              });

              widget.onGetDates(
                dateSelectedInitial,
                dateSelectedFinal,
              );
            },
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.calendar_month_outlined,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Data inicial",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      dateFormat4.format(dateSelectedInitial),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              DateTime date = await showCalendarPicker(
                context,
                dateSelectedFinal,
                null,
              );

              if (date.isBefore(dateSelectedInitial)) {
                showToast(
                    message: "A data final deve ser maior que a data inicial.",
                    isInformation: false);
                return;
              }

              setState(() {
                dateSelectedFinal = date.isBefore(dateSelectedInitial)
                    ? dateSelectedFinal
                    : date;
              });

              widget.onGetDates(
                dateSelectedInitial,
                dateSelectedFinal,
              );
            },
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Data final",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      dateFormat4.format(dateSelectedFinal),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.calendar_month_outlined,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
