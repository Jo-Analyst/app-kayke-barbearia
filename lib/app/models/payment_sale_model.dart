import 'package:app_kayke_barbearia/app/config/db.dart';
import 'package:sqflite/sqflite.dart';

class PaymentSale {
  final int id;
  final String specie;
  final double amountPaid;
  final String datePayment;
  final int saleId;

  PaymentSale({
    required this.id,
    required this.specie,
    required this.amountPaid,
    required this.datePayment,
    required this.saleId,
  });

  Future<void> save(Transaction txn) async {
    await txn.insert(
      "payments_sales",
      {
        "specie": specie,
        "amount_paid": amountPaid,
        "date_payment": datePayment,
        "sale_id": saleId
      },
    );
  }

  Future<int> reserve() async {
    int lastId = 0;
    final db = await DB.openDatabase();
    if (id == 0) {
      lastId = await db.insert(
        "payments_sales",
        {
          "specie": specie,
          "amount_paid": amountPaid,
          "date_payment": datePayment,
          "sale_id": saleId
        },
      );
    } else {
      await db.update(
        "payments_sales",
        {
          "specie": specie,
          "amount_paid": amountPaid,
          "date_payment": datePayment,
        },
        where: "id = ?",
        whereArgs: [id],
      );
    }

    return lastId;
  }

  static Future<List<Map<String, dynamic>>> findBySaleId(int saleId) async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT id, amount_paid AS value, date_payment AS date, specie, sale_id  FROM payments_sales WHERE sale_id = ?",
        [saleId]);
  }

  static void delete(int id) async {
    final db = await DB.openDatabase();
    await db.delete("payments_sales", where: "id = ?", whereArgs: [id]);
  }

  static void deleteBySaleId(Transaction txn, int saleId) async {
    txn.delete("payments_sales", where: "sale_id = ?", whereArgs: [saleId]);
  }
}
