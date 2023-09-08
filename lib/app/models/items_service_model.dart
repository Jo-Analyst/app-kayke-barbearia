import 'package:sqflite/sqflite.dart';

class ItemsService {
  Future<void> save(Transaction txn, Map<String, dynamic> itemsSale) async {
    await txn.insert("items_services", itemsSale);
  }
}
