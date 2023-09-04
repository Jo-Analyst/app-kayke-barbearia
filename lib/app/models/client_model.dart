import 'package:app_kaike_barbearia/app/config/db.dart';

class Client {
  final int? id;
  final String name;
  final String? phone;
  final String? address;

  Client({
    this.id,
    required this.name,
    this.phone,
    this.address,
  });

  void save() async {
    final db = await DB.openDatabase();
    if (id == 0) {
      await db.insert("clients", {"name": name, "phone": phone ?? "", "address": address ?? ""});
    } else {
      await db.update("clients", {"name": name, "phone": phone ?? "", "address": address ?? ""},
          where: "id = ?", whereArgs: [id]);
    }
  }

 static void delete(int id) async {
    final db = await DB.openDatabase();
    await db.delete("clients", where: "id = ?", whereArgs: [id]);
  }

 static Future<List<Map<String, dynamic>>> findAll() async {
    final db = await DB.openDatabase();
    return db.query("clients", orderBy: "name");
  }
}
