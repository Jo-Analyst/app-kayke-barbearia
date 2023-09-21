import 'package:app_kayke_barbearia/app/pages/details_sale_or_provision_of_service.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

import '../utils/convert_datetime.dart';

class ListSalesAndProvisionOfServices extends StatefulWidget {
  final List<Map<String, dynamic>> itemsList;
  final String typePayment;
  final bool isService;
  final Function() onload;

  const ListSalesAndProvisionOfServices({
    required this.isService,
    required this.typePayment,
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
    return widget.itemsList.isEmpty
        ? Center(
            child: Text(
              widget.typePayment == "vendas"
                  ? "Não há vendas realizadas neste mês"
                  : "Não há serviços prestados neste mês",
              style: const TextStyle(fontSize: 20),
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.itemsList.length,
            itemBuilder: (_, index) {
              return Column(
                children: [
                  ListTile(
                    onTap: () async {
                      final confirmAction = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => DetailsSaleOrProvisionOfService(
                              isService: widget.isService,
                              itemsList: widget.itemsList[index]),
                        ),
                      );

                      if (confirmAction != null) {
                        if (confirmAction == "delete") {
                          widget.itemsList.removeAt(index);
                          setState(() {});
                        } else {}
                        widget.onload();
                      }
                    },
                    leading: Text(
                      widget.itemsList[index]["id"].toString().padLeft(5, "0"),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    title: Text(
                      changeTheDateWriting(widget.itemsList[index]["date"]),
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      widget.itemsList[index]["client_name"],
                      style: const TextStyle(fontSize: 18),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          numberFormat.format(
                            widget.itemsList[index]["value_total"],
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          widget.itemsList[index]["situation"],
                          style: const TextStyle(
                            fontSize: 20,
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
