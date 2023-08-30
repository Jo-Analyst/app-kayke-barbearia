import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

class ListPaymentReceivable extends StatefulWidget {
  final List<Map<String, dynamic>> toReceive;
  const ListPaymentReceivable({required this.toReceive, super.key});

  @override
  State<ListPaymentReceivable> createState() => _ListPaymentReceivableState();
}

class _ListPaymentReceivableState extends State<ListPaymentReceivable> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) => Divider(
        height: 0,
        color: Theme.of(context).primaryColor,
      ),
      itemCount: widget.toReceive.length,
      itemBuilder: (_, index) {
        return ListTile(
          leading: Chip(
            backgroundColor: Colors.indigo.withOpacity(.2),
            label: Text(
              numberFormat.format(widget.toReceive[index]["value"]),
              style: const TextStyle(fontSize: 18),
            ),
          ),
          title: Text(
            widget.toReceive[index]["date_sale"],
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            widget.toReceive[index]["client_name"],
            style: const TextStyle(fontSize: 18),
          ),
          trailing: Text(
            widget.toReceive[index]["situation"],
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
        );
      },
    );
  }
}
