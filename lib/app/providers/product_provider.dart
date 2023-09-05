import 'package:app_kaike_barbearia/app/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items {
    return [
      ..._items
        ..sort((a, b) => a["name"]
            .toString()
            .toLowerCase()
            .compareTo(b["name"].toString().toLowerCase()))
    ];
  }

  Future<void> save(Map<String, dynamic> data) async {
    int lastId = await Product(
      id: data["id"],
      name: data["name"],
      costValue: data["cost_value"],
      saleValue: data["sale_value"],
      profitValue: data["profit_value"],
      quantity: data["quantity"],
    ).save();

    if (data["id"] > 0) {
      _items.removeWhere((item) => item["id"] == data["id"]);
    }

    _items.add(
      {
        "id": data["id"] == 0 ? lastId : data["id"],
        "name": data["name"],
        "cost_value": data["cost_value"],
        "sale_value": data["sale_value"],
        "profit_value": data["profit_value"],
        "quantity": data["quantity"],
      },
    );

    notifyListeners();
  }

  Future<void> delete(int id) async {
    Product.delete(id);
    _items.removeWhere((item) => item["id"] == id);
    notifyListeners();
  }

  clear() {
    _items.clear();
  }

  Future<void> load() async {
    clear();
    final products = await Product.findAll();
    _items.addAll(products);
  }

  Future<void> searchName(String name) async {
    clear();
    final products = await Product.findByName(name.trim());
    _items.addAll(products);
    notifyListeners();
  }
}
