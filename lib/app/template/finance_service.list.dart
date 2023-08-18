import 'package:flutter/material.dart';

import '../utils/convert_values.dart';

class FinanceServiceList extends StatelessWidget {
  const FinanceServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> servicesProvided = [
      {"description": "Cortes", "quantity": 5, "price": 75.00},
      {"description": "Barbear", "quantity": 10, "price": 120.00},
      {"description": "Pezinho ", "quantity": 10, "price": 100.00},
    ];

    return Scrollbar(
      child: servicesProvided.isEmpty
          ? const Center(
              child: Text(
                "Não há serviços adicionado neste mês.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView(
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
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    product["description"],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width / 8,
                                  child: Text(
                                    product["quantity"].toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Text(
                                    numberFormat.format(product["price"]),
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
    );
  }
}
