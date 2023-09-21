import 'package:app_kayke_barbearia/app/config/db.dart';
import 'package:sqflite/sqflite.dart';

class ItemsSale {
  Future<void> save(Transaction txn, Map<String, dynamic> itemsSale) async {
    await txn.insert("items_sales", itemsSale);
  }

  Future<List<Map<String, dynamic>>> findBySaleId(int saleId) async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT products.id, products.name, items_sales.quantity, items_sales.sub_total FROM items_sales INNER JOIN products ON products.id = items_sales.product_id  WHERE sale_id = ?",
        [saleId]);
  }

  static void deleteBySaleId(Transaction txn, int saleId) async {
    txn.delete("items_sales", where: "sale_id = ?", whereArgs: [saleId]);
  }
}
