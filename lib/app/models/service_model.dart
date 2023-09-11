import 'package:app_kayke_barbearia/app/config/db.dart';

class Service {
  final int? id;
  final String description;
  final double price;

  Service({
    this.id,
    required this.description,
    required this.price,
  });

  Future<int> save() async {
    int lastId = 0;
    final db = await DB.openDatabase();
    if (id == 0) {
      lastId = await db.insert("services", {
        "description": description,
        "price": price,
      });
    } else {
      await db.update("services", {"description": description, "price": price},
          where: "id = ?", whereArgs: [id]);
    }

    return lastId;
  }

  static void delete(int id) async {
    final db = await DB.openDatabase();
    await db.delete("services", where: "id = ?", whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> findAll() async {
    final db = await DB.openDatabase();
    return db.query("services", orderBy: "description");
  }

  static Future<List<Map<String, dynamic>>> findByDescription(
      String description) async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT * FROM services WHERE description LIKE '%$description%'");
  }
}
