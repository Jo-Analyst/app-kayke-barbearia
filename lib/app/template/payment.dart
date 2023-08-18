import 'package:flutter/material.dart';

import '../utils/convert_values.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> payments = [
      {
        "icon": const Icon(
          Icons.pix,
          color: Colors.green,
        ),
        "name": "Pix",
        "quantity": 2,
        "value": 100,
      },
      {
        "icon": const Icon(
          Icons.credit_card,
          color: Colors.purple,
        ),
        "name": "Cartão de crédito",
        "quantity": 3,
        "value": 150
      },
      {
        "icon": const Icon(
          Icons.credit_card,
          color: Colors.purple,
        ),
        "name": "Cartão de débito",
        "quantity": 4,
        "value": 200
      },
      {
        "icon": const Icon(
          Icons.attach_money,
          color: Colors.green,
        ),
        "name": "Dinheiro",
        "quantity": 5,
        "value": 250
      },
      // {
      //   "icon": const Icon(
      //     Icons.money_off,
      //     color: Colors.red,
      //   ),
      //   "name": "Fiado",
      //   "quantity": 2,
      //   "value": 100
      // },
    ];

    return Visibility(
      visible: payments.isNotEmpty,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: const Text(
              "Pagamentos:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Divider(color: Theme.of(context).primaryColor),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: payments.map(
                (payment) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width / 2,
                          child: Row(
                            children: [
                              payment["icon"] ?? const Text(""),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  payment["name"],
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width / 8,
                          child: Text(
                            payment["quantity"].toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              numberFormat.format(payment["value"]),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
