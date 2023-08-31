import 'package:app_kaike_barbearia/app/pages/receipt_page.dart';
import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

class PaymentEditionPage extends StatefulWidget {
  final double valueSale;
  const PaymentEditionPage({required this.valueSale, super.key});

  @override
  State<PaymentEditionPage> createState() => _PaymentEditionPageState();
}

class _PaymentEditionPageState extends State<PaymentEditionPage> {
  final valueSaleController = TextEditingController();
  List<Map<String, dynamic>> receipts = [
    {"date": "30/07/2023", "value": 50.0, "specie": "PIX"},
    {"date": "30/07/2023", "value": 30.0, "specie": "Dinheiro"},
    {"date": "30/07/2023", "value": 50.0, "specie": "PIX"},
    {"date": "30/07/2023", "value": 30.0, "specie": "Dinheiro"},
    {"date": "30/07/2023", "value": 50.0, "specie": "PIX"},
    {"date": "30/07/2023", "value": 30.0, "specie": "Dinheiro"},
    {"date": "30/07/2023", "value": 50.0, "specie": "PIX"},
    {"date": "30/07/2023", "value": 30.0, "specie": "Dinheiro"},
    {"date": "30/07/2023", "value": 50.0, "specie": "PIX"},
    {"date": "30/07/2023", "value": 30.0, "specie": "Dinheiro"},
    {"date": "30/07/2023", "value": 50.0, "specie": "PIX"},
    {"date": "30/07/2023", "value": 30.0, "specie": "Dinheiro"},
    {"date": "30/07/2023", "value": 50.0, "specie": "PIX"},
    {"date": "30/07/2023", "value": 30.0, "specie": "Dinheiro"},
    {"date": "30/07/2023", "value": 50.0, "specie": "PIX"},
    {"date": "30/07/2023", "value": 30.0, "specie": "Dinheiro"},
  ];

  @override
  void initState() {
    super.initState();
    valueSaleController.text = numberFormat.format(widget.valueSale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagamento"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.check,
                size: 25,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: ListView(
              children: [
                TextFormField(
                  controller: valueSaleController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Valor Venda",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                  ),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                receipts.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height - 360,
                        child: const Center(
                          child: Text(
                            "Não há recebimentos.",
                            style: TextStyle(fontSize: 25),
                          ),
                        ))
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            child: const Text(
                              "Recebimento(s)",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              color: Colors.indigo.withOpacity(.1),
                              height: MediaQuery.of(context).size.height - 370,
                              child: ListView.separated(
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) {
                                  var receipt = receipts[index];
                                  return ListTile(
                                    minLeadingWidth: 0,
                                    leading: Icon(
                                      Icons.monetization_on,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          numberFormat.format(
                                            receipt["value"],
                                          ),
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          receipt["date"],
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    subtitle: Text(
                                      receipt["specie"],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (_, __) => Divider(
                                  height: 0,
                                  color: Theme.of(context).primaryColor,
                                ),
                                itemCount: receipts.length,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total recebido",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                numberFormat.format(80),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
              ],
            ),
          ),
          Positioned(
            right: 15,
            left: 15,
            bottom: 10,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ReceiptPage(
                          isSale: false, total: 12, dateSale: "dateSale"),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    Text(
                      "Novo recebimento",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
