import 'package:app_kayke_barbearia/app/pages/home/home_page.dart';
import 'package:app_kayke_barbearia/app/pages/receipt/receipt_page.dart';
import 'package:app_kayke_barbearia/app/providers/payment_sale_provider.dart';
import 'package:app_kayke_barbearia/app/pages/payments/components/list_tile_payment_receipt.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/dialog.dart';
import 'package:app_kayke_barbearia/app/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../utils/content_message.dart';
import '../../utils/snackbar.dart';

class PaymentEditionPage extends StatefulWidget {
  final bool isService;
  final bool isCasualCustomer;
  final double value;
  final int id;
  final DateTime dateTransaction;

  const PaymentEditionPage({
    required this.isService,
    required this.id,
    required this.value,
    required this.isCasualCustomer,
    required this.dateTransaction,
    super.key,
  });

  @override
  State<PaymentEditionPage> createState() => _PaymentSaleEditionPageState();
}

class _PaymentSaleEditionPageState extends State<PaymentEditionPage> {
  final valueSaleController = TextEditingController();
  double amountReceived = 0;
  List<Map<String, dynamic>> receipts = [];
  Map<String, dynamic> receipt = {};
  bool confirmAction = false, isLoading = true;

  void closeScreen() async {
    if (confirmAction) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  void deletePayment(int index, int idPayment) async {
    final paymentProvider =
        Provider.of<PaymentSaleProvider>(context, listen: false);
    final confirmExit =
        await showExitDialog(context, "Deseja mesmo excluir este pagamento?");

    if (confirmExit == null || !confirmExit) return;
    paymentProvider.delete(idPayment);
    setState(() {
      confirmAction = true;
    });
    showMessage(
      const ContentMessage(
        title: "Pagamento excluido.",
        icon: Icons.info,
      ),
      Colors.red,
    );
  }

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color, 3000);
  }

  @override
  void initState() {
    super.initState();

    valueSaleController.text = numberFormat.format(widget.value);
    loadPayments();
  }

  void loadPayments() async {
    final paymentProvider =
        Provider.of<PaymentSaleProvider>(context, listen: false);
    await paymentProvider.loadById(widget.id);
    receipts = paymentProvider.items;
    amountReceived = paymentProvider.amountReceived;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        closeScreen();
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
        body: isLoading
            ? Center(
                child: loading(context, 50),
              )
            : Consumer<PaymentSaleProvider>(
                builder: (context, paymentProvider, _) {
                  receipts = paymentProvider.items;
                  amountReceived = paymentProvider.amountReceived;
                  return Stack(
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
                                labelText: "Valor da Venda",
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                              ),
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            amountReceived == 0
                                ? Container(
                                    color: Colors.indigo.withOpacity(.1),
                                    height: confirmAction
                                        ? MediaQuery.of(context).size.height -
                                            360
                                        : MediaQuery.of(context).size.height -
                                            300,
                                    child: const Center(
                                      child: Text(
                                        "Não há recebimentos desta venda. Faça o primeiro pagamento",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  )
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                                      420
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  390,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: receipts.length,
                                            itemBuilder: (_, index) {
                                              var receipt = receipts[index];
                                              return Column(
                                                children: [
                                                  Slidable(
                                                    endActionPane: ActionPane(
                                                      motion:
                                                          const StretchMotion(),
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
                                                                  isCasualCustomer:
                                                                      widget
                                                                          .isCasualCustomer,
                                                                  dateTransaction:
                                                                      widget
                                                                          .dateTransaction,
                                                                  id: widget.id,
                                                                  receipt:
                                                                      receipt,
                                                                  isEdition:
                                                                      true,
                                                                  totalAmountReceived:
                                                                      amountReceived,
                                                                  isService: widget
                                                                      .isService,
                                                                  total: widget
                                                                      .value,
                                                                ),
                                                              ),
                                                            );

                                                            if (paymentReceived !=
                                                                null) {
                                                              setState(() {
                                                                confirmAction =
                                                                    true;

                                                                showMessage(
                                                                  const ContentMessage(
                                                                    title:
                                                                        "Pagamento editado com sucesso.",
                                                                    icon: Icons
                                                                        .info,
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
                                                          icon: Icons
                                                              .edit_outlined,
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
                                                    child:
                                                        ListTilePaymentReceipt(
                                                            receipt: receipt),
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
                                          isCasualCustomer:
                                              widget.isCasualCustomer,
                                          dateTransaction:
                                              widget.dateTransaction,
                                          id: widget.id,
                                          receipt: amountReceived == 0
                                              ? receipts[0]
                                              : {},
                                          isEdition: false,
                                          totalAmountReceived: amountReceived,
                                          isService: widget.isService,
                                          total: widget.value,
                                        ),
                                      ),
                                    );

                                    if (paymentReceived != null) {
                                      setState(() {
                                        confirmAction = true;
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
                  );
                },
              ),
      ),
    );
  }
}
