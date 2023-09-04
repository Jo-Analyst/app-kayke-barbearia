import 'package:app_kaike_barbearia/app/models/client_model.dart';
import 'package:flutter/material.dart';

class ClientProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items {
    return [..._items];
  }

  Future<void> save(Map<String, dynamic> data) async {
    Client(
      id: data["id"],
      name: data["name"],
      phone: data["phone"],
      address: data["address"],
    ).save();
    notifyListeners();
  }

  Future<void> delete(int id) async {
    Client.delete(id);
    notifyListeners();
  }

  Future<void> load() async {
    final clients = await Client.findAll();
    for (var client in clients) {
      _items.add(client);
    }
  }
}
