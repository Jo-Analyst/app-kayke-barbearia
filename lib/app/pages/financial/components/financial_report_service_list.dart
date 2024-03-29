import 'package:flutter/material.dart';

import '../../../utils/convert_values.dart';

class FinancialReportServiceList extends StatelessWidget {
  final List<Map<String, dynamic>> servicesProvided;
  final bool isSearchByPeriod;
  const FinancialReportServiceList({
    required this.isSearchByPeriod,
    required this.servicesProvided,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: servicesProvided.isEmpty
          ? Center(
              child: Text(
                !isSearchByPeriod
                    ? "Não há serviços prestados neste mês."
                    : "Não há serviços prestados neste período.",
                style: const TextStyle(fontSize: 18),
              ),
            )
          : ListView(
              shrinkWrap: true,
              children: servicesProvided.map(
                (service) {
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
                                    service["description"],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width / 8,
                                  child: Text(
                                    service["quantity_services"].toString(),
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
                                      numberFormat.format(service["subtotal"]),
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
