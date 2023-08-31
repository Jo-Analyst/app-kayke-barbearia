import 'package:app_kaike_barbearia/app/pages/client_list_page.dart';
import 'package:app_kaike_barbearia/app/utils/content_message.dart';
import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../template/specie_payment_receipt.dart';
import '../utils/snackbar.dart';
import 'proof_page.dart';

class ReceiptPage extends StatefulWidget {
  final double total;
  final double amountReceived;
  final String dateSale;
  final bool isSale;
  const ReceiptPage({
    required this.isSale,
    required this.amountReceived,
    required this.total,
    required this.dateSale,
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
      amountReceivable = 0,
      lastChangeValue = 0,
      remainingAmount = 0; // valor restante
  String typeSpecie = "Dinheiro", titleClient = "Cliente";
  IconData? iconSpeciePayment = Icons.attach_money;
  Map<String, dynamic> client = {}, payment = {};

  @override
  void initState() {
    super.initState();
    lastChangeValue = widget.total;
    amountReceivable = widget.total - widget.amountReceived;
    remainingAmount = amountReceivable;
  }

  calculateChange() {
    setState(() {
      change = amountReceived  - remainingAmount;

      amountReceivable = 0;
    });
  }

  calculateAmountReceivable() {
    setState(() {
      amountReceivable =
          widget.total - (amountReceived + widget.amountReceived);
      change = 0;
    });
  }

  calculate() {
    print(amountReceived >= remainingAmount);
    if (amountReceived >= remainingAmount) {
      calculateChange();
    } else {
      calculateAmountReceivable();
    }

    changeTitleClient();
  }

  changeTitleClient() {
    if (client.isEmpty) {
      titleClient = amountReceived < widget.total ? "Cliente*" : "Cliente";
    }
  }

  openScreenClient() async {
    final clientSelected = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ClientListPage(
          itFromTheSalesScreen: true,
        ),
      ),
    );

    if (clientSelected != null) {
      setState(() {
        titleClient = clientSelected["name"];
        client = clientSelected;
      });
    }
  }

  confirmSale() {
    if (client.isEmpty && amountReceivable > 0) {
      showMessage(
          const ContentMessage(
            title:
                "Selecione um cliente para concluir a venda. Existe um valor pendente.",
            icon: FontAwesomeIcons.circleExclamation,
          ),
          Colors.orange);
      return;
    }
    payment = {
      "client": client.isNotEmpty ? client["name"] : "Cliente avulso",
      "amount_received": amountReceived,
      "specie": typeSpecie,
      "icon": iconSpeciePayment,
      "date_sale": widget.dateSale
    };

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProofPage(
          payment: payment,
          saleTotal: widget.total,
          isSale: widget.isSale,
        ),
      ),
    );
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
              onPressed: () => confirmSale(),
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
                          "Valor pago: ${numberFormat.format(widget.amountReceived)}",
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
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  amountReceived = 0;

                                  lastChangeValue = amountReceived;
                                  amountReceivedController
                                      .updateValue(amountReceived);
                                });
                                calculate();
                              },
                              icon: const Icon(Icons.close),
                            )),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          setState(() {
                            amountReceived =
                                amountReceivedController.numberValue;
                            lastChangeValue = amountReceived;
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
                          amountReceived >= remainingAmount
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

                            if (typeSpecie == "fiado") {
                              change = 0;
                              amountReceivedController.updateValue(change);
                              amountReceived = 0;
                              amountReceivable = widget.total;
                            } else {
                              amountReceived = lastChangeValue;
                              amountReceivedController
                                  .updateValue(amountReceived);
                            }
                            iconSpeciePayment = icon;
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
