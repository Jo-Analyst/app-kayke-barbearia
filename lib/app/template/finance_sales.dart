import 'package:app_kayke_barbearia/app/template/payment.dart';
import 'package:flutter/material.dart';

import '../controllers/finance_sale_values.dart';
import '../utils/convert_values.dart';
import 'finance_sale_list.dart';

class FinanceSales extends StatelessWidget {
  final FinancesSalesValues financesSalesValues;
  const FinanceSales({
    required this.financesSalesValues,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            numberFormat.format(financesSalesValues.valueTotalSale),
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
              itemsSale: financesSalesValues.itemsSales,
            ),
          ),
          Divider(color: Theme.of(context).primaryColor),
          Payment(
              itemsPaymentsSales:
                  financesSalesValues.itemsPaymentsSales),
          const SizedBox(height: 20),
          Container(
            color: Colors.indigo.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      numberFormat
                          .format(financesSalesValues.valueReceivable),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                    const Text(
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
                      numberFormat.format(financesSalesValues.valuePaid),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                    const Text(
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
                      numberFormat.format(financesSalesValues.profit),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.indigo,
                      ),
                    ),
                    const Text(
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
