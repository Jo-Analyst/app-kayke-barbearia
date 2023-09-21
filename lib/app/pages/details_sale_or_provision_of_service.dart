import 'package:app_kayke_barbearia/app/controllers/items_sale.controller.dart';
import 'package:app_kayke_barbearia/app/controllers/items_services.dart';
import 'package:app_kayke_barbearia/app/controllers/provision_of_service_controller.dart';
import 'package:app_kayke_barbearia/app/controllers/sale_controller.dart';
import 'package:app_kayke_barbearia/app/providers/payment_provision_of_service_provider.dart';
import 'package:app_kayke_barbearia/app/template/list_tile_payment_receipt.dart';
import 'package:app_kayke_barbearia/app/utils/content_message.dart';
import 'package:app_kayke_barbearia/app/utils/convert_datetime.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/dialog.dart';
import 'package:app_kayke_barbearia/app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/payment_sale_provider.dart';

class DetailsSaleOrProvisionOfService extends StatefulWidget {
  final dynamic itemsList;
  final bool isService;
  const DetailsSaleOrProvisionOfService({
    required this.isService,
    required this.itemsList,
    super.key,
  });

  @override
  State<DetailsSaleOrProvisionOfService> createState() =>
      _DetailsSaleOrProvisionOfServiceState();
}

class _DetailsSaleOrProvisionOfServiceState
    extends State<DetailsSaleOrProvisionOfService> {
  bool expandedContainerSaleOrService = false;
  bool expandedContainerPayment = false;
  List<Map<String, dynamic>> listSalesOrProvisionOfServices = [];
  List<Map<String, dynamic>> receipts = [];
  double amountReceived = 0;
  String title = "", nameClient = "";

  @override
  void initState() {
    super.initState();
    loadItems();
    title = widget.isService ? "Serviço" : "Venda";
    final names = widget.itemsList["client_name"].toString().split(" ");
    nameClient = "${names[0]} ${names[names.length - 1]}";
  }

  loadItems() async {
    listSalesOrProvisionOfServices = widget.isService
        ? await ItemsServicesController.getItemsProvisionOfServiceId(
            widget.itemsList["id"])
        : await ItemsSaleController.getItemsSaleBySaleId(
            widget.itemsList["id"]);
    loadPayments();
    setState(() {});
  }

  loadPayments() async {
    dynamic paymentProvider;
    if (widget.isService) {
      paymentProvider = Provider.of<PaymentProvisionOfServiceProvider>(context,
          listen: false);
    } else {
      paymentProvider =
          Provider.of<PaymentSaleProvider>(context, listen: false);
    }
    await paymentProvider.loadById(widget.itemsList["id"]);
    receipts = paymentProvider.items;
    amountReceived = paymentProvider.amountReceived;

    setState(() {});
  }

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color);
  }

  closeScreen() {
    Navigator.of(context).pop(true);
  }

  deleteSaleOrProvisionOfService() async {
    final confirmDelete = await showExitDialog(
        context,
        widget.isService
            ? "Ao excluir você perderá o histórico do pagamento e outro items relacionados ao serviço. Deseja mesmo excluir o serviço - ${widget.itemsList["id"].toString().padLeft(5, "0")}?"
            : "Ao excluir você perderá o histórico do pagamento e outro items relacionados a venda. Deseja mesmo excluir a venda - ${widget.itemsList["id"].toString().padLeft(5, "0")}?");

    if (confirmDelete == true) {
      if (widget.isService) {
        ProvisionOfServiceController.deleteProvisionOfService(
            widget.itemsList["id"]);
      } else {
        SaleController.deleteSale(
            widget.itemsList["id"], listSalesOrProvisionOfServices);
      }

      showMessage(
        ContentMessage(
          title: widget.isService
              ? "Prestação de serviço excluido com sucesso."
              : "Venda excluida com sucesso.",
          icon: Icons.info,
        ),
        const Color.fromARGB(255, 199, 82, 74),
      );

      closeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "$title - ${widget.itemsList["id"].toString().padLeft(5, "0")}"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => deleteSaleOrProvisionOfService(),
              icon: const Icon(
                Icons.delete,
                size: 25,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.indigo.withOpacity(.1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 40,
                ),
                child: ListTile(
                  title: Text(
                    numberFormat.format(widget.itemsList["value_total"]),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        nameClient,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        changeTheDateWriting(widget.itemsList["date"]),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.white,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => setState(() {
                        expandedContainerSaleOrService =
                            !expandedContainerSaleOrService;
                      }),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.isService ? "Serviços" : "Vendas",
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            Icon(
                              expandedContainerSaleOrService
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 35,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (expandedContainerSaleOrService)
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: .2,
                            ),
                          ),
                        ),
                      ),
                    if (expandedContainerSaleOrService)
                      SizedBox(
                          child: Column(
                        children: listSalesOrProvisionOfServices.map((item) {
                          return Column(
                            children: [
                              ListTile(
                                minLeadingWidth: 0,
                                leading: Icon(
                                  widget.isService
                                      ? FontAwesomeIcons.screwdriverWrench
                                      : FontAwesomeIcons.boxOpen,
                                  size: 18,
                                ),
                                title: Text(
                                  item[widget.isService
                                      ? "description"
                                      : "name"],
                                  style: const TextStyle(fontSize: 20),
                                ),
                                subtitle: Text(
                                  numberFormat.format(item[widget.isService
                                      ? "price_service"
                                      : "sub_total"]),
                                  style: const TextStyle(fontSize: 20),
                                ),
                                trailing: widget.isService
                                    ? Text(
                                        "H.:${item["time_service"]}",
                                        style: const TextStyle(fontSize: 20),
                                      )
                                    : Text(
                                        "${item["quantity"].toString()}x",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                              ),
                              const Divider(color: Colors.indigo, height: 2),
                            ],
                          );
                        }).toList(),
                      )),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => setState(() {
                        expandedContainerPayment = !expandedContainerPayment;
                      }),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Pagamentos",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              expandedContainerPayment
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 35,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (expandedContainerPayment)
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: .5,
                            ),
                          ),
                        ),
                      ),
                    if (expandedContainerPayment)
                      Column(
                        children: receipts
                            .map(
                              (receipt) => Column(
                                children: [
                                  ListTilePaymentReceipt(receipt: receipt),
                                  const Divider(
                                    color: Colors.indigo,
                                    height: 2,
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    if (expandedContainerPayment)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Recebido",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
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
                        ),
                      )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Subtotal",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          numberFormat.format(
                            (widget.itemsList["value_total"] +
                                widget.itemsList["discount"]),
                          ),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Desconto",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            numberFormat.format(-widget.itemsList["discount"]),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          numberFormat.format(widget.itemsList["value_total"]),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
