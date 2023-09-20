import 'package:app_kayke_barbearia/app/pages/details_sale_or_provision_of_service.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

import '../utils/convert_datetime.dart';

class ListSalesAndProvisionOfServices extends StatelessWidget {
  final List<Map<String, dynamic>> itemsList;
  final String typePayment;
  final bool isService;

  const ListSalesAndProvisionOfServices({
    required this.isService,
    required this.typePayment,
    required this.itemsList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return itemsList.isEmpty
        ? Center(
            child: Text(
              typePayment == "vendas"
                  ? "Não há vendas realizadas neste mês"
                  : "Não há serviços prestados neste mês",
              style: const TextStyle(fontSize: 20),
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: itemsList.length,
            itemBuilder: (_, index) {
              return Column(
                children: [
                  ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DetailsSaleOrProvisionOfService(
                          isService: isService,
                            itemsList: itemsList[index]),
                      ),
                    ),
                    leading: Text(
                      itemsList[index]["id"].toString().padLeft(5, "0"),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    title: Text(
                      changeTheDateWriting(itemsList[index]["date"]),
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      itemsList[index]["client_name"],
                      style: const TextStyle(fontSize: 18),
                    ),
                    trailing: Text(
                      numberFormat.format(
                        itemsList[index]["value_total"],
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
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
          );
  }
}
