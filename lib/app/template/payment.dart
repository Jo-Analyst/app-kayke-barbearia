import 'package:flutter/material.dart';

import '../utils/convert_values.dart';

class Payment extends StatefulWidget {
  final List<Map<String, dynamic>> itemsPaymentsSales;
  const Payment({
    required this.itemsPaymentsSales,
    super.key,
  });

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  List<Map<String, dynamic>> payments = [
    // {
    //   "icon": const Icon(
    //     Icons.pix,
    //     color: Colors.green,
    //     size: 30,
    //   ),
    //   "name": "Pix",
    //   "quantity": 2,
    //   "value": 100,
    // },
    // {
    //   "icon": const Icon(
    //     Icons.credit_card,
    //     color: Colors.purple,
    //     size: 30,
    //   ),
    //   "name": "Cartão de crédito",
    //   "quantity": 3,
    //   "value": 150
    // },
    // {
    //   "icon": const Icon(
    //     Icons.credit_card,
    //     color: Colors.purple,
    //     size: 30,
    //   ),
    //   "name": "Cartão de débito",
    //   "quantity": 4,
    //   "value": 200
    // },
    // {
    //   "icon": const Icon(
    //     Icons.monetization_on,
    //     color: Colors.green,
    //     size: 30,
    //   ),
    //   "name": "Dinheiro",
    //   "quantity": 5,
    //   "value": 250
    // },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.itemsPaymentsSales.isNotEmpty,
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
              children: widget.itemsPaymentsSales.map(
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
                                  payment["specie"],
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
