import 'package:app_kayke_barbearia/app/pages/payment_provision_of_service_edition_page.dart';
import 'package:app_kayke_barbearia/app/pages/payment_sale_edition_page.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

import '../utils/convert_datetime.dart';

class DetailsPayment extends StatelessWidget {
  final Map<String, dynamic> payment;
  final bool isService;
  const DetailsPayment({
    required this.isService,
    required this.payment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      height: payment["situation"] == "Recebido" ? 250 : 330,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            color: Colors.indigo.withOpacity(.1),
            child: Row(
              children: [
                const Icon(Icons.person),
                Text(
                  payment["client_name"] ?? "Cliente avulso",
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Column(
            children: payment["situation"] == "Recebido"
                ? [
                    Container(
                      height: 80,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            child: Text(
                              changeTheDateWriting(payment["date"]),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            child: Column(
                              children: [
                                const Text(
                                  "Valor",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      numberFormat
                                          .format(payment["value_total"]),
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.indigo.withOpacity(.1),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "Status: ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            payment["situation"],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                : [
                    Container(
                      height: 80,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            child: Text(
                              changeTheDateWriting(payment["date"]),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            child: Column(
                              children: [
                                const Text(
                                  "Valor",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      numberFormat
                                          .format(payment["value_total"]),
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.indigo.withOpacity(.1),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "Status: ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            payment["situation"],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Valor pago",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      numberFormat
                                          .format(payment["amount_paid"]),
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "V. a receber",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      numberFormat.format(
                                          (payment["value_total"] -
                                              payment["amount_paid"])),
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => isService
                        ? PaymentProvisionOfServiceEditionPage(
                            isCasualCustomer: payment["client_name"]
                                    .toString()
                                    .toLowerCase() ==
                                "cliente avulso",
                            isService: isService,
                            value: payment["value_total"],
                            id: payment["id"],
                          )
                        : PaymentEditionPage(
                            isCasualCustomer: payment["client_name"]
                                    .toString()
                                    .toLowerCase() ==
                                "cliente avulso",
                            isService: isService,
                            value: payment["value_total"],
                            id: payment["id"],
                          ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    payment["situation"] == "Recebido"
                        ? "Editar pagamento"
                        : "Incluir pagamento",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
