import 'package:flutter/material.dart';

import '../utils/convert_values.dart';

class FinancialReportSaleList extends StatelessWidget {
  final List<Map<String, dynamic>> itemsSale;
  const FinancialReportSaleList({
    required this.itemsSale,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: itemsSale.isEmpty
          ? const Center(
              child: Text(
                "Não há vendas realizadas neste mês.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView(
              shrinkWrap: true,
              children: itemsSale.map(
                (item) {
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
                                    item["name"],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width / 8,
                                  child: Text(
                                    item["quantity_items"].toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      numberFormat.format(item["subtotal"]),
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
    );
  }
}
