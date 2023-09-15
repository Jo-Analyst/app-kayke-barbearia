import 'package:app_kayke_barbearia/app/template/details_payments.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/modal.dart';
import 'package:flutter/material.dart';

import '../utils/convert_datetime.dart';

class ListPayment extends StatefulWidget {
  final List<Map<String, dynamic>> payments;
  final String typePayment;
  const ListPayment({
    required this.typePayment,
    required this.payments,
    super.key,
  });

  @override
  State<ListPayment> createState() => _ListPaymentState();
}

class _ListPaymentState extends State<ListPayment> {
  @override
  Widget build(BuildContext context) {
    return widget.payments.isEmpty
        ? Center(
            child: Text(
              widget.typePayment == "vendas"
                  ? "Não há vendas realizadas neste mês"
                  : "Não há serviços prestados neste mês",
              style: const TextStyle(fontSize: 20),
            ),
          )
        : ListView.builder(
            itemCount: widget.payments.length,
            itemBuilder: (_, index) {
              return Column(
                children: [
                  ListTile(
                    onTap: () => showModal(
                      context,
                      DetailsPayment(
                        payment: widget.payments[index],
                      ),
                    ),
                    leading: Chip(
                      backgroundColor: Colors.indigo.withOpacity(.2),
                      label: Text(
                        numberFormat
                            .format(widget.payments[index]["value_total"]),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    title: Text(
                      changeTheDateWriting(widget.payments[index]["date"]),
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      widget.payments[index]["client_name"],
                      style: const TextStyle(fontSize: 18),
                    ),
                    trailing: Text(
                      widget.payments[index]["situation"],
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
