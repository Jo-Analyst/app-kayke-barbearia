import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../template/calendar.dart';
import '../template/specie_payment_receipt.dart';
import '../utils/content_message.dart';
import '../utils/snackbar.dart';

class ReceiptPage extends StatefulWidget {
  final double total;
  final double totalAmountReceived;
  final double? amountReceived;
  final bool isSale;
  final bool isEdition;
  const ReceiptPage({
    required this.isSale,
    required this.isEdition,
    this.amountReceived,
    required this.totalAmountReceived,
    required this.total,
    super.key,
  });

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  final amountReceivedController =
      MoneyMaskedTextController(leftSymbol: "R\$ ");
  double change = 0,
      amountReceived = 0,
      totalAmountReceived = 0,
      amountReceivable = 0,
      remainingAmount = 0; // valor restante
  String typeSpecie = "Dinheiro", titleClient = "Cliente";
  IconData? iconSpeciePayment = Icons.attach_money;
  Map<String, dynamic> payment = {};
  DateTime dateSelected = DateTime.now();

  @override
  void initState() {
    super.initState();
    print(widget.total);
    print(widget.totalAmountReceived);
    amountReceivable = widget.total - widget.totalAmountReceived;
    remainingAmount = amountReceivable;
    if (!widget.isEdition) return;

    amountReceived = widget.amountReceived ?? 0;
    amountReceivedController.updateValue(amountReceived);
  }

  calculateChange() {
    setState(() {
      change = amountReceived - remainingAmount;

      amountReceivable = 0;
    });
  }

  calculateAmountReceivable() {
    setState(() {
      amountReceivable =
          widget.total - (amountReceived + widget.totalAmountReceived);
      change = 0;
    });
  }

  calculate() {
    if (amountReceived >= remainingAmount) {
      print("Chamou");
      calculateChange();
    } else {
      calculateAmountReceivable();
    }
  }

  confirmPayment() {
    if (amountReceived == 0) {
      showMessage(
        const ContentMessage(
          title: "Informe o valor pago pelo cliente.",
          icon: FontAwesomeIcons.circleExclamation,
        ),
        Colors.orange,
      );
      return;
    }

    payment = {
      "date": dateFormat1.format(dateSelected),
      "value": amountReceived <= remainingAmount
          ? amountReceived
          : (amountReceived - change),
      "specie": typeSpecie,
    };

    Navigator.of(context).pop(payment);
  }

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color);
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
              onPressed: () => confirmPayment(),
              icon: const Icon(
                Icons.check,
                size: 35,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Calendar(
            onSelected: (date) {
              setState(() {
                dateSelected = date;
              });
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height * .8 + 33,
            padding: const EdgeInsets.only(
              // top: 5,
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
                              width: 1,
                            ),
                            top: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: Text(
                          "Valor pago: ${numberFormat.format(widget.totalAmountReceived)}",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: amountReceivedController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: "Valor do Recebimento",
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.normal),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                amountReceived = 0;

                                amountReceivedController
                                    .updateValue(amountReceived);
                              });
                              calculate();
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          setState(() {
                            amountReceived =
                                amountReceivedController.numberValue;
                          });
                          calculate();
                        },
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(10),
                        color: Colors.indigo.withOpacity(.1),
                        child: Text(
                          totalAmountReceived >= remainingAmount
                              ? "Troco: ${numberFormat.format(change)}"
                              : "Valor restante: ${numberFormat.format(amountReceivable)}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SpeciePaymentReceipt(
                        getPaymentTypeName: (value, icon) {
                          setState(() {
                            typeSpecie = value;

                            calculate();
                          });
                        },
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
