import 'package:app_kayke_barbearia/app/pages/receipt_page.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../utils/content_message.dart';
import '../utils/snackbar.dart';
import 'home_page.dart';

class PaymentEditionPage extends StatefulWidget {
  final double valueSale;
  const PaymentEditionPage({required this.valueSale, super.key});

  @override
  State<PaymentEditionPage> createState() => _PaymentEditionPageState();
}

class _PaymentEditionPageState extends State<PaymentEditionPage> {
  final valueSaleController = TextEditingController();
  double amountReceived = 0;
  List<Map<String, dynamic>> receipts = [];

  calculateamountReceived() {
    setState(() {
      amountReceived = 0;
      for (var receipt in receipts) {
        amountReceived += receipt["value"];
      }
    });
  }

  closeScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
      (route) => false,
    );
  }

  deletePayment(int index, int? idPayment) async {
    final confirmExit =
        await showExitDialog(context, "Deseja mesmo excluir este pagamento?");

    if (confirmExit == null || !confirmExit) return;

    receipts.removeAt(index);
    setState(() {});
    calculateamountReceived();
    showMessage(
      const ContentMessage(
        title: "Pagamento excluido.",
        icon: Icons.info,
      ),
      Colors.red,
    );
  }

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color);
  }

  @override
  void initState() {
    super.initState();
    valueSaleController.text = numberFormat.format(widget.valueSale);
    calculateamountReceived();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagamento"),
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
                    ? Container(
                        color: Colors.indigo.withOpacity(.1),
                        height: MediaQuery.of(context).size.height - 360,
                        child: const Center(
                          child: Text(
                            "Não há recebimentos.",
                            style: TextStyle(fontSize: 18),
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
                              height: amountReceived < widget.valueSale
                                  ? MediaQuery.of(context).size.height - 455
                                  : MediaQuery.of(context).size.height - 350,
                              child: ListView.builder(
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) {
                                  var receipt = receipts[index];
                                  return Column(
                                    children: [
                                      Slidable(
                                        endActionPane: ActionPane(
                                          motion: const StretchMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (_) async {
                                                final paymentReceived =
                                                    await Navigator.of(context)
                                                        .push(
                                                  MaterialPageRoute(
                                                    builder: (_) => ReceiptPage(
                                                      receipt: receipt,
                                                      isEdition: true,
                                                      totalAmountReceived:
                                                          amountReceived,
                                                      isSale: false,
                                                      total: widget.valueSale,
                                                    ),
                                                  ),
                                                );

                                                if (paymentReceived != null) {
                                                  setState(() {
                                                    receipt["id"] =
                                                        paymentReceived["id"];
                                                    receipt["value"] =
                                                        paymentReceived[
                                                            "value"];
                                                    receipt["date"] =
                                                        paymentReceived["date"];
                                                    receipt["specie"] =
                                                        paymentReceived[
                                                            "specie"];

                                                    calculateamountReceived();
                                                    showMessage(
                                                      const ContentMessage(
                                                        title:
                                                            "Pagamento editado com sucesso.",
                                                        icon: Icons.info,
                                                      ),
                                                      Colors.orange,
                                                    );
                                                  });
                                                }
                                              },
                                              backgroundColor: Colors.amber,
                                              foregroundColor: Colors.white,
                                              icon: Icons.edit_outlined,
                                              label: "Editar",
                                            ),
                                            SlidableAction(
                                              onPressed: (_) => deletePayment(
                                                  index, receipt["id"]),
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              label: "Excluir",
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          minLeadingWidth: 0,
                                          leading: Icon(
                                            Icons.monetization_on,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          title: Text(
                                            numberFormat.format(
                                              receipt["value"],
                                            ),
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          subtitle: Text(
                                            receipt["specie"],
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          trailing: Text(
                                            receipt["date"],
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        height: 1,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ],
                                  );
                                },
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
                                numberFormat.format(amountReceived),
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
            child: Column(
              children: [
                Visibility(
                  visible: amountReceived < widget.valueSale,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        final paymentReceived =
                            await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ReceiptPage(
                              receipt: const {},
                              isEdition: false,
                              totalAmountReceived: amountReceived,
                              isSale: false,
                              total: widget.valueSale,
                            ),
                          ),
                        );

                        if (paymentReceived != null) {
                          setState(() {
                            receipts.add(paymentReceived);
                            calculateamountReceived();
                          });
                        }
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => closeScreen(),
                      child: const Text(
                        "Fechar",
                        style: TextStyle(fontSize: 20),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
