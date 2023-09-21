import 'package:app_kayke_barbearia/app/utils/cache.dart';
import 'package:app_kayke_barbearia/app/utils/search_list.dart';
import 'package:flutter/material.dart';

import '../models/expense_model.dart';

class ExpenseProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items {
    return [
      ..._items
        ..sort(
          (a, b) {
            final dateComparison = b["date"]
                .toString()
                .toLowerCase()
                .compareTo(a["date"].toString().toLowerCase());

            if (dateComparison != 0) {
              return dateComparison; // Compara as datas primeiro
            } else {
              return a["name_product"].toString().toLowerCase().compareTo(b[
                      "name_product"]
                  .toString()
                  .toLowerCase()); // Compara os nomes em caso de empate nas datas
            }
          },
        )
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
      deleteItem(data["id"]);
    }
    final dataExpense = {
      "id": data["id"] == 0 ? lastId : data["id"],
      "name_product": data["name_product"],
      "price": data["price"],
      "quantity": data["quantity"],
      "date": data["date"],
      "subtotal": data["price"] * data["quantity"]
    };

    _items.add(dataExpense);
    itemsFiltered.add(dataExpense);

    notifyListeners();
  }

  Future<void> delete(int id) async {
    Expense.delete(id);
    deleteItem(id);
    notifyListeners();
  }

 void deleteItem(int id) {
    _items.removeWhere((item) => item["id"] == id);
    itemsFiltered.removeWhere((item) => item["id"] == id);
  }

 void clear() {
    _items.clear();
  }

  Future<void> load() async {
    clear();
    itemsFiltered.clear();
    final expenses = await Expense.findAll();
    List<Map<String, dynamic>> newItems = [];
    for (var expense in expenses) {
      newItems.add({
        "id": expense["id"],
        "name_product": expense["name_product"],
        "price": expense["price"],
        "quantity": expense["quantity"],
        "date": expense["date"],
        "subtotal": expense["price"] * expense["quantity"]
      });
    }
    _items.addAll(newItems);
    itemsFiltered.addAll(newItems);
  }

  Future<void> searchName(String nameProduct) async {
    clear();
    final expenses = searchItems(nameProduct, itemsFiltered, "name_product");
    List<Map<String, dynamic>> newItems = [];
    for (var expense in expenses) {
      newItems.add({
        "id": expense["id"],
        "name_product": expense["name_product"],
        "price": expense["price"],
        "quantity": expense["quantity"],
        "date": expense["date"],
        "subtotal": expense["price"] * expense["quantity"]
      });
    }
    _items = newItems;
    notifyListeners();
  }
}
