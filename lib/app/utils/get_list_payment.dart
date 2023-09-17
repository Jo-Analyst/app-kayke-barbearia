import 'package:flutter/material.dart';

List<Map<String, dynamic>> getListPayments(dynamic itemsPaymentsSales) {
  List<Map<String, dynamic>> items = [];
  int index = 0;
  for (var payment in itemsPaymentsSales) {
    items.add({
      "specie": payment["specie"],
      "quantity": payment["quantity"],
      "value": payment["value"],
    });
    if (payment["specie"].toString().toLowerCase() == "dinheiro") {
      items[index]["icon"] = const Icon(
        Icons.monetization_on,
        color: Colors.indigo,
        size: 28,
      );
    }
    if (payment["specie"].toString().toLowerCase() == "pix") {
      items[index]["icon"] = const Icon(
        Icons.pix,
        color: Colors.green,
        size: 28,
      );
    }
    if (payment["specie"].toString().toLowerCase() == "crédito" ||
        payment["specie"].toString().toLowerCase() == "débito") {
      items[index]["icon"] = const Icon(
        Icons.credit_card,
        color: Colors.purple,
        size: 28,
      );
    }
    index++;
  }
  return items;
}
