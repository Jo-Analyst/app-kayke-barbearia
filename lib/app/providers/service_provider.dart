import 'package:app_kaike_barbearia/app/models/service_model.dart';
import 'package:flutter/material.dart';

class ServiceProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

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
      _items.removeWhere((item) => item["id"] == data["id"]);
    }

    _items.add(
      {
        "id": data["id"] == 0 ? lastId : data["id"],
        "description": data["description"],
        "price": data["price"],
      },
    );

    notifyListeners();
  }

  Future<void> delete(int id) async {
    Service.delete(id);
    _items.removeWhere((item) => item["id"] == id);
    notifyListeners();
  }

  clear() {
    _items.clear();
  }

  Future<void> load() async {
    clear();
    final services = await Service.findAll();
    _items.addAll(services);
  }

  Future<void> searchDescription(String description) async {
    clear();
    final services = await Service.findByDescription(description.trim());
    _items.addAll(services);
    notifyListeners();
  }
}
