import 'package:app_kaike_barbearia/app/models/client_model.dart';
import 'package:app_kaike_barbearia/app/utils/search_list.dart';
import 'package:flutter/material.dart';

import '../utils/cache.dart';

class ClientProvider extends ChangeNotifier {
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
    int lastId = await Client(
      id: data["id"],
      name: data["name"],
      phone: data["phone"],
      address: data["address"],
    ).save();

    Map<String, dynamic> dataCliente = {
      "id": data["id"] == 0 ? lastId : data["id"],
      "name": data["name"],
      "phone": data["phone"],
      "address": data["address"],
    };

    if (data["id"] > 0) {
      _items.removeWhere((item) => item["id"] == data["id"]);
      itemsFiltered.removeWhere((item) => item["id"] == data["id"]);
    }

    _items.add(dataCliente);
    itemsFiltered.add(dataCliente);

    notifyListeners();
  }

  Future<void> delete(int id) async {
    Client.delete(id);
    _items.removeWhere((item) => item["id"] == id);
    itemsFiltered.removeWhere((item) => item["id"] == id);
    notifyListeners();
  }

  clear() {
    _items.clear();
  }

  Future<void> load() async {
    clear();
    itemsFiltered.clear();
    final clients = await Client.findAll();
    itemsFiltered.addAll(clients);
    _items.addAll(clients);
  }

  Future<void> searchName(String name) async {
    clear();
    _items = searchItems(name, itemsFiltered, "name");
    notifyListeners();
  }
}
