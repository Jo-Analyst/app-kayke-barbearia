import 'package:flutter/material.dart';

import '../utils/convert_datetime.dart';
import '../utils/convert_values.dart';
import '../utils/icon_by_specie.dart';

class ListTilePaymentReceipt extends StatelessWidget {
  final dynamic receipt;
  const ListTilePaymentReceipt({required this.receipt, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      leading: IconBySpecie(
        specie: receipt["specie"],
      ),
      title: Text(
        numberFormat.format(
          receipt["value"],
        ),
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: Text(
        receipt["specie"],
        style: const TextStyle(fontSize: 16),
      ),
      trailing: Text(
        changeTheDateWriting(receipt["date"]),
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
