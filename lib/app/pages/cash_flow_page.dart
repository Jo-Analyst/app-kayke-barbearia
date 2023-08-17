import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

class CashFlowPage extends StatefulWidget {
  const CashFlowPage({super.key});

  @override
  State<CashFlowPage> createState() => _CashFlowPageState();
}

class _CashFlowPageState extends State<CashFlowPage> {
  DateTime dateSelected = DateTime.now();

  showCalendarPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2014),
      lastDate: DateTime.now(),
    ).then(
      (date) => setState(() {
        if (date != null) {
          dateSelected = date;
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.indigo.withOpacity(.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                dateFormat2.format(dateSelected),
                style: const TextStyle(fontSize: 20),
              ),
              IconButton(
                onPressed: () => showCalendarPicker(),
                icon: Icon(
                  Icons.calendar_month_outlined,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const Text(
                "Saldo",
                style: TextStyle(fontSize: 25),
              ),
              Text(
                numberFormat.format(300),
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.green,
                ),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          color: Colors.indigo.withOpacity(.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    numberFormat.format(50),
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                      color: Colors.green,
                    ),
                  ),
                  const Text(
                    "Total Venda",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    numberFormat.format(250),
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                      color: Colors.green,
                    ),
                  ),
                  const Text(
                    "Total Serviço",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
