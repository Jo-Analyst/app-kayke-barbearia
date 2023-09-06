import 'package:flutter/material.dart';

import '../models/expense_model.dart';

class ExpenseProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items {
    return [
      ..._items
        ..sort((a, b) => a["name_product"]
            .toString()
            .toLowerCase()
            .compareTo(b["name_product"].toString().toLowerCase()))
    ];
  }

  Future<void> save(Map<String, dynamic> data) async {
    int lastId = await Expense(
      id: data["id"],
      nameProduct: data["name_product"],
      price: data["price"],
      quantity: data["quantity"],
      date: data["date"],
    ).save();

    if (data["id"] > 0) {
      _items.removeWhere((item) => item["id"] == data["id"]);
    }

    _items.add(
      {
        "id": data["id"] == 0 ? lastId : data["id"],
        "name_product": data["name_product"],
        "price": data["price"],
        "quantity": data["quantity"],
        "date": data["date"],
      },
    );

    notifyListeners();
  }

  Future<void> delete(int id) async {
    Expense.delete(id);
    _items.removeWhere((item) => item["id"] == id);
    notifyListeners();
  }

  clear() {
    _items.clear();
  }

  Future<void> load() async {
    clear();
    final services = await Expense.findAll();
    _items.addAll(services);
  }

  Future<void> searchName(String nameProduct) async {
    clear();
    final services = await Expense.findByDescription(nameProduct.trim());
    _items.addAll(services);
    notifyListeners();
  }
}
