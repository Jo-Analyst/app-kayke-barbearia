import 'package:app_kaike_barbearia/app/models/client_model.dart';
import 'package:flutter/material.dart';

class ClientProvider extends ChangeNotifier {
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
    int lastId = await Client(
      id: data["id"],
      name: data["name"],
      phone: data["phone"],
      address: data["address"],
    ).save();

    if (data["id"] > 0) {
      _items.removeWhere((item) => item["id"] == data["id"]);
    }

    _items.add(
      {
        "id": data["id"] == 0 ? lastId : data["id"],
        "name": data["name"],
        "phone": data["phone"],
        "address": data["address"],
      },
    );

    notifyListeners();
  }

  Future<void> delete(int id) async {
    Client.delete(id);
    _items.removeWhere((item) => item["id"] == id);
    notifyListeners();
  }

  clear() {
    _items.clear();
  }

  Future<void> load() async {
    clear();
    final clients = await Client.findAll();
    _items.addAll(clients);
  }

  Future<void> searchName(String name) async {
    clear();
    final clients = await Client.findByName(name.trim());    
    _items.addAll(clients);
    notifyListeners();
  }
}
