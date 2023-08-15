import 'package:flutter/material.dart';

import '../utils/convert_values.dart';

class FinanceSpending extends StatefulWidget {
  const FinanceSpending({super.key});

  @override
  State<FinanceSpending> createState() => _FinanceSpendingState();
}

class _FinanceSpendingState extends State<FinanceSpending> {
  // PrimaryScrollController _controller = PrimaryScrollController();
  final List<Map<String, dynamic>> servicesProvided = [
    {"name_product": "Lâmina", "quantity": 5, "price": 15.00},
    {"name_product": "Escova", "quantity": 10, "price": 20.00},
    {"name_product": "Conta de água", "quantity": 10, "price": 100.00},
    {"name_product": "Aluguel", "quantity": 10, "price": 250.00},
  ]; // produtos vendidos

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            numberFormat.format(135),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const Text(
            "Total em gastos da barberia neste mês",
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
              "Gastos:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Divider(color: Theme.of(context).primaryColor),
          Container(
            color: const Color.fromARGB(17, 63, 81, 181),
            margin: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height - 450,
            child: servicesProvided.isEmpty
                ? const Center(
                    child: Text(
                      "Não há gastos adicionado neste mês.",
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
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          product["name_product"],
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        child: Text(
                                          product["quantity"].toString(),
                                          style: const TextStyle(fontSize: 20),
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
        ],
      ),
    );
  }
}
