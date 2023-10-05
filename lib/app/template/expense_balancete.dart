import 'package:app_kayke_barbearia/app/controllers/expense_balance_values.dart';
import 'package:app_kayke_barbearia/app/utils/loading.dart';
import 'package:flutter/material.dart';

import '../utils/convert_values.dart';

class ExpenseBalance extends StatelessWidget {
  final ExpenseBalanceValues expenseBalanceValues;
  final bool isLoading;
  final bool isSearchByPeriod;
  const ExpenseBalance({
    required this.isSearchByPeriod,
    required this.isLoading,
    required this.expenseBalanceValues,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isLoading
              ? loading(context, 30)
              : Text(
                  numberFormat.format(expenseBalanceValues.valueTotal),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
          const Text(
            "Total das despesas da barberia",
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
            child: isLoading
                ? Center(child: loading(context, 30))
                : expenseBalanceValues.itemsExpense.isEmpty
                    ? Center(
                        child: Text(
                          !isSearchByPeriod
                              ? "Não há despesas realizadas neste mês."
                              : "Não há despesas realizadas neste período.",
                          style: const TextStyle(fontSize: 18),
                        ),
                      )
                    : Scrollbar(
                        child: ListView(
                          shrinkWrap: true,
                          children: expenseBalanceValues.itemsExpense.map(
                            (product) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 15,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
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
                                                style: const TextStyle(
                                                    fontSize: 20),
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
                                                style: const TextStyle(
                                                    fontSize: 20),
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
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
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
