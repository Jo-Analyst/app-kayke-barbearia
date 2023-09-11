import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
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
  final Map<String, dynamic> receipt;
  final bool isSale;
  final bool isEdition;
  const ReceiptPage({
    required this.isSale,
    required this.isEdition,
    required this.receipt,
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
      valueToResetTheRemainingValue = 0, // valor para zerar o valor restante
      remainingAmount = 0; // valor restante
  String typeSpecie = "Dinheiro";
  IconData? iconSpeciePayment = Icons.attach_money;
  Map<String, dynamic> payment = {};
  DateTime dateSelected = DateTime.now();

  @override
  void initState() {
    super.initState();
    amountReceivable = widget.total - widget.totalAmountReceived;
    remainingAmount = amountReceivable;
    if (!widget.isEdition) return;

    amountReceived = widget.receipt["value"] ?? 0;
    int year = int.parse(widget.receipt["date"].toString().split("/")[2]);
    int month = int.parse(widget.receipt["date"].toString().split("/")[1]);
    int day = int.parse(widget.receipt["date"].toString().split("/")[0]);
    dateSelected = DateTime(year, month, day);
    typeSpecie = widget.receipt["specie"];
    amountReceivedController.updateValue(amountReceived);
    valueToResetTheRemainingValue = amountReceived + remainingAmount;
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
    if (!widget.isEdition) {
      if (amountReceived >= remainingAmount) {
        calculateChange();
      } else {
        calculateAmountReceivable();
      }
    } else {
      calculateAmountReceivablefromEdition();
    }
  }

  calculateAmountReceivablefromEdition() {
    if (remainingAmount == 0) {
      amountReceivable = widget.receipt["value"] - amountReceived;
    } else {
      amountReceivable = remainingAmount;
      if (amountReceived > widget.receipt["value"]) {
        amountReceivable -= (amountReceived - widget.receipt["value"]);
      } else if (amountReceived == widget.receipt["value"]) {
        amountReceivable = remainingAmount;
      } else {
        amountReceivable += (widget.receipt["value"] - amountReceived);
      }
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
      "id": widget.isEdition ? widget.receipt["id"] : 0,
      "date": dateFormat1.format(dateSelected),
      "value": amountReceived <= remainingAmount
          ? amountReceived
          : (amountReceived - change),
      "specie": typeSpecie,
    };

    Navigator.of(context).pop(payment);
  }

  String showResult() {
    String text = "";
    if (!widget.isEdition) {
      text = amountReceived > remainingAmount
          ? "Troco: ${numberFormat.format(change)}"
          : "Valor restante: ${numberFormat.format(amountReceivable)}";
    } else {
      text = "Valor restante: ${numberFormat.format(amountReceivable)}";
    }

    return text;
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
            dateInitial: dateSelected,
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

                            if (widget.isEdition) {
                              if (amountReceived >
                                  valueToResetTheRemainingValue) {
                                amountReceived = valueToResetTheRemainingValue;
                                amountReceivedController
                                    .updateValue(amountReceived);
                              }
                            }
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
                          showResult(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SpeciePaymentReceipt(
                        specie: widget.receipt.isNotEmpty
                            ? widget.receipt["specie"]
                            : null,
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
