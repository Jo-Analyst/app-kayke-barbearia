import 'package:app_kaike_barbearia/app/config/db.dart';

class PersonalExpense {
  final int? id;
  final String nameProduct;
  final double price;
  final int quantity;
  final String date;

  PersonalExpense({
    this.id,
    required this.date,
    required this.nameProduct,
    required this.price,
    required this.quantity,
  });

  Future<int> save() async {
    int lastId = 0;
    final db = await DB.openDatabase();
    if (id == 0) {
      lastId = await db.insert("personal_expenses", {
        "name_product": nameProduct,
        "price": price,
        "quantity": quantity,
        "date": date,
      });
    } else {
      await db.update(
          "personal_expenses",
          {
            "name_product": nameProduct,
            "price": price,
            "quantity": quantity,
            "date": date,
          },
          where: "id = ?",
          whereArgs: [id]);
    }

    return lastId;
  }

  static void delete(int id) async {
    final db = await DB.openDatabase();
    await db.delete("personal_expenses", where: "id = ?", whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> findAll() async {
    final db = await DB.openDatabase();
    return db.query("personal_expenses", orderBy: "name_product");
  }

  static Future<List<Map<String, dynamic>>> findByDescription(
      String nameProduct) async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT * FROM personal_expenses WHERE name_product LIKE '%$nameProduct%'");
  }
}
