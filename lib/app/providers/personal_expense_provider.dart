import 'package:app_kayke_barbearia/app/utils/cache.dart';
import 'package:app_kayke_barbearia/app/utils/search_list.dart';
import 'package:flutter/material.dart';

import '../models/personal_expense_model.dart';

class PersonalExpenseProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

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
    int lastId = await PersonalExpense(
      id: data["id"],
      nameProduct: data["name_product"],
      price: data["price"],
      quantity: data["quantity"],
      date: data["date"],
    ).save();

    if (data["id"] > 0) {
      deleteItem(data["id"]);
    }
    final dataPersonalExpense = {
      "id": data["id"] == 0 ? lastId : data["id"],
      "name_product": data["name_product"],
      "price": data["price"],
      "quantity": data["quantity"],
      "date": data["date"],
      "subtotal": data["price"] * data["quantity"]
    };

    _items.add(dataPersonalExpense);
    itemsFiltered.add(dataPersonalExpense);

    notifyListeners();
  }

  Future<void> delete(int id) async {
    PersonalExpense.delete(id);
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
    final personalExpenses = await PersonalExpense.findAll();
    List<Map<String, dynamic>> newItems = [];
    for (var personalExpense in personalExpenses) {
      newItems.add({
        "id": personalExpense["id"],
        "name_product": personalExpense["name_product"],
        "price": personalExpense["price"],
        "quantity": personalExpense["quantity"],
        "date": personalExpense["date"],
        "subtotal": personalExpense["price"] * personalExpense["quantity"]
      });
    }
    _items.addAll(newItems);
    itemsFiltered.addAll(newItems);
  }

  Future<void> searchName(String nameProduct) async {
    clear();
    final personalExpenses =
        searchItems(nameProduct, itemsFiltered, "name_product");
    List<Map<String, dynamic>> newItems = [];
    for (var personalExpense in personalExpenses) {
      newItems.add({
        "id": personalExpense["id"],
        "name_product": personalExpense["name_product"],
        "price": personalExpense["price"],
        "quantity": personalExpense["quantity"],
        "date": personalExpense["date"],
        "subtotal": personalExpense["price"] * personalExpense["quantity"]
      });
    }
    _items = newItems;
    notifyListeners();
  }
}
