import 'package:app_kayke_barbearia/app/controllers/personal_expense_balance_values.dart';
import 'package:flutter/material.dart';

import '../utils/convert_values.dart';

class FinancialReportPersonalExpense extends StatefulWidget {
  final PersonalExpenseBalanceValues personalExpenseBalanceValues;

  const FinancialReportPersonalExpense({
    required this.personalExpenseBalanceValues,
    super.key,
  });

  @override
  State<FinancialReportPersonalExpense> createState() => _FinancePersonalExpense();
}

class _FinancePersonalExpense extends State<FinancialReportPersonalExpense> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            numberFormat.format(widget.personalExpenseBalanceValues.valueTotal),
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
            child: widget.personalExpenseBalanceValues.itemsPersonalExpense.isEmpty
                ? const Center(
                    child: Text(
                      "Não há gastos adicionado neste mês.",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : Scrollbar(
                    child: ListView(
                      shrinkWrap: true,
                      children: widget.personalExpenseBalanceValues.itemsPersonalExpense.map(
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
