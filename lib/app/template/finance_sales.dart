import 'package:app_kayke_barbearia/app/template/payment.dart';
import 'package:flutter/material.dart';

import '../utils/convert_values.dart';
import 'finance_sale_list.dart';

class FinanceSales extends StatefulWidget {
  final double valueTotal;
  final List<Map<String, dynamic>> itemsSales;
  final List<Map<String, dynamic>> itemsPaymentsSales;
  const FinanceSales({
    required this.valueTotal,
    required this.itemsSales,
    required this.itemsPaymentsSales,
    super.key,
  });

  @override
  State<FinanceSales> createState() => _FinanceSalesState();
}

class _FinanceSalesState extends State<FinanceSales> {
  @override
  initState() {
    super.initState();
    print(widget.itemsPaymentsSales);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            numberFormat.format(widget.valueTotal),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const Text(
            "Total das vendas",
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
              "Vendas:",
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
            height: 200,
            child: FinanceSaleList(
              itemsSale: widget.itemsSales,
            ),
          ),
          Divider(color: Theme.of(context).primaryColor),
          Payment(itemsPaymentsSales: widget.itemsPaymentsSales),
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
                Column(
                  children: [
                    Text(
                      "R\$ 500,00",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.indigo,
                      ),
                    ),
                    Text(
                      "Lucro",
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
