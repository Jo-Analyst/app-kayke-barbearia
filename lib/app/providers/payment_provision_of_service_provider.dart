import 'package:app_kayke_barbearia/app/models/payment_service_model.dart';
import 'package:flutter/material.dart';

class PaymentProvisionOfServiceProvider extends ChangeNotifier {
  double _amountReceived = 0;

  double get amountReceived {
    return _amountReceived;
  }

  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items {
    return [
      ..._items
        ..sort(
          (a, b) => b["date"].toString().compareTo(
                b["date"].toString(),
              ),
        )
    ];
  }

  clear() {
    _items.clear();
  }

  loadById(int provisionOfServiceId) async {
    clear();
    final payments = await PaymentService.findBySaleId(provisionOfServiceId);
    _items.addAll(payments);
    calculateAmountReceived();
  }

  save(dynamic data) async {
    int lastId = await PaymentService(
      id: data["id"],
      amountPaid: data["value"],
      datePayment: data["date"],
      specie: data["specie"],
      provisionOfServiceId: data["provision_of_service_id"],
    ).reserve();

    Map<String, dynamic> dataPayment = {
      "id": data["id"] == 0 ? lastId : data["id"],
      "value": data["value"],
      "date": data["date"],
      "specie": data["specie"],
      "provision_of_service_id": data["provision_of_service_id"],
    };

    if (data["id"] > 0) {
      deleteItem(data["id"]);
    }

    _items.add(dataPayment);
    calculateAmountReceived();
    notifyListeners();
  }

  Future<void> delete(int id) async {
    PaymentService.delete(id);
    deleteItem(id);
    calculateAmountReceived();
    notifyListeners();
  }

  deleteItem(int id) {
    _items.removeWhere((item) => item["id"] == id);
  }

  calculateAmountReceived() {
    _amountReceived = 0;
    for (var item in _items) {
      _amountReceived += item["value"];
    }
  }
}