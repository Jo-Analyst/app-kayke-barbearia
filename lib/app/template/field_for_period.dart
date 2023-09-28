import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/show_calendar_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/content_message.dart';
import '../utils/snackbar.dart';

class FieldForPeriod extends StatefulWidget {
  final Function(DateTime dateInitial, DateTime dateFinal,) onGetDates;
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

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color, 3000);
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
              );

              if (date.isAfter(dateSelectedFinal)) {
                showMessage(
                  const ContentMessage(
                    title: "A data inicial deve ser menor que a data final.",
                    icon: FontAwesomeIcons.circleExclamation,
                  ),
                  Colors.orange,
                );
                return;
              }

              setState(() {
                dateSelectedInitial = date;
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
              );

              if (date.isBefore(dateSelectedInitial)) {
                showMessage(
                  const ContentMessage(
                    title: "A data final deve ser maior que a data inicial.",
                    icon: FontAwesomeIcons.circleExclamation,
                  ),
                  Colors.orange,
                );
                return;
              }

              setState(() {
                dateSelectedFinal = date;
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
