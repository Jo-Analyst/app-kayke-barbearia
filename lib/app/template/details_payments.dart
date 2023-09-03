import 'package:app_kaike_barbearia/app/pages/payment_edition_page.dart';
import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

class DetailsPayment extends StatelessWidget {
  final Map<String, dynamic> payment;
  const DetailsPayment({required this.payment, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: payment["situation"] == "Recebido" ? 230 : 310,
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
                              payment["date_sale"],
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
                                  style:  TextStyle(fontSize: 20),
                                ),
                                Text(
                                  numberFormat.format(payment["value"]),
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
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
                              payment["date_sale"],
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
                                  style:  TextStyle(fontSize: 20),
                                ),
                                Text(
                                  numberFormat.format(payment["value"]),
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
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
                                Text(
                                  numberFormat.format(payment["amount_paid"]),
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
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
                                const Text(
                                  "Valor a receber",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  numberFormat.format(payment["value"]),
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
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
                    builder: (_) =>
                        PaymentEditionPage(valueSale: payment["value"]),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  payment["situation"] == "Recebido"
                      ? "Editar pagamento"
                      : "Incluir pagamento",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}