import 'package:app_kayke_barbearia/app/controllers/items_sale.controller.dart';
import 'package:app_kayke_barbearia/app/controllers/items_services.dart';
import 'package:app_kayke_barbearia/app/providers/payment_provision_of_service_provider.dart';
import 'package:app_kayke_barbearia/app/template/list_tile_payment_receipt.dart';
import 'package:app_kayke_barbearia/app/utils/convert_datetime.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
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
  bool expanded = false;
  List<Map<String, dynamic>> listSalesOrProvisionOfServices = [];
  List<Map<String, dynamic>> receipts = [];
  double amountReceived = 0;
  String title = "";

  @override
  void initState() {
    super.initState();
    loadItemsSale();
    title = widget.isService ? "Serviço" : "Venda";
    print(widget.itemsList);
  }

  loadItemsSale() async {
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
              onPressed: () {},
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
                  leading: Text(
                    numberFormat.format(widget.itemsList["value_total"]),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.itemsList["client_name"],
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
                        expanded = !expanded;
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
                              expanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 35,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Divider(color: Colors.indigo, height: 4),
                    if (expanded)
                      SizedBox(
                          child: Column(
                        children: listSalesOrProvisionOfServices.map((item) {
                          return Column(
                            children: [
                              ListTile(
                                minLeadingWidth: 0,
                                leading: Icon(widget.isService
                                    ? FontAwesomeIcons.screwdriverWrench
                                    : FontAwesomeIcons.boxOpen),
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
              Container(
                margin: const EdgeInsets.only(top: 10),
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Pagamentos",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Divider(color: Colors.indigo, height: 4),
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
            ],
          ),
        ),
      ),
    );
  }
}
