import 'package:flutter/material.dart';

import '../utils/convert_values.dart';

class FinanceServices extends StatefulWidget {
  const FinanceServices({super.key});

  @override
  State<FinanceServices> createState() => _FinanceServicesState();
}

class _FinanceServicesState extends State<FinanceServices> {
  // PrimaryScrollController _controller = PrimaryScrollController();
  final List<Map<String, dynamic>> servicesProvided = [
    {"description": "Cortes", "quantity": 5, "price": 75.00},
    {"description": "Barbear", "quantity": 10, "price": 120.00},
    {"description": "Pezinho ", "quantity": 10, "price": 100.00},
  ]; // produtos vendidos

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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            numberFormat.format(295),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const Text(
            "Total dos serviços",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Divider(color: Theme.of(context).primaryColor),
          Container(
            margin: const EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: const Text(
              "Serviços:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Divider(color: Theme.of(context).primaryColor),
          Expanded(
            child: Container(
              color: const Color.fromARGB(17, 63, 81, 181),
              margin: const EdgeInsets.all(10),
              height: 200,
              child: servicesProvided.isEmpty
                  ? const Center(
                      child: Text(
                        "Não há serviços adicionado neste mês.",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : Scrollbar(
                      child: ListView(
                        shrinkWrap: true,
                        children: servicesProvided.map(
                          (product) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 15,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            width:
                                                MediaQuery.of(context).size.width /
                                                    2,
                                            child: Text(
                                              product["description"],
                                              style: const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width:
                                                MediaQuery.of(context).size.width /
                                                    8,
                                            child: Text(
                                              product["quantity"].toString(),
                                              style: const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: Text(
                                              numberFormat
                                                  .format(product["price"]),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
            ),
          ),
          Divider(color: Theme.of(context).primaryColor),
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
          const SizedBox(height: 20),
          Container(
            color: Colors.indigo.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: const EdgeInsets.only(bottom: 10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "R\$ 100,00",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "A receber",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "R\$ 700,00",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      "Concluído",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
