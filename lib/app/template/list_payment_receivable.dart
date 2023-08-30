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
    return ListView.builder(
      itemCount: widget.toReceive.length,
      itemBuilder: (_, index) {
        return Column(
          children: [
            ListTile(
              title: Text(
                widget.toReceive[index]["date_sale"],
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                widget.toReceive[index]["specie"],
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Divider(
              height: 0,
              color: Theme.of(context).primaryColor,
            ),
          ],
        );
      },
    );
  }
}
