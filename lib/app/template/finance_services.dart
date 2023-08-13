import 'package:flutter/material.dart';

import '../utils/convert_values.dart';

class FinanceServices extends StatefulWidget {
  const FinanceServices({super.key});

  @override
  State<FinanceServices> createState() => _FinanceServicesState();
}

class _FinanceServicesState extends State<FinanceServices> {
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
                    numberFormat.format(5000),
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