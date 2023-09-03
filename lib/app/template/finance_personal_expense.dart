import 'package:flutter/material.dart';

import '../utils/convert_values.dart';

class FinancePersonalExpense extends StatefulWidget {
  const FinancePersonalExpense({super.key});

  @override
  State<FinancePersonalExpense> createState() => _FinancePersonalExpense();
}

class _FinancePersonalExpense extends State<FinancePersonalExpense> {
  // PrimaryScrollController _controller = PrimaryScrollController();
  final List<Map<String, dynamic>> servicesProvided = [
    {"name_product": "Camisa", "quantity": 5, "price": 15.00},
    {"name_product": "Salgadão", "quantity": 10, "price": 25.00},
    {"name_product": "Bala", "quantity": 10, "price": 1.00},
    {"name_product": "Bermuda", "quantity": 2, "price": 80.00},
  ]; // produtos vendidos

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            numberFormat.format(121),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const Text(
            "Total das despesas pessoais",
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
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Text(
                                            product["name_product"],
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          child: Text(
                                            product["quantity"].toString(),
                                            style:
                                                const TextStyle(fontSize: 20),
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
        ],
      ),
    );
  }
}
