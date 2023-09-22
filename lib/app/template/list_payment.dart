import 'package:app_kayke_barbearia/app/template/details_payments.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/loading.dart';
import 'package:app_kayke_barbearia/app/utils/modal.dart';
import 'package:flutter/material.dart';

import '../utils/convert_datetime.dart';

class ListPayment extends StatelessWidget {
  final List<Map<String, dynamic>> payments;
  final String typePayment;
  final bool isService;
  final bool isLoading;

  const ListPayment({
    required this.isLoading,
    required this.isService,
    required this.typePayment,
    required this.payments,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: loading(context, 50),
          )
        : payments.isEmpty
            ? Center(
                child: Text(
                  typePayment == "vendas"
                      ? "Não há vendas realizadas neste mês"
                      : "Não há serviços prestados neste mês",
                  style: const TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
                itemCount: payments.length,
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () => showModal(
                          context,
                          DetailsPayment(
                            isService: isService,
                            payment: payments[index],
                          ),
                        ),
                        leading: Chip(
                          backgroundColor: Colors.indigo.withOpacity(.2),
                          label: Text(
                            numberFormat.format(payments[index]["value_total"]),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        title: Text(
                          changeTheDateWriting(payments[index]["date"]),
                          style: const TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          payments[index]["client_name"],
                          style: const TextStyle(fontSize: 18),
                        ),
                        trailing: Text(
                          payments[index]["situation"],
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
