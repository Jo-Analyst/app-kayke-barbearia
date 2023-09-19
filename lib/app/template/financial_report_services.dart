import 'package:app_kayke_barbearia/app/controllers/financial_report_service_values.dart';
import 'package:app_kayke_barbearia/app/template/financial_report_service.list.dart';
import 'package:app_kayke_barbearia/app/template/payment.dart';
import 'package:flutter/material.dart';

import '../utils/convert_values.dart';

class FinancialReportServices extends StatelessWidget {
  final FinancialReportServicesValues financialReportServicesValues;
  const FinancialReportServices({
    required this.financialReportServicesValues,
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
            numberFormat.format(financialReportServicesValues.valueTotal),
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
          Container(
            color: const Color.fromARGB(17, 63, 81, 181),
            margin: const EdgeInsets.all(10),
            height: 200,
            child: FinancialReportServiceList(
              servicesProvided: financialReportServicesValues.itemsServices,
            ),
          ),
          Divider(color: Theme.of(context).primaryColor),
          Payment(
            itemsPaymentsSales:
                financialReportServicesValues.itemsPaymentsServices,
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
                    Text(
                      numberFormat.format(
                        financialReportServicesValues.valueTotalDicount,
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.amber,
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
                    Text(
                      numberFormat.format(
                        financialReportServicesValues.valuePaid,
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.green,
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
              ],
            ),
          ),
          // Container(
          //   color: Colors.indigo.withOpacity(0.1),
          //   padding: const EdgeInsets.all(20),
          //   margin: const EdgeInsets.only(bottom: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const Text(
          //         "Recebido",
          //         style: TextStyle(
          //           fontSize: 20,
          //           fontWeight: FontWeight.w700,
          //         ),
          //       ),
          //       Text(
          //         numberFormat.format(
          //           financialReportServicesValues.valuePaid,
          //         ),
          //         style: const TextStyle(
          //             fontSize: 20,
          //             color: Colors.green,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
