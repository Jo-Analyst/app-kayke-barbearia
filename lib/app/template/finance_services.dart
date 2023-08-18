import 'package:app_kaike_barbearia/app/template/finance_service.list.dart';
import 'package:app_kaike_barbearia/app/template/payment.dart';
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
              child: const FinanceServiceList(),
            ),
          ),
          Divider(color: Theme.of(context).primaryColor),
          const Payment(),
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
