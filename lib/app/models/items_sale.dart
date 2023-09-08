import 'package:sqflite/sqflite.dart';

class ItemsSale {
  Future<void> save(Transaction txn, Map<String, dynamic> itemsSale) async {
    await txn.insert("items_sales", itemsSale);
  }
}
