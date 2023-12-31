import 'package:app_kayke_barbearia/app/models/provision_of_services_model.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

class ProvisionOfServiceProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> get items {
    return [
      ..._items
        ..sort((a, b) =>
            a["date_sale"].toString().compareTo(b["date_sale"].toString()))
    ];
  }

  void clear() {
    items.clear();
  }

  Future<void> save(
      Map<String, dynamic> sale,
      List<Map<String, dynamic>> itemsService,
      Map<String, dynamic> paymentService) async {
    final lastId = await ProvisionOfService(
      id: sale["id"] ?? 0,
      dateService: dateFormat1.format(sale["date_service"]),
      discount: sale["discount"],
      valueTotal: sale["value_total"],
      clientId: sale["client_id"],
    ).save(itemsService, paymentService);

    _items.add({
      "id": sale["id"] ?? lastId,
      "date_service": sale["date_service"],
      "discount": sale["discount"],
      "value_total": sale["value_total"],
      "client_id": sale["client_id"],
    });

    notifyListeners();
  }
}
