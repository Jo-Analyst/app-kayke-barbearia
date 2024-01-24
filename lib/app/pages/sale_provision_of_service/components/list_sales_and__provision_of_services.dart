import 'package:app_kayke_barbearia/app/pages/sale_provision_of_service/details_sale_or_provision_of_service.dart';
import 'package:app_kayke_barbearia/app/pages/sale_provision_of_service/sales_and_provision_of_services_list_page.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/loading.dart';
import 'package:flutter/material.dart';

import '../../../utils/convert_datetime.dart';

class ListSalesAndProvisionOfServices extends StatefulWidget {
  final List<Map<String, dynamic>> itemsList;
  final bool isService;
  final bool isLoading;
  final TypeTransactionSelected typeTransaction;
  final Function() onload;

  const ListSalesAndProvisionOfServices({
    required this.isLoading,
    required this.isService,
    required this.typeTransaction,
    required this.itemsList,
    required this.onload,
    super.key,
  });

  @override
  State<ListSalesAndProvisionOfServices> createState() =>
      _ListSalesAndProvisionOfServicesState();
}

class _ListSalesAndProvisionOfServicesState
    extends State<ListSalesAndProvisionOfServices> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Center(
            child: loading(context, 50),
          )
        : widget.itemsList.isEmpty
            ? Center(
                child: Text(
                  widget.typeTransaction == TypeTransactionSelected.sales
                      ? "Não há registro da venda."
                      : "Não há registro do serviço.",
                  style: const TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.itemsList.length,
                itemBuilder: (_, index) {
                  final nameCompleted = widget.itemsList[index]["client_name"]
                      .toString()
                      .split(" ");

                  String nameClient = nameCompleted.length > 1
                      ? "${nameCompleted[0]} ${nameCompleted[nameCompleted.length - 1]}"
                      : widget.itemsList[index]["client_name"].toString();
                  return Column(
                    children: [
                      ListTile(
                        onTap: () async {
                          final confirmAction =
                              await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => DetailsSaleOrProvisionOfService(
                                isService: widget.isService,
                                itemsList: widget.itemsList[index],
                              ),
                            ),
                          );

                          if (confirmAction != null) {
                            if (confirmAction == "delete") {
                              widget.itemsList.removeAt(index);
                              setState(() {});
                            }
                            widget.onload();
                          }
                        },
                        leading: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.itemsList[index]["id"]
                                .toString()
                                .padLeft(5, "0"),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        title: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            changeTheDateWriting(
                                widget.itemsList[index]["date"]),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        subtitle: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            nameClient,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  numberFormat.format(
                                    widget.itemsList[index]["value_total"],
                                  ),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.itemsList[index]["situation"],
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  );
                },
              );
  }
}
