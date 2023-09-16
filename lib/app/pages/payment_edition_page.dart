import 'package:app_kayke_barbearia/app/pages/receipt_page.dart';
import 'package:app_kayke_barbearia/app/providers/payment_sale_provider.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../utils/content_message.dart';
import '../utils/convert_datetime.dart';
import '../utils/snackbar.dart';
import 'home_page.dart';

class PaymentEditionPage extends StatefulWidget {
  final bool isService;
  final double value;
  final int id;
  const PaymentEditionPage({
    required this.isService,
    required this.id,
    required this.value,
    super.key,
  });

  @override
  State<PaymentEditionPage> createState() => _PaymentEditionPageState();
}

class _PaymentEditionPageState extends State<PaymentEditionPage> {
  final valueSaleController = TextEditingController();
  double amountReceived = 0;
  List<Map<String, dynamic>> receipts = [];
  bool confirmAction = false;

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
    confirmAction = true;
    setState(() {});
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
    valueSaleController.text = numberFormat.format(widget.value);
    loadPayments();
  }

  loadPayments() async {
    final paymentSaleProvider =
        Provider.of<PaymentSaleProvider>(context, listen: false);
    await paymentSaleProvider.loadById(widget.id);
    receipts = paymentSaleProvider.items;
    amountReceived = paymentSaleProvider.amountReceived;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (confirmAction) {
          closeScreen();
        } else {
          Navigator.of(context).pop();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pagamento"),
          leading: confirmAction
              ? IconButton(
                  onPressed: () => closeScreen(),
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                  ),
                )
              : null,
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
                    decoration: InputDecoration(
                      labelText: widget.isService
                          ? "Valor do Serviço"
                          : "Valor da Venda",
                      labelStyle: const TextStyle(
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
                          height: confirmAction
                              ? MediaQuery.of(context).size.height - 360
                              : MediaQuery.of(context).size.height - 300,
                          child: const Center(
                            child: Text(
                              "Não há recebimentos.",
                              style: TextStyle(fontSize: 18),
                            ),
                          ))
                      : Consumer<PaymentSaleProvider>(
                          builder: (context, paymentProvider, _) {
                            receipts = paymentProvider.items;
                            amountReceived = paymentProvider.amountReceived;
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
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
                                    height: amountReceived < widget.value
                                        ? confirmAction
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                455
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                405
                                        : MediaQuery.of(context).size.height -
                                            350,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: receipts.length,
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
                                                          await Navigator.of(
                                                                  context)
                                                              .push(
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              ReceiptPage(
                                                            id: widget.id,
                                                            receipt: receipt,
                                                            isEdition: true,
                                                            totalAmountReceived:
                                                                amountReceived,
                                                            isSale: false,
                                                            total: widget.value,
                                                          ),
                                                        ),
                                                      );

                                                      if (paymentReceived !=
                                                          null) {
                                                        setState(() {
                                                          confirmAction = true;
                                                          
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
                                                    backgroundColor:
                                                        Colors.amber,
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: Icons.edit_outlined,
                                                    label: "Editar",
                                                  ),
                                                  if (receipts.length > 1)
                                                    SlidableAction(
                                                      onPressed: (_) =>
                                                          deletePayment(
                                                        index,
                                                        receipt["id"],
                                                      ),
                                                      backgroundColor:
                                                          Colors.red,
                                                      foregroundColor:
                                                          Colors.white,
                                                      icon: Icons.delete,
                                                      label: "Excluir",
                                                    ),
                                                ],
                                              ),
                                              child: ListTile(
                                                minLeadingWidth: 0,
                                                leading: Icon(
                                                  Icons.monetization_on,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                title: Text(
                                                  numberFormat.format(
                                                    receipt["value"],
                                                  ),
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                                subtitle: Text(
                                                  receipt["specie"],
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                                trailing: Text(
                                                  changeTheDateWriting(
                                                      receipt["date"]),
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              height: 1,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                            );
                          },
                        )
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
                    visible: amountReceived < widget.value,
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
                                id: widget.id,
                                receipt: const {},
                                isEdition: false,
                                totalAmountReceived: amountReceived,
                                isSale: false,
                                total: widget.value,
                              ),
                            ),
                          );

                          if (paymentReceived != null) {
                            setState(() {
                              confirmAction = true;
                              receipts.add(paymentReceived);
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
                  Visibility(
                    visible: confirmAction,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => closeScreen(),
                          child: const Text(
                            "Fechar",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
