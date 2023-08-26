import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../template/specie_payment.dart';

class PaymentPage extends StatefulWidget {
  final double total;
  const PaymentPage({required this.total, super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final amountReceivedController =
      MoneyMaskedTextController(leftSymbol: "R\$ ");
  double change = 0;
  double amountReceived = 0;

  @override
  void initState() {
    super.initState();
    amountReceived = widget.total;
    amountReceivedController.updateValue(amountReceived);
  }

  calculateChange() {}

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
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .8 + 33,
            padding: const EdgeInsets.only(
              top: 5,
              left: 15,
              right: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1),
                            top: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1),
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        //   ),
                        // ),
                        alignment: Alignment.center,
                        child: Text(
                          "Valor a pagar: ${numberFormat.format(widget.total)}",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: amountReceivedController,
                        textInputAction: TextInputAction.next,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: "Valor Recebido",
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.normal),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          suffixIcon: IconButton(
                            onPressed: () {
                              // setState(() {
                              amountReceived = 0;
                              amountReceivedController
                                  .updateValue(amountReceived);
                              print(amountReceived);
                              // });
                            },
                            icon: const Icon(
                              Icons.close,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (value) {},
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(10),
                        color: Colors.indigo.withOpacity(.1),
                        child: Text(
                          "Troco: ${numberFormat.format(change)}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SpeciePayment(),
                    ],
                  ),
                ),
                Container(
                  color: Colors.indigo.withOpacity(.1),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                            top: BorderSide(
                              width: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Cliente",
                              style: TextStyle(fontSize: 20),
                            ),
                            IconButton(
                              onPressed: () async {},
                              icon: Icon(
                                Icons.add,
                                size: 30,
                                color: Theme.of(context).primaryColor,
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
          )
        ],
      ),
    );
  }
}
