import 'package:app_kayke_barbearia/app/pages/details_sale.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

import '../utils/convert_datetime.dart';

class ListSalesAndServices extends StatelessWidget {
  final List<Map<String, dynamic>> list;
  final String typePayment;
  final bool isService;

  const ListSalesAndServices({
    required this.isService,
    required this.typePayment,
    required this.list,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
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
            // physics: NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (_, index) {
              return Column(
                children: [
                  ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DetailsSale(list: list[index]),
                      ),
                    ),
                    leading: Text(
                      list[index]["id"].toString().padLeft(5, "0"),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    title: Text(
                      changeTheDateWriting(list[index]["date"]),
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      list[index]["client_name"],
                      style: const TextStyle(fontSize: 18),
                    ),
                    trailing: Text(
                      numberFormat.format(
                        list[index]["value_total"],
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
