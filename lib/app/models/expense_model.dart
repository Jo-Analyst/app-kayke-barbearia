import 'package:app_kaike_barbearia/app/config/db.dart';

class Expense {
  final int? id;
  final String nameProduct;
  final double price;
  final int quantity;

  Expense({
    this.id,
    required this.nameProduct,
    required this.price,
    required this.quantity,
  });

  Future<int> save() async {
    int lastId = 0;
    final db = await DB.openDatabase();
    if (id == 0) {
      lastId = await db.insert("expenses", {
        "name_product": nameProduct,
        "price": price,
        "quantity": quantity,
      });
    } else {
      await db.update("expenses", {"name_product": nameProduct, "price": price, "quantity": quantity},
          where: "id = ?", whereArgs: [id]);
    }

    return lastId;
  }

  static void delete(int id) async {
    final db = await DB.openDatabase();
    await db.delete("expenses", where: "id = ?", whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> findAll() async {
    final db = await DB.openDatabase();
    return db.query("expenses", orderBy: "name_product");
  }

  static Future<List<Map<String, dynamic>>> findByDescription(
      String nameProduct) async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT * FROM expenses WHERE name_product LIKE '%$nameProduct%'");
  }
}
