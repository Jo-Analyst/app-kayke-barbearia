import 'package:app_kaike_barbearia/app/models/service_model.dart';
import 'package:app_kaike_barbearia/app/utils/cache.dart';
import 'package:app_kaike_barbearia/app/utils/search_list.dart';
import 'package:flutter/material.dart';

class ServiceProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items {
    return [
      ..._items
        ..sort((a, b) => a["description"]
            .toString()
            .toLowerCase()
            .compareTo(b["description"].toString().toLowerCase()))
    ];
  }

  Future<void> save(Map<String, dynamic> data) async {
    int lastId = await Service(
      id: data["id"],
      description: data["description"],
      price: data["price"],
    ).save();

    if (data["id"] > 0) {
      deleteItem(data["id"]);
    }

    final dataService = {
      "id": data["id"] == 0 ? lastId : data["id"],
      "description": data["description"],
      "price": data["price"],
    };

    _items.add(dataService);

    notifyListeners();
  }

  Future<void> delete(int id) async {
    Service.delete(id);
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
    final services = await Service.findAll();
    itemsFiltered.addAll(services);
    _items.addAll(services);
  }

  Future<void> searchDescription(String description) async {
    clear();
    _items = searchItems(description, itemsFiltered, "description");
    notifyListeners();
  }
}
