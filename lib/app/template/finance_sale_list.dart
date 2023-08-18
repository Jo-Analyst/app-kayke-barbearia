import 'package:flutter/material.dart';

import '../utils/convert_values.dart';

class FinanceSaleList extends StatelessWidget {
  const FinanceSaleList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> productsSold = [
      {"name": "Gel Azul", "quantity": 5, "price": 50.00},
      {"name": "Gel Preto", "quantity": 15, "price": 150.00},
      {"name": "Máquina de barbear", "quantity": 10, "price": 900.00},
      {"name": "Gel Azul", "quantity": 5, "price": 50.00},
      {"name": "Gel Preto", "quantity": 15, "price": 150.00},
      {"name": "Máquina de barbear", "quantity": 10, "price": 900.00},
    ];

    return Scrollbar(
      child: productsSold.isEmpty
          ? const Center(
              child: Text(
                "Não há vendas adicionado neste mês.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView(
              shrinkWrap: true,
              children: productsSold.map(
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
                                    product["name"],
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
