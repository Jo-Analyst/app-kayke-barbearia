import 'package:app_kayke_barbearia/app/template/payment.dart';
import 'package:app_kayke_barbearia/app/utils/loading.dart';
import 'package:flutter/material.dart';

import '../controllers/financial_report_sale_values.dart';
import '../utils/convert_values.dart';
import 'financial_report_sale_list.dart';

class FinancialReportSales extends StatelessWidget {
  final FinancialReportSalesValues financialReportSalesValues;
  final bool isLoading;
  final bool isSearchByPeriod;
  const FinancialReportSales({
    required this.isLoading,
    required this.isSearchByPeriod,
    required this.financialReportSalesValues,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print(isSearchByPeriod);
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isLoading
              ? loading(context, 30)
              : Text(
                  numberFormat
                      .format(financialReportSalesValues.valueTotalSale),
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
            child: isLoading
                ? Center(child: loading(context, 30))
                : FinancialReportSaleList(
                    isSearchByPeriod: isSearchByPeriod,
                    itemsSale: financialReportSalesValues.itemsSales,
                  ),
          ),
          Divider(color: Theme.of(context).primaryColor),
          Payment(
            itemsPaymentsSales: financialReportSalesValues.itemsPaymentsSales,
          ),
          const SizedBox(height: 20),
          Container(
            color: Colors.indigo.withOpacity(.1),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    isLoading
                        ? loading(context, 15)
                        : FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              numberFormat.format(financialReportSalesValues
                                  .valueTotalDiscount),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                    const Text(
                      "Desconto",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    isLoading
                        ? loading(context, 15)
                        : FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              numberFormat
                                  .format(financialReportSalesValues.valuePaid),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            ),
                          ),
                    const Text(
                      "Recebido",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    isLoading
                        ? loading(context, 15)
                        : FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              numberFormat
                                  .format(financialReportSalesValues.profit),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.indigo,
                              ),
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
          ),
        ],
      ),
    );
  }
}
