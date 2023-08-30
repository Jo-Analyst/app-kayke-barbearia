import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

class DetailsPayment extends StatelessWidget {
  final Map<String, dynamic> payment;
  const DetailsPayment({required this.payment, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
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
                              payment["specie"],
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            child: Text(
                              numberFormat.format(payment["value"]),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
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
                            child: Container(
                              alignment: Alignment.topCenter,
                              width: MediaQuery.of(context).size.width / 2 - 30,
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
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            width: MediaQuery.of(context).size.width / 2 - 30,
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    payment["situation"] == "Recebido"
                        ? "Editar pagamento"
                        : "Incluir pagamento",
                    style: const TextStyle(fontSize: 20),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
