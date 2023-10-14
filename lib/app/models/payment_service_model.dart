import 'package:app_kayke_barbearia/app/config/db.dart';
import 'package:sqflite/sqflite.dart';

class PaymentService {
  final int id;
  final String specie;
  final double amountPaid;
  final String datePayment;
  final int provisionOfServiceId;

  PaymentService({
    required this.id,
    required this.specie,
    required this.amountPaid,
    required this.datePayment,
    required this.provisionOfServiceId,
  });

  Future<void> save(Transaction txn) async {
    await txn.insert(
      "payments_services",
      {
        "specie": specie,
        "amount_paid": amountPaid,
        "date_payment": datePayment,
        "provision_of_service_id": provisionOfServiceId
      },
    );
  }

  Future<int> reserve() async {
    int lastId = 0;
    final db = await DB.openDatabase();
    if (id == 0) {
      lastId = await db.insert(
        "payments_services",
        {
          "specie": specie,
          "amount_paid": amountPaid,
          "date_payment": datePayment,
          "provision_of_service_id": provisionOfServiceId
        },
      );
    } else {
      await db.update(
        "payments_services",
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

  static Future<List<Map<String, dynamic>>> findByProvisionOfServiceId(int provisionOfServiceId) async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT id, amount_paid AS value, date_payment AS date, specie, provision_of_service_id  FROM payments_services WHERE provision_of_service_id = ?",
        [provisionOfServiceId]);
  }

  static void delete(int id) async {
    final db = await DB.openDatabase();
    await db.delete("payments_services", where: "id = ?", whereArgs: [id]);
  }

  static void deleteByProvisionOfServiceId(Transaction txn, int provisionOfServiceId) async {
    txn.delete("payments_services", where: "provision_of_service_id = ?", whereArgs: [provisionOfServiceId]);
  }
}
