import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

class CashFlowPage extends StatefulWidget {
  const CashFlowPage({super.key});

  @override
  State<CashFlowPage> createState() => _CashFlowPageState();
}

class _CashFlowPageState extends State<CashFlowPage> {
  DateTime dateSelected = DateTime.now();
  List<bool> containerButton = [false, false];

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

  changeContainerButton(int index) {
    setState(() {
      for (int i = 0; i < containerButton.length; i++) {
        containerButton[i] = false;
      }
      containerButton[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
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
          padding: const EdgeInsets.symmetric(vertical: 8),
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
          color: Colors.indigo.withOpacity(.1),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => changeContainerButton(0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 1,
                    ),
                    color: containerButton[0]
                        ? Theme.of(context).primaryColor
                        : null,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        numberFormat.format(50),
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w400,
                            color: containerButton[0]
                                ? Colors.white
                                : Colors.green),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Total Venda",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color:
                              containerButton[0] ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => changeContainerButton(1),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 1,
                    ),
                    color: containerButton[1]
                        ? Theme.of(context).primaryColor
                        : null,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        numberFormat.format(250),
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w400,
                          color:
                              containerButton[1] ? Colors.white : Colors.green,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Total Serviço",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color:
                              containerButton[1] ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
