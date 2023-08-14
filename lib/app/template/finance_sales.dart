import 'package:flutter/material.dart';

import '../utils/convert_values.dart';

class FinanceSales extends StatefulWidget {
  const FinanceSales({super.key});

  @override
  State<FinanceSales> createState() => _FinanceSalesState();
}

class _FinanceSalesState extends State<FinanceSales> {
  final List<Map<String, dynamic>> productsSold = [
    {"name": "Gel Azul", "quantity": 5, "price": 50.00},
    {"name": "Gel Preto", "quantity": 15, "price": 150.00},
    {"name": "maquina de barbear", "quantity": 10, "price": 900.00},
    {"name": "Gel Azul", "quantity": 5, "price": 50.00},
    {"name": "Gel Preto", "quantity": 15, "price": 150.00},
    {"name": "maquina de barbear", "quantity": 10, "price": 900.00},
    {"name": "Gel Azul", "quantity": 5, "price": 50.00},
    {"name": "Gel Preto", "quantity": 15, "price": 150.00},
    {"name": "maquina de barbear", "quantity": 10, "price": 900.00},
    {"name": "Gel Azul", "quantity": 5, "price": 50.00},
    {"name": "Gel Preto", "quantity": 15, "price": 150.00},
    {"name": "maquina de barbear", "quantity": 10, "price": 900.00},
    {"name": "Gel Azul", "quantity": 5, "price": 50.00},
    {"name": "Gel Preto", "quantity": 15, "price": 150.00},
    {"name": "maquina de barbear", "quantity": 10, "price": 900.00},
    {"name": "Gel Azul", "quantity": 5, "price": 50.00},
    {"name": "Gel Preto", "quantity": 15, "price": 150.00},
    {"name": "maquina de barbear", "quantity": 10, "price": 900.00},
    {"name": "Gel Azul", "quantity": 5, "price": 50.00},
    {"name": "Gel Preto", "quantity": 15, "price": 150.00},
    {"name": "maquina de barbear", "quantity": 10, "price": 900.00},
    {"name": "Gel Azul", "quantity": 5, "price": 50.00},
    {"name": "Gel Preto", "quantity": 15, "price": 150.00},
    {"name": "maquina de barbear", "quantity": 10, "price": 900.00},
    {"name": "Gel Azul", "quantity": 5, "price": 50.00},
    {"name": "Gel Preto", "quantity": 15, "price": 150.00},
    {"name": "maquina de barbear", "quantity": 10, "price": 900.00},
    {"name": "Gel Azul", "quantity": 5, "price": 50.00},
    {"name": "Gel Preto", "quantity": 15, "price": 150.00},
    {"name": "maquina de barbear", "quantity": 10, "price": 900.00},
    {"name": "Gel Azul", "quantity": 5, "price": 50.00},
    {"name": "Gel Preto", "quantity": 15, "price": 150.00},
    {"name": "maquina de barbear", "quantity": 10, "price": 900.00},
    {"name": "Gel Azul", "quantity": 5, "price": 50.00},
    {"name": "Gel Preto", "quantity": 15, "price": 150.00},
    {"name": "maquina de barbear", "quantity": 10, "price": 900.00},
    {"name": "Gel Azul", "quantity": 5, "price": 50.00},
    {"name": "Gel Preto", "quantity": 15, "price": 150.00},
    {"name": "maquina de barbear", "quantity": 10, "price": 900.00},
    {"name": "Gel Azul", "quantity": 5, "price": 50.00},
    {"name": "Gel Preto", "quantity": 15, "price": 150.00},
    {"name": "maquina de barbear", "quantity": 10, "price": 900.00},
    {"name": "Gel Azul", "quantity": 5, "price": 50.00},
    {"name": "Gel Preto", "quantity": 15, "price": 150.00},
    {"name": "maquina de barbear", "quantity": 10, "price": 900.00},
  ]; // produtos vendidos

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            numberFormat.format(3000),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const Text(
            "Total em venda neste mês",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView(
              shrinkWrap: true,
              children: productsSold.map((product) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          product["name"],
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 8,
                        child: Text(
                          product["quantity"].toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            numberFormat.format(product["price"]),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          
        ],
      ),
    );
  }
}
