import 'package:flutter/material.dart';

import '../utils/convert_values.dart';

class FinanceSales extends StatefulWidget {
  const FinanceSales({super.key});

  @override
  State<FinanceSales> createState() => _FinanceSalesState();
}

class _FinanceSalesState extends State<FinanceSales> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 + 100,
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Lucro Total",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    numberFormat.format(3000),
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}