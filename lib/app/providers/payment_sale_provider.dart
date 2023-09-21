import 'package:app_kayke_barbearia/app/models/payment_sale_model.dart';
import 'package:flutter/material.dart';

class PaymentSaleProvider extends ChangeNotifier {
  double _amountReceived = 0;

  double get amountReceived {
    return _amountReceived;
  }

  final List<Map<String, dynamic>> _items = [];

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

  void clear() {
    _items.clear();
  }

  Future<void> loadById(int saleId) async {
    clear();
    final payments = await PaymentSale.findBySaleId(saleId);
    _items.addAll(payments);
    calculateAmountReceived();
  }

  void save(dynamic data) async {
    int lastId = await PaymentSale(
      id: data["id"],
      amountPaid: data["value"],
      datePayment: data["date"],
      specie: data["specie"],
      saleId: data["sale_id"],
    ).reserve();

    Map<String, dynamic> dataPayment = {
      "id": data["id"] == 0 ? lastId : data["id"],
      "value": data["value"],
      "date": data["date"],
      "specie": data["specie"],
      "sale_id": data["sale_id"],
    };

    if (data["id"] > 0) {
      deleteItem(data["id"]);
    }

    _items.add(dataPayment);
    calculateAmountReceived();
    notifyListeners();
  }

  Future<void> delete(int id) async {
    PaymentSale.delete(id);
    deleteItem(id);
    calculateAmountReceived();
    notifyListeners();
  }

  void deleteItem(int id) {
    _items.removeWhere((item) => item["id"] == id);
  }

  void calculateAmountReceived() {
    _amountReceived = 0;
    for (var item in _items) {
      _amountReceived += item["value"];
    }
  }
}
