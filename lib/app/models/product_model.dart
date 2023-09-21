import 'package:app_kayke_barbearia/app/config/db.dart';
import 'package:sqflite/sqflite.dart';

class Product {
  final int? id;
  final String name;
  final double saleValue;
  final double costValue;
  final double profitValue;
  final int quantity;

  Product({
    this.id,
    required this.name,
    required this.saleValue,
    required this.costValue,
    required this.profitValue,
    required this.quantity,
  });

  Future<int> save() async {
    int lastId = 0;
    final db = await DB.openDatabase();
    if (id == 0) {
      lastId = await db.insert("products", {
        "name": name,
        "sale_value": saleValue,
        "cost_value": costValue,
        "profit_value": profitValue,
        "quantity": quantity
      });
    } else {
      await db.update(
          "products",
          {
            "name": name,
            "sale_value": saleValue,
            "cost_value": costValue,
            "profit_value": profitValue,
            "quantity": quantity
          },
          where: "id = ?",
          whereArgs: [id]);
    }

    return lastId;
  }

  static void delete(int id) async {
    final db = await DB.openDatabase();
    await db.delete("products", where: "id = ?", whereArgs: [id]);
  }

  static Future<void> updateQuantity(
      Transaction txn, int id, int quantity) async {
    await txn.rawUpdate(
        "UPDATE products set quantity = quantity - ? WHERE id = ?",
        [quantity, id]);
  }
  static Future<void> updateQuantityAfterDeleteSale(
      Transaction txn, int id, int quantity) async {
    await txn.rawUpdate(
        "UPDATE products set quantity = quantity + ? WHERE id = ?",
        [quantity, id]);
  }

  static Future<List<Map<String, dynamic>>> findAll() async {
    final db = await DB.openDatabase();
    return db.query("products", orderBy: "name");
  }

  static Future<List<Map<String, dynamic>>> findByName(String name) async {
    final db = await DB.openDatabase();
    return db.rawQuery("SELECT * FROM products WHERE name LIKE '%$name%'");
  }
  
}
