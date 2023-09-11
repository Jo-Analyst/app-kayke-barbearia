import 'package:app_kayke_barbearia/app/models/product_model.dart';
import 'package:app_kayke_barbearia/app/utils/search_list.dart';
import 'package:flutter/material.dart';

import '../utils/cache.dart';

class ProductProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

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

    final dataProduct = {
      "id": data["id"] == 0 ? lastId : data["id"],
      "name": data["name"],
      "cost_value": data["cost_value"],
      "sale_value": data["sale_value"],
      "profit_value": data["profit_value"],
      "quantity": data["quantity"],
    };

    if (data["id"] > 0) {
      deleteItem(data["id"]);
    }

    _items.add(dataProduct);
    itemsFiltered.add(dataProduct);

    notifyListeners();
  }

  Future<void> delete(int id) async {
    Product.delete(id);
    deleteItem(id);
    notifyListeners();
  }

  deleteItem(int id) {
    _items.removeWhere((item) => item["id"] == id);
    itemsFiltered.removeWhere((item) => item["id"] == id);
  }

  clear() {
    _items.clear();
  }

  Future<void> load() async {
    clear();
    itemsFiltered.clear();
    final products = await Product.findAll();
    itemsFiltered.addAll(products);
    _items.addAll(products);
  }

  Future<void> searchName(String name) async {
    clear();
    _items = searchItems(name, itemsFiltered, "name");
    notifyListeners();
  }
}
