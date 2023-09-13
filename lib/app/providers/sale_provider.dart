import 'package:app_kayke_barbearia/app/models/sale_model.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

class SaleProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> get items {
    return [
      ..._items
        ..sort((a, b) =>
            a["date_sale"].toString().compareTo(b["date_sale"].toString()))
    ];
  }

  clear() {
    items.clear();
  }

  save(Map<String, dynamic> sale, List<Map<String, dynamic>> itemsSale,
      Map<String, dynamic> paymentSale) async {
    final lastId = await Sale(
      id: sale["id"] ?? 0,
      dateSale: dateFormat1.format(sale["date_sale"]),
      discount: sale["discount"],
      profitValueTotal: sale["profit_value_total"],
      valueTotal: sale["value_total"],
      clientId: sale["client_id"],
    ).save(itemsSale, paymentSale);

    _items.add({
      "id": sale["id"] ?? lastId,
      "date_sale": sale["date_sale"],
      "discount": sale["discount"],
      "profit_value_total": sale["profit_value_total"],
      "value_total": sale["value_total"],
      "client_id": sale["client_id"],
    });

    notifyListeners();
  }
}
