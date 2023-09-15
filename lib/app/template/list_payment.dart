import 'package:app_kayke_barbearia/app/template/details_payments.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/modal.dart';
import 'package:flutter/material.dart';

class ListPayment extends StatefulWidget {
  final List<Map<String, dynamic>> payments;
  const ListPayment({required this.payments, super.key});

  @override
  State<ListPayment> createState() => _ListPaymentState();
}

class _ListPaymentState extends State<ListPayment> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                  numberFormat.format(widget.payments[index]["value_total"]),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              title: Text(
                widget.payments[index]["date_sale"],
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                widget.payments[index]["client_name"] ?? "Cliente avulso",
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
